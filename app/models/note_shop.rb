class NoteShop < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  belongs_to :note
  belongs_to :shop
end