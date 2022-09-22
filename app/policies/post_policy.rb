# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def new?
    true
  end

  def create?
    new?
  end
end
