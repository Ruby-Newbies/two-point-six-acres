require 'rails_helper'

token = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3QxQGNvbHVtYmlhLmVkdSJ9.j37nJcGK56CcADXw9BFQPuRmjLYuqE3n5-rS8OlOzjI"

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "list users" do
    it "returns the list of users" do
      response = get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "get user by id" do
    it "returns an user with certain id" do
      response = get :show, id: 1
      expect(response).to have_http_status(200)
    end
  end

  describe "valid new user registration" do
    it "register a new valid user" do
      response = post(:create,:user=>{:username=>"test3",:email=>"test3@columbia.edu",:password_digest=>"test3test3"})
      puts response
    end
  end

  describe "invalid new user registration" do
    it "returns unauthorized error" do
      response = post(:create,:user=>{:username=>"test4",:email=>"test4@163.com",:password_digest=>"test4test4"})
      puts response
      expect(response).to have_http_status(401)
    end
  end

  describe "delete an existing user" do
    it "deletes the specified user" do
      request.headers['Authorization'] = token
      response = delete :destroy,:id => 2
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "delete a non-existing user" do
    it "returns 400 bad request error" do
      request.headers['Authorization'] = token
      response = delete :destroy,:id => 50
      puts response
      expect(response).to have_http_status(400)
    end
  end

  describe "update an existing user" do
    it "updates the specified user" do
      request.headers['Authorization'] = token
      response = patch(:update,id: 2,user: {username: "test2", email: "test2@columbia.edu", password_digest: "test2test2"})
      puts response
      expect(response).to have_http_status(200)
    end
  end
  
end
