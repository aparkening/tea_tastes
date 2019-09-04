class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_secure_password
  has_many :notes
  has_many :teas, through: :notes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, confirmation: true, unless: ->(u){ u.password.blank? }
  validates :password_confirmation, presence: true, on: :create

  def slug_name
    self.username
  end
end