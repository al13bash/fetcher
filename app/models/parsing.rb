class Parsing < ApplicationRecord
  enum status: %i[pending completed failed]

  has_many :payloads

  validates :url, presence: true, url: true

  validates :success_callback_url, url: true
  validates :failure_callback_url, url: true

  scope :completed_desc, (-> { completed.order(created_at: :desc) })
end
