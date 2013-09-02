class User < ActiveRecord::Base
  attr_accessible :age, :last_on, :location, :password_hash, :pic_url,
                  :profile_views, :username, :website

  has_many :questions
  has_many :answers
end
