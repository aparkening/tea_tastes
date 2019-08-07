class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_secure_password
  has_many :notes

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 10 }, confirmation: true
  validates :password_confirmation, presence: true

  def slug_name
    self.username
  end
end