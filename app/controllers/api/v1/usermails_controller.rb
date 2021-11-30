class Api::V1::UsermailsController < Api::V1::ApplicationController
  def show
    @usermail = Usermail.find(params[:id])
  end
end
