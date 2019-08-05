module Slugify

  module InstanceMethods
    # Strip special characters and replace with "-"
    def slug 
      name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      # name.parameterize
    end
  end

  module ClassMethods
    # Return object from database based on slug
    def find_by_slug(slug)
      self.all.find{ |obj| obj.slug == slug}
    end
  end

end