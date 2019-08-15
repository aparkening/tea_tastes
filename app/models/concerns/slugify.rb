module Slugify

  module InstanceMethods
    # Strip special characters and replace with "-"
    def slug 
      # Original operation: slug_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

      # Make more unique now that sanitize removes characters
      slugged = slug_name.downcase.strip.gsub(' ', '-').gsub(/[^\w_-]/, '') + "_" + self.id.to_s
      return slugged
    end
  end

  module ClassMethods
    # Return object from database based on slug
    def find_by_slug(slug)
      self.all.find { |obj| obj.slug == slug }
    end
  end

end