module Slugifiable

  module InstanceMethods

    def slug
      self.name.downcase.gsub(" ", '-')
    end
  end

  module ClassMethods
    def find_by_slug(slugged_text)
      self.all.each.find { |obj| obj.slug == slugged_text }
    end
  end

end
