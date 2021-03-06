class Note < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :user
  belongs_to :tea

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def slug_name
    self.title
  end

end