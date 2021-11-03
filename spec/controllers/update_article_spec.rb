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
    describe "update an existing article" do
      it "updates the specified article" do
        response = patch(:update,:id=>2,:article=>{:article_id=>"2",:author_id=>"2",:content=>"newcontent"})
        puts response
        expect(response).to have_http_status(200)
      end
    end
end