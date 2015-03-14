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

  def parse
    self.inbox.each { |conversation|
      conversation['comments']['data'].each { |item|

        if item['from'] && item['from']['id']

          profile = FacebookProfile.find_or_create_by( facebook_id: item['from']['id'] )
          profile.update( name: item['from']['name'] ) if !profile.name && item['from']['name']

          message = FacebookMessage.find_or_create_by( facebook_id: item['id'] )
          message.update( profile: profile,
                          content: item['message'] ) if !message.content

        end

      }
    }
    true
  end

end
