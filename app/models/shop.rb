class Shop < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_many :teas
  has_many :notes, through: :teas

  validates :name, presence: true, uniqueness: true

  def slug_name
    self.name
  end
end