class Log < ApplicationRecord
  belongs_to :user
  belongs_to :os
  belongs_to :device
  belongs_to :browser
  validates_presence_of :os_id, :device_id, :browser_id,:user_id
end
