class Note < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :user
  has_and_belongs_to_many :shops

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def slug_name
    self.title
  end

end