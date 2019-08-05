require_relative 'concerns/slugifiable'
class Shop < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_and_belongs_to_many :notes
end