class Api::V1::UsermailsController < Api::V1::ApplicationController
  #before_action :authorize_request
  def index
    # http://localhost:3000/api/v1/usermails?to_user_id=2
    # http://localhost:3000/api/v1/usermails?page=0&limit=1&to_user_id=2
    @page = params.fetch(:page,0).to_i
    @mails_per_page = params.fetch(:limit,2).to_i
    @mails_of_the_user_to_show = params[:to_user_id]
    @usermails = Usermail.with_to_user_id(@mails_of_the_user_to_show).offset(@page * @mails_per_page).limit(@mails_per_page)
    @total = Usermail.with_to_user_id(@mails_of_the_user_to_show).length()
    render json: {:page=>@page, :limit=>@mails_per_page, :total=>@total, :usermails=>@usermails}.to_json
  end

  def show
    @usermail = Usermail.find(params[:id])
  end

  def create
    @usermail = Usermail.new(usermail_params)
    @usermail.save
  end

  def update
    @usermail = Usermail.find(params[:id])
    # @usermail.update(usermail_params)
    @usermail.update(usermail_update_params)
  end

  def usermail_params
    params.permit(:from_user_id, :to_user_id, :content, :status,).merge(status:0)
  end

  def usermail_update_params
    params.permit(:status,)
  end
end
