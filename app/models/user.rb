require_relative 'concerns/slugifiable'
class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_many :notes
end