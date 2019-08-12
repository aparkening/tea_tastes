class Tea < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_many :notes
  has_many :users, through: :notes
  has_many :teas_shops
  has_many :shops, through: :teas_shops

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true  
  validates :description, presence: true

  def slug_name
    self.name
  end

end