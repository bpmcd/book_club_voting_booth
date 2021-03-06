require 'test_helper'

class VotingBoothControllerTest < ActionController::TestCase
  setup do
    @election = elections(:two)
    @user = users(:bob)
    @admin_user = users(:brian)
  end

  test "should get vote" do
    get :vote, {election_id: @election}, {user_id: @user}
    assert_response :success
    assert_not_nil assigns(:ballot) 
  end

  test "should cast ballot" do
    assert_equal nil, @election.winner
    assert_difference('Vote.count', 2) do
      post :cast_ballot, { election_id: @election, ballot_data: "ranking[]=#{@election.candidates.first.id}&ranking[]=#{@election.candidates.last.id}" }, { user_id: @user }
    end
    assert_redirected_to root_path
    assert_equal "Thank you for voting!", flash[:notice]
    @election.reload
    assert_equal @election.candidates.first.name, @election.winner
  end

  test "should cast ballot and calculate winner" do
    assert_equal nil, @election.winner
    assert_difference('Vote.count', 2) do
      post :cast_ballot, { election_id: @election, ballot_data: "ranking[]=#{@election.candidates.first.id}&ranking[]=#{@election.candidates.last.id}" }, { user_id: @admin_user }
    end
    assert_redirected_to root_path
    assert_equal "Thank you for voting!", flash[:notice]
    @election.reload
    assert_equal @election.candidates.first.name, @election.winner
  end

  test "should not cast ballot" do
    original_winner = @election.winner
    assert_difference("Vote.count", 0) do
      post :cast_ballot, { election_id: @election, ballot_data: "ranking[]=#{@election.candidates.last.id}&ranking[]=#{@election.candidates.last.id}" }, { user_id: @user }
    end

    # puts @response.inspect
    # puts flash.inspect
    assert_redirected_to vote_path( election_id: @election )
    @election.reload
    assert_equal @election.winner, original_winner
  end
end
