module Slugify

  module InstanceMethods
    # Strip special characters and replace with "-"
    def slug 
      username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

  module ClassMethods
    # Return object from database based on slug
    def find_by_slug(slug)
      self.all.find{ |obj| obj.slug == slug}
    end
  end

end