# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    sign_in(current_user)
    allow(PostPolicy).to receive(:new).and_return(post_policy)
  end

  let(:current_user) { create(:user) }
  let(:post_policy) { instance_double(PostPolicy, index?: true, new?: true, create?: true, show?: true) }
  let(:new_post) { create(:post, author: current_user) }
  let(:valid_params) do
    {
      title: Faker::Lorem.sentence(word_count: 5),
      content: Faker::Lorem.sentence(word_count: 10)
    }
  end
  let(:invalid_params) do
    {
      content: Faker::Lorem.sentence(word_count: 10)
    }
  end

  describe 'GET index' do
    before do
      get :index
    end

    it { is_expected.to respond_with(:ok) }
    it { is_expected.to render_template(:index) }
  end

  describe 'GET new' do
    before do
      get :new
    end

    it { is_expected.to respond_with(:ok) }
    it { is_expected.to render_template(:new) }
  end

  describe 'POST create' do
    context 'with valid' do
      before do
        post :create, params: { post: valid_params }
      end

      it { is_expected.to respond_with(:found) }
      it { is_expected.to redirect_to(posts_path) }
    end

    context 'with invalid' do
      before do
        post :create, params: { post: invalid_params }
      end

      it { is_expected.to respond_with(:ok) }
      it { is_expected.to render_template(:new) }
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: new_post.id }
    end

    it { is_expected.to respond_with(:ok) }
    it { is_expected.to render_template(:show) }
  end
end
