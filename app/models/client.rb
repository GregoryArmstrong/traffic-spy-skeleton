class Client < ActiveRecord::Base

  has_many :payloads

  validates :name, presence: true
  validates :root_url, presence: true

end
