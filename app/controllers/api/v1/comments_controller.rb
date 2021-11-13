class Api::V1::CommentsController < Api::V1::BaseController
  # before_action :require_login
  def index
    # http://localhost:3000/api/v1/comments?article_id=2
    @comments_of_the_article_to_show = params[:article_id]
    @comments = Comment.with_article_id(@comments_of_the_article_to_show)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def destroy
    begin
      @comment = Comment.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      render json: { errors: exception.message }, status: :unauthorized
      return
    end
    # @comment = Comment.find(params[:id])
    if @comment.nil?
      puts "comment not found"
      # render json: { error: 'wrong comment id' }, status: :wrongid
      return
    end
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = Token.decode(header)
      @current_user = User.find_by_email(@decoded[:email])
      if @current_user.role=="admin"
        @comment.destroy
      else
        render json: { error: 'unauthorized to delete' }, status: :unauthorized_delete
      end
    rescue ActiveRecord::RecordNotFound => exception
      render json: { errors: exception.message }, status: :unauthorized
    rescue JWT::DecodeError => exception
      render json: { errors: exception.message }, status: :unauthorized
    end

  end

  def comment_params
    params.require(:comment).permit(:article_id, :author_id, :content,)
  end

end