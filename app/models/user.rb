class User < ApplicationRecord
    has_many :tickets
    has_many :bets, through: :tickets
    has_many :events, through: :tickets
    has_many :teams, through: :tickets
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followed_users, through: :active_relationships, source: :followed_user
    has_many :follower_users, through: :passive_relationships, source: :follower_user

    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    def record
        {
            "wins": self.wins,
            "losses": self.losses,
            "ties": self.ties
        }
    end

    def wins
        self.bets.where(outcome: "Win").count
    end

    def losses
        self.bets.where(outcome: "Loss").count
    end

    def ties
        self.bets.where(outcome: "Push").count
    end
end
