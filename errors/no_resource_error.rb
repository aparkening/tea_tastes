class NoResourceError < PostSiteError
  @@msg = "Resource Not Found"
  @@links = {"/" => "Go to the home page" }
  @@status = 404

  def self.msg
      @@msg
  end

  def self.links
      @@links 
  end

  def self.status
      @@status 
  end
end