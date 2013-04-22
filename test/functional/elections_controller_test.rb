require 'test_helper'

class ElectionsControllerTest < ActionController::TestCase
  setup do
    @election = elections(:one)
    @admin = users(:brian)
    # puts @admin
    @non_admin = users(:bob)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:elections)
  end

  test "should get new" do
    get :new, nil, user_id: @admin
    assert_response :success
  end

  test "should create election" do
    assert_difference('Election.count') do
      post :create, { election: { end_date: @election.end_date, title: @election.title }}, { user_id: @admin }
    end

    assert_redirected_to election_path(assigns(:election))
  end

  test "should show election" do
    get :show, { id: @election }, { user_id: @admin }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @election }, { user_id: @admin }
    assert_response :success
  end

  test "should update election" do
    put :update, { id: @election, election: { end_date: @election.end_date, title: @election.title }}, { user_id: @admin }
    assert_redirected_to election_path(assigns(:election))
  end

  test "should destroy election" do
    assert_difference('Election.count', -1) do
      delete :destroy, { id: @election }, { user_id: @admin }
    end

    assert_redirected_to elections_path
  end

  # non_admin tests
  test "should get index with non_admin" do
    get :index, nil, { user_id: @non_admin }
    assert_response :success
    assert_not_nil assigns(:elections)
  end

  test "should get new with non_admin" do
    get :new, nil, user_id: @non_admin
    assert_redirected_to root_path
    assert_equal "You are not authorized to access the requested page.", flash[:error]
  end

  test "should create election with non_admin" do
    assert_difference('Election.count', 0) do
      post :create, { election: { end_date: @election.end_date, title: @election.title }}, { user_id: @non_admin }
    end

    assert_redirected_to root_path
    assert_equal "You are not authorized to access the requested page.", flash[:error]
  end

  test "should show election with non_admin" do
    get :show, { id: @election }, { user_id: @non_admin }

    assert_redirected_to root_path
    assert_equal "You are not authorized to access the requested page.", flash[:error]
  end

  test "should get edit with non_admin" do
    get :edit, { id: @election }, { user_id: @non_admin }

    assert_redirected_to root_path
    assert_equal "You are not authorized to access the requested page.", flash[:error]
  end

  test "should update election with non_admin" do
    put :update, { id: @election, election: { end_date: @election.end_date, title: @election.title }}, { user_id: @non_admin }

    assert_redirected_to root_path
    assert_equal "You are not authorized to access the requested page.", flash[:error]
  end

  test "should destroy election with non_admin" do
    assert_difference('Election.count', 0) do
      delete :destroy, { id: @election }, { user_id: @non_admin }
    end

    assert_redirected_to root_path
    assert_equal "You are not authorized to access the requested page.", flash[:error]
  end
end
