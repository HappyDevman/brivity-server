# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', inverse_of: :comments

  validates :body, presence: true

  default_scope { order(created_at: :desc) }
end
