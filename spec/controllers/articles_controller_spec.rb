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

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe "list articles" do
    it "returns the list of articles" do
      response = get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "get article by id" do
    it "returns an article with certain id" do
      response = get :show, id: 1
      expect(response).to have_http_status(200)
    end
  end

  describe "update an existing article" do
    it "updates the specified article" do
      response = patch(:update,:id=>2,:article=>{:article_id=>"2",:author_id=>"2",:content=>"newcontent", :section_id=>"2"})
      puts response
      expect(response).to have_http_status(200)
    end
  end

  describe "post an article" do
    it "takes the parameters and return the article just post" do
      # api/v1/articles#create
      response = post(:create,:article=>{:title=>"test_title",:content=>"test_content",:author_id=>4, :section_id=>4,})
      puts response
    end
  end

  describe "delete an existing article" do
    it "deletes specified article" do
      response = delete :destroy,:id => 2
      puts response
      expect(response).to have_http_status(200)
    end
  end
end
