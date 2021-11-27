class Api::V1::FollowsController < Api::V1::ApplicationController
  before_action :authorize_request, except: [:index, :create, :destroy, :isFollowed]
  def index
    @page = params.fetch(:page,"0")
    @follower_per_page = params.fetch(:limit,"2")

    pagination = " limit " + @follower_per_page + " offset " + @page
    if params[:follower_id].nil? and params[:user_id].nil?
      query = nil
    elsif params[:user_id].nil?
      query = "select * from users u where u.id in (select user_id from follows where follower_id="+params[:follower_id]+")" + pagination
    else
      query = "select * from users where id in (select follower_id from follows where user_id="+params[:user_id]+")" + pagination
    end

    if query.nil?
      @result = Follow.all
    else
      @result = Follow.connection.select_all(query).to_hash
    end

    @total = @result.length()
    render json: {:page=>@page, :limit=>@follower_per_page, :total=>@total, :follows=>@result}.to_json
  end

  def create
    @follow = Follow.new(follow_params)
    @follow.save
  end

  def destroy
    @follow = Follow.find_by(user_id: params[:user_id], follower_id: params[:follower_id])
    @follow.destroy
  end

  def isFollowed
    @follow = Follow.find_by(user_id: params[:user_id], follower_id: params[:follower_id])
    if @follow.nil?
      render json: {:res=>false}.to_json
    else
      render json: {:res=>true}.to_json
    end
  end
  def follow_params
    params.permit(:user_id, :follower_id,)
  end

end
