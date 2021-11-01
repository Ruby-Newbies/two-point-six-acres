class Api::V1::CommentsController < ApplicationController
  before_action :set_default_request_format
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(article_params)
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def comment_params
    params.require(:comment).permit(:article_id, :author_id, :content,)
  end

  def set_default_request_format
    request.format = :json unless params[:format]
  end
end