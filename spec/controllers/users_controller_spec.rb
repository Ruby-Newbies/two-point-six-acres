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

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "list users" do
    it "returns the list of users" do
      response = get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "new user registration" do
    it "register a new user" do
      # api/v1/users#create
      response = post(:create,:user=>{:username=>"test3",:email=>"test3@columbia.edu",:password_digest=>"test3test3"})
      puts response
    end
  end
end
