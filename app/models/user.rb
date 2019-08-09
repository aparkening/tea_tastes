class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_secure_password
  has_many :notes

  # validates :name, presence: true, on: :create
  validates :username, presence: true, uniqueness: true

  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, confirmation: true, unless: ->(u){ u.password.blank? }
  validates :password_confirmation, presence: true, on: :create
  # validates :password_confirmation, unless: ->(u){ u.password.blank? }

  def slug_name
    self.username
  end
end