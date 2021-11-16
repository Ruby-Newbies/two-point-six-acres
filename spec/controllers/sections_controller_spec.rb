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

RSpec.describe Api::V1::SectionsController, type: :controller do
  describe "list sections" do
    it "returns the list of sections" do
      request.headers['Authorization'] = token
      response = get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "get section by id" do
    it "returns an article with certain id" do
      request.headers['Authorization'] = token
      response = get :show, id: 1
      expect(response).to have_http_status(200)
    end
  end

  describe "post a section" do
    it "takes the parameters and return the section just posted" do
      request.headers['Authorization'] = token
      response = post(:create,:section=>{:title=>"test_create_section_rspec"})
      puts response
      expect(response).to have_http_status(201)
    end
  end

  describe "delete a non-existing section" do
    it "returns bad request error" do
      request.headers['Authorization'] = token
      response = delete :destroy,:id => 100
      puts response
      expect(response).to have_http_status(400)
    end
  end

  describe "delete an existing section" do
    it "deletes specified section" do
      request.headers['Authorization'] = token
      response = delete :destroy,:id => 3
      puts response
      expect(response).to have_http_status(200)
    end
  end
end
