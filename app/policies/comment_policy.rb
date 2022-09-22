# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    true
  end
end
