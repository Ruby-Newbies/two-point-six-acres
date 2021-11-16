class Api::V1::CommentsController < Api::V1::ApplicationController
  # before_action :require_login
  before_action :authorize_request
  def index
    # http://localhost:3000/api/v1/comments?article_id=2
    @comments_of_the_article_to_show = params[:article_id]
    @comments = Comment.with_comment_id(@comments_of_the_article_to_show)
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

    if @current_user.role=="admin"
      @comment.destroy
    else
      render json: { error: 'unauthorized to delete' }, status: :unauthorized
    end
  end

  def comment_params
    params.require(:comment).permit(:article_id, :author_id, :content,)
  end

end
