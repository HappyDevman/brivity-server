# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    sign_in(current_user)
    allow(CommentPolicy).to receive(:new).and_return(comment_policy)
  end

  let(:current_user) { create(:user) }
  let(:new_post) { create(:post, author: current_user) }
  let(:comment_policy) { instance_double(CommentPolicy, create?: true) }
  let(:valid_params) do
    {
      post_id: new_post.id,
      body: Faker::Lorem.sentence(word_count: 5)
    }
  end

  describe 'POST create' do
    before do
      post :create, params: valid_params
    end

    it { is_expected.to respond_with(:found) }
    it { is_expected.to redirect_to(post_path(new_post)) }
  end
end
