class Usermail < ActiveRecord::Base
  belongs_to :user

  def self.with_to_user_id(mails_of_the_user_to_show)
    if mails_of_the_user_to_show.nil?
      return Usermail.all
    else
      return Usermail.where(to_user_id: mails_of_the_user_to_show)
    end
  end
end
