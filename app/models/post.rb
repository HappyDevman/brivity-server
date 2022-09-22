# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :posts
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  default_scope { order(created_at: :desc) }
end
