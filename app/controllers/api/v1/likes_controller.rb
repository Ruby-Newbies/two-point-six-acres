class Api::V1::LikesController < Api::V1::ApplicationController
    # before_action :authorize_request
    def index
      if params[:user_id].nil? and params[:article_id].nil?
        q = nil
      elsif params[:article_id].nil?
        q = "select * from likes where user_id=" + params[:user_id].to_s
      elsif params[:user_id].nil?
        q = "select * from likes where article_id=" + params[:article_id].to_s
      end
  
      if q.nil?
        @result = Like.all
      else
        @result = Like.connection.select_all(q).to_hash
      end
      render json: {:likes=>@result}.to_json
    end
  
    def create
      @like = Like.find_by(user_id: params[:user_id], article_id: params[:article_id])
      if @like.nil?
        @like = Like.new(like_params)
        @like.save
        return
      end
      render json: { error: 'already liked/disliked' }, status: :bad_request
    end
  
    def isLiked
      @like = Like.find_by(user_id: params[:user_id], article_id: params[:article_id])
      if @like.nil?
        render json: { :kind=>0 }.to_json
      else
        render json: { :kind=>@like.kind }.to_json
      end
    end

    def countLikes
      # filter on user_id, article_id and kind
      if not params[:kind].nil?
        if params[:user_id].nil? and params[:article_id].nil?
          q = "select count(*) from likes and kind=" + params[:kind].to_s
        elsif params[:article_id].nil?
          q = "select count(*) from likes where user_id=" + params[:user_id].to_s + " and kind=" + params[:kind].to_s
        elsif params[:user_id].nil?
          q = "select count(*) from likes where article_id=" + params[:article_id].to_s + " and kind=" + params[:kind].to_s
        else
          q = "select count(*) from likes where user_id=" + params[:user_id].to_s + 
          " and article_id=" + params[:article_id].to_s  + " and kind=" + params[:kind].to_s
        end
      else
        if params[:user_id].nil? and params[:article_id].nil?
          q = "select count(*) from likes"
        elsif params[:article_id].nil?
          q = "select count(*) from likes where user_id=" + params[:user_id].to_s
        elsif params[:user_id].nil?
          q = "select count(*) from likes where article_id=" + params[:article_id].to_s
        else
          q = "select count(*) from likes where user_id=" + params[:user_id].to_s + 
          " and article_id=" + params[:article_id].to_s
        end
      end
      @result = Like.connection.select_all(q)
      render json: {:count=>@result}.to_json
    end

    def like_params
      params.permit(:user_id, :article_id, :kind,)
    end
  
  end