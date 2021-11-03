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

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  describe "login with correct email and password" do
    it "successfully log in the user and return the token and username" do
      response = post :login,
                      { :email => "test1@columbia.edu", :password => "123123" }
      puts response.body
      expect(response).to have_http_status(200)
      expect(response.body).to include("token")
      expect(response.body).to include("username")
    end
  end

  describe "login with existing email and wrong password" do
    it "returns status code 401 and error message unauthorized" do
      response = post :login,
                      { :email => "test1@columbia.edu", :password => "456456" }
      puts response.body
      expect(response).to have_http_status(401)
      expect(response.body).to include("unauthorized")
    end
  end

  describe "login with a non-existing email" do
    it "returns status code 401 and error message wrong email" do
      response = post :login,
                      { :email => "test3@columbia.edu", :password => "456456" }
      puts response.body
      expect(response).to have_http_status(401)
      expect(response.body).to include("wrong email")
    end
  end

  describe "login with an empty email" do
    it "returns status code 401 and error message missing input" do
      response = post :login,
                      { :email => "", :password => "456456" }
      puts response.body
      expect(response).to have_http_status(401)
      expect(response.body).to include("missing input")
    end
  end
end
