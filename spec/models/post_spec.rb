# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
  end

  describe 'Model relations' do
    it { is_expected.to belong_to(:author) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
