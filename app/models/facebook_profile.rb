class FacebookProfile < Profile

  after_save :set_facebook_id

  def set_facebook_id
    if self.token && !self.facebook_id
      self.facebook_id = me['id']
      self.save
    end
  end

  def me
    if self.token
      graph = Koala::Facebook::API.new(self.token)
      graph.get_object("me")
    end
  end

  def inbox
    if self.token
      graph = Koala::Facebook::API.new(self.token)
      graph.get_object("me/inbox")
    end
  end

end
