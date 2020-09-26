class Post < ApplicationRecord
  belongs_to :user

  enum post_type: [:text, :audio, :photo, :video]
  
end
