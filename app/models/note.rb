class Note < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :user
  has_and_belongs_to_many :shops

  def slug_name
    self.title
  end

end