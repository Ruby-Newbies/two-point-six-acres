class Api::V1::BaseController < ApplicationController
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable cookies (no set-cookies header in response)
  before_action :destroy_session, :set_default_request_format

  # disable the CSRF token
  skip_before_action :verify_authenticity_token

  def destroy_session
    request.session_options[:skip] = true
  end
  def set_default_request_format
    request.format = :json unless params[:format]
  end
end
