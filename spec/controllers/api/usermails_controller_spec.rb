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

RSpec.describe Api::V1::UsermailsController, type: :controller do
  describe "list usermails without user_id" do
    it "returns the list of mails" do
      request.headers['Authorization'] = token
      response = get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "list usermails with user_id" do
    it "returns the list of mails with user id" do
      request.headers['Authorization'] = token
      response = get(:index, { to_user_id: 1 })
      expect(response).to have_http_status(200)
    end
  end

  describe "get usermail by id" do
    it "returns an usermail with certain id" do
      request.headers['Authorization'] = token
      response = get :show, id: 1
      expect(response).to have_http_status(200)
    end
  end

  describe "send a mail" do
    it "takes the parameters and return the mail just created" do
      request.headers['Authorization'] = token
      response = post(:create, {:from_user_id=>3,:to_user_id=>3,:content=>"mail_content_test"})
      expect(response).to have_http_status(200)
      puts response
    end
  end

  describe "update the status of an existing mail" do
    it "updates the status of the specified mail" do
      request.headers['Authorization'] = token
      response = patch(:update,id: 2,article: {status: 1})
      expect(response).to have_http_status(200)
    end
  end

end

