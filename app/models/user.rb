require 'bcrypt'

class User < ActiveRecord::Base
  #note: in the db, password_hash is a column, and password is not.
  #      session_token is also a column but cannot be mass assigned
  attr_accessible :age, :last_on, :location, :password, :pic_url,
                  :profile_views, :username, :website

  has_many :questions
  has_many :answers

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
