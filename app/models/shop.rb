class Shop < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_and_belongs_to_many :notes

  def slug_name
    self.name
  end
end