class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end

  def is_admin?
    begin
      self.email.casecmp('brian_mcdevitt@cargill.com') == 0
    rescue NoMethodError
      false
    end
  end
end
