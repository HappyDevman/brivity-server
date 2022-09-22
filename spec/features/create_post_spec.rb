# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe 'Creating Post', type: :feature do
  before do
    sign_in(current_user, scope: nil)
  end

  let(:current_user) { create(:user) }
  let(:post_title) { 'Post Title 09/03' }
  let(:post_content) { 'Test Content' }

  it 'creates new post' do
    visit '/posts/new'
    within('#post_form') do
      fill_in 'post[title]', with: post_title
      fill_in 'post[content]', with: post_content
    end
    click_button 'Save'
    expect(page).to have_content('The post has been created successfully.')
    expect(page).to have_content(post_title)
  end
end
