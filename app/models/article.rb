class Article < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.with_section(section_to_show)
    if section_to_show.nil?
      return Article.all
    else
      return Article.where(section_id: section_to_show)
    end
  end

  def self.with_author(author_id_to_show)
    if author_id_to_show.nil?
      return Article.all
    else
      return Article.where(author_id:author_id_to_show)
    end
  end

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