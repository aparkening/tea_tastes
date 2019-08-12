class TeasShop < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :tea
  belongs_to :shop
end