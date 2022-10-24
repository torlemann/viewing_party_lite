class User < ApplicationRecord
    has_many :hosted_viewing_parties, class_name: "ViewingParty", foreign_key: 'host_id'
    has_many :viewing_party_invitees
    has_many :viewing_parties, through: :viewing_party_invitees

    has_secure_password
    validates_presence_of :name, :email, :password_digest
    validates_uniqueness_of :email
    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, message: "is not formatted correctly"

    def self.all_except(user_id)
        where.not(id: user_id)
    end
end