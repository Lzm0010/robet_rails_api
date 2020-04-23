class User < ApplicationRecord
    has_many :tickets
    has_many :bets, through: :tickets
    has_many :events, through: :tickets
    has_many :teams, through: :tickets
    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    
end
