class Api::V1::UsermailsController < Api::V1::ApplicationController

  def index
    # @usermails = Usermail.all
    # http://localhost:3000/api/v1/usermails?to_user_id=2
    @mails_of_the_user_to_show = params[:to_user_id]
    @usermails = Usermail.with_to_user_id(@mails_of_the_user_to_show)
  end

  def show
    @usermail = Usermail.find(params[:id])
  end
end
