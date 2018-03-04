class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link
validates_presence_of :user_id,:link_id  
end
