class Log < ApplicationRecord
  belongs_to :user
  belongs_to :operating_system
  belongs_to :device
  belongs_to :link
  validates_presence_of :operating_system_id,:user_id,:link_id
end
