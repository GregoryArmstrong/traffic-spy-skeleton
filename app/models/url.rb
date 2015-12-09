class Url < ActiveRecord::Base

  belongs_to :client
  has_many :events
  has_many :user_agents

  validates :path, presence: true
  validates :request_type, presence: true
  validates :client_id, presence: true

end
