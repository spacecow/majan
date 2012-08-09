class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :userid, :password, :password_confirmation

  validates :email, presence:true, uniqueness:true
  validates :userid, presence:true, uniqueness:true

  ADMIN     = 'admin'
  GOD       = 'god'
  MEMBER    = 'member'
  MINIADMIN = 'miniadmin'
  VIP       = 'vip'
  ROLES     = [GOD,ADMIN,MINIADMIN,VIP,MEMBER]

  def role?(s); roles.include?(s.to_s) end
  def roles
    ROLES.reject{|r| ((roles_mask||0) & 2**ROLES.index(r)).zero? }
  end

  class << self
    def role(s); 2**ROLES.index(s.to_s) end
  end
end
