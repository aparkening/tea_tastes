class Shop < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_many :teas_shops
  has_many :teas, through: :notes

  has_many :teas, through: :teas_shops
  # has_many :notes, through: :teas
  has_many :notes_shops
  has_many :notes, through: :notes_shops


  validates :name, presence: true, uniqueness: true

  def slug_name
    self.name
  end
end