class Follow < ActiveRecord::Base

  def self.with_user(user_to_show)
    if user_to_show.nil?
      return Follow.all
    else
      return Follow.where(user_id: user_to_show)
    end
  end

  def self.with_follower(follower_to_show)
    if follower_to_show.nil?
      return Follow.all
    else
      return Follow.where(follower_id:follower_to_show)
    end
  end
end