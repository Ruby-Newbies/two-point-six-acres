class Section < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  def self.authorize(request)
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = Token.decode(header)
      @current_user = User.find_by_email(@decoded[:email])
      return @current_user
    rescue ActiveRecord::RecordNotFound => exception
      # render json: { errors: exception.message }, status: :unauthorized
      return
    rescue JWT::DecodeError => exception
      # render json: { errors: exception.message }, status: :unauthorized
      return
    end
  end
end
