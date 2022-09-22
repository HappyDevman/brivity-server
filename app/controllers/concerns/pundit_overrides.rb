# frozen_string_literal: true

module PunditOverrides
  extend ActiveSupport::Concern
  include Pundit

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    Rails.logger << '========== Not authorized! ==========='
  end
end
