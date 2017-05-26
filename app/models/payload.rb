class Payload < ApplicationRecord
  enum kind: %i[h1 h2 h3 link]

  belongs_to :parsing

  validates :kind, presence: true
  validates :content, presence: true
end
