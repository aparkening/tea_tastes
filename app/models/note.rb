class Note < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :user
  has_many :notes_shops
  has_many :shops, through: :notes_shops

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def slug_name
    self.title
  end

end