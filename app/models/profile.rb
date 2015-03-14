class Profile < ActiveRecord::Base

  belongs_to :user
  has_many   :messages

  after_create do
    self.update( user: User.create ) if !self.user
  end

end
