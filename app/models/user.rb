class User < ActiveRecord::Base

  has_many :profiles

  def name
    self.profiles.first.name if self.profiles.first
  end

end
