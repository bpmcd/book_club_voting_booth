require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @ballot = ballots(:b_one)
    @candidate = candidates(:c_one)
  end

  test "should save vote" do
    assert_difference('Vote.count') do
      Vote.create(rank: 1, candidate: @candidate , ballot: @ballot)
    end
  end
end
