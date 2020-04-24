class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  has_one :event, through: :bet
end
