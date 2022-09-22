# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    authorize_action

    render :index, locals: { posts: Post.all }
  end

  def show
    authorize_action

    render :show, locals: { post: post }
  end

  def new
    authorize_action

    post = Post.new
    render :new, locals: { post: post }
  end

  def create
    authorize_action

    post = Post.new(post_params)
    if post.save
      redirect_to posts_path, notice: I18n.t('post.created')
    else
      render :new, locals: { post: post }
    end
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end

  def authorize_action(record = Post)
    authorize(record, "#{action_name}?", policy_class: policy_class)
  end

  def policy_class
    PostPolicy
  end

  def post_params
    params.require(:post).permit(:title, :content).merge(author_id: current_user.id)
  end
end
