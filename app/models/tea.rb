class Tea < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :shop
  has_many :notes
  has_many :users, through: :notes

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true  
  validates :description, presence: true

  def slug_name
    self.name
  end

end