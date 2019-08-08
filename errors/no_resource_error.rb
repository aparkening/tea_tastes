class NoResourceError < PostSiteError
  @@msg = "Resource Not Found"
  @@links = {"/" => "Go Home" }
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