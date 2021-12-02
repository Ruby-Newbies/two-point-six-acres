class Api::V1::LikesController < Api::V1::ApplicationController
  before_action :authorize_request, except: [:create, :countLikes, :liked]

  def create
    if params[:user_id].nil? or params[:article_id].nil? or params[:kind].nil?
      render json: { error: 'missing input' }, status: :bad_request
      return
    end
    @like = Like.find_by(user_id: params[:user_id], article_id: params[:article_id])
    if @like.nil?
      @like = Like.new(like_params)
      @like.save
      return
    end
    render json: { error: 'already liked/disliked' }, status: :bad_request
  end

  def countLikes
    # filter on article_id and kind
    if params[:article_id].nil? or params[:kind].nil?
      render json: { errors: 'wrong condition' }, status: :bad_request
      return
    end
    @result = Like.where(article_id: params[:article_id], kind: params[:kind]).count
    render json: {:count=>@result}.to_json
  end

  def liked
    if params[:user_id].nil? or params[:article_id].nil?
      render json: { errors: 'wrong condition' }, status: :bad_request
      return
    end
    @like = Like.find_by(user_id: params[:user_id], article_id: params[:article_id])
    if @like.nil?
      render json: {:kind=>0}.to_json
    else
      render json: {:kind=>@like.kind}.to_json
    end
  end

  def like_params
    params.permit(:user_id, :article_id, :kind,)
  end
  
end