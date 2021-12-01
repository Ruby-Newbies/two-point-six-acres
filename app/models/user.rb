class User < ActiveRecord::Base
    # has_secure_password
    has_many :articles
    has_many :comments
    has_many :usermails
end
