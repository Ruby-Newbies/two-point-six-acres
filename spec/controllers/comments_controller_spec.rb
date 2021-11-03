require 'rails_helper'

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

RSpec.describe Api::V1::CommentsController, type: :controller do
  describe "list comments" do
    it "returns the list of comments" do
      response = get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "get comment by id" do
    it "returns an comment with certain id" do
      response = get :show, id: 1
      expect(response).to have_http_status(200)
    end
  end

  describe "post a comment" do
    it "takes the parameters and return the comment just post" do
      # api/v1/comments#create
      response = post(:create,:comment=>{:article_id=>3,:author_id=>3,:content=>"comment_content_test"})
      puts response
    end
  end

  describe "delete an existing comment" do
    it "finds the comment and delete it" do
      response = delete :destroy,
                        { :id => 1 }
      puts response.body
      expect(response).to have_http_status(200)
    end
  end
end
