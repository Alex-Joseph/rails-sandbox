require 'test_helper'

class MyTeamsControllerTest < ActionController::TestCase
  setup do
    @my_team = my_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_team" do
    assert_difference('MyTeam.count') do
      post :create, my_team: { league: @my_team.league, teamName: @my_team.teamName }
    end

    assert_redirected_to my_team_path(assigns(:my_team))
  end

  test "should show my_team" do
    get :show, id: @my_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @my_team
    assert_response :success
  end

  test "should update my_team" do
    patch :update, id: @my_team, my_team: { league: @my_team.league, teamName: @my_team.teamName }
    assert_redirected_to my_team_path(assigns(:my_team))
  end

  test "should destroy my_team" do
    assert_difference('MyTeam.count', -1) do
      delete :destroy, id: @my_team
    end

    assert_redirected_to my_teams_path
  end
end
