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

RSpec.describe Api::V1::FollowsController, type: :controller do

  describe "list follow list with user_id" do
    it "returns the list of articles with user id" do
      response = get(:index, { user_id: 1 })
      expect(response).to have_http_status(200)
    end
  end

  describe "list follow list with follower_id" do
    it "returns the list of articles with user id" do
      response = get(:index, { follower_id: 1 })
      expect(response).to have_http_status(200)
    end
  end

  describe "list follow list without user_id and follower_id" do
    it "returns the list of articles with user id" do
      response = get(:index, {})
      expect(response).to have_http_status(200)
    end
  end


  describe "create new follow relationship" do
    it "takes the parameters and return the follow info just post" do
      # api/v1/follows#create
      request.headers['Authorization'] = token
      response = post(:create, {user_id: 2, follower_id: 1})
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "delete an existing follow relation" do
    it "deletes specified follow relation" do
      request.headers['Authorization'] = token
      response = delete :destroy,:id => 1, :user_id=> 1, :follower_id=> 2
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "check user is followed or not" do
    it "check user is followed or not" do
      request.headers['Authorization'] = token
      response = get(:isFollowed, {user_id: 2, follower_id: 1})
      response = get(:isFollowed, {user_id: 4, follower_id: 2})
      puts response
      expect(response).to have_http_status(200)
    end
  end
end
