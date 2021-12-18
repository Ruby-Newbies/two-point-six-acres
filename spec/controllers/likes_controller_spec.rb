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

RSpec.describe Api::V1::LikesController, type: :controller do

  describe "like an article with no params" do
    it "returns bad request error" do
      request.headers['Authorization'] = token
      response = post(:create)
      puts response
      expect(response).to have_http_status(400)
    end
  end

  describe "like an article with correct params" do
    it "creates the like" do
      request.headers['Authorization'] = token
      response = post(:create, {user_id: 2, article_id: 1, kind: 1})
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "unlike an article with correct params" do
    it "creates the like" do
      request.headers['Authorization'] = token
      response = post(:create, {user_id: 2, article_id: 1, kind: 2})
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "like an article that is already liked" do
    it "returns bad request error" do
      request.headers['Authorization'] = token
      response = post(:create, {user_id: 1, article_id: 1, kind: 1})
      puts response
      expect(response).to have_http_status(400)
    end
  end

  describe "see how many people liked a specific article with no params" do
    it "returns bad request error" do
      request.headers['Authorization'] = token
      response = get(:countLikes)
      puts response
      expect(response).to have_http_status(400)
    end
  end

  describe "see how many people liked a specific article with right params" do
    it "returns the number" do
      request.headers['Authorization'] = token
      response = get(:countLikes, {article_id: 1, kind: 1})
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "see whether a user liked/disliked article with no params" do
    it "returns bad request error" do
      request.headers['Authorization'] = token
      response = get(:liked)
      puts response
      expect(response).to have_http_status(400)
    end
  end

  describe "see whether a user liked/disliked a specific article" do
    it "returns the status" do
        request.headers['Authorization'] = token
        response = get(:liked, {user_id: 1, article_id: 1})
        puts response
        expect(response).to have_http_status(200)
      end
    end
end