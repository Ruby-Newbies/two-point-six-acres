class Api::V1::CommentsController < Api::V1::BaseController
# class Api::V1::CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.nil?
      puts "comment not found"
      render json: { error: 'wrong comment id' }, status: :wrongid
      return
    end
    @comment.destroy
  end

  def comment_params
    params.require(:comment).permit(:article_id, :author_id, :content,)
  end

end