# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe 'Creating Comment', type: :feature do
  before do
    sign_in(current_user, scope: nil)
  end

  let(:current_user) { create(:user) }
  let(:new_post) { create(:post, author: current_user) }
  let(:comment_body) { 'Comment Body For Post1' }

  it 'creates new post' do
    visit post_path(new_post)
    within('#comment_form') do
      fill_in 'body', with: comment_body
    end
    click_button 'Save'
    expect(page).to have_content('The comment has been created successfully.')
    expect(page).to have_content(comment_body)
  end
end
