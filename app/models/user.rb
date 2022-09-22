# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}\z/i.freeze

  has_many :posts, dependent: :destroy, inverse_of: :author, foreign_key: :author_id
  has_many :comments, dependent: :destroy, inverse_of: :author, foreign_key: :author_id

  validates :email,
            uniqueness: {
              case_sensitive: false
            },
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('invalid') }
  validates :first_name, :last_name, presence: true, allow_blank: false
  validate :password_complexity

  def parsed_fullname
    name.presence || email
  end

  def name
    [first_name, last_name].compact_blank.join(' ')
  end

  def password_complexity
    return unless password.present? && !password.match(VALID_PASSWORD_REGEX)

    errors.add(
      :password, 'Password requires 1+ upper case and lower case and 1+ number.'
    )
  end
end
