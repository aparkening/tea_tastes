class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_secure_password
  has_many :notes

  validates :username, presence: true
  validates :password, length: { minimum: 10 }
  #  validates :password, length: { minimum: 10 }, confirmation: true
end