class User < ApplicationRecord
  has_secure_password

  validates :password, :length => { :minimum => 8 }
  validates :name, :email, presence: true

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end
end
