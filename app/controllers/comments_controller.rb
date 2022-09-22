# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    authorize_action

    comment = post.comments.new(comment_params)
    if comment.save
      redirect_to post_path(post), notice: I18n.t('comment.created')
    else
      redirect_to post_path(post), alert: comment.errors.full_messages[0]
    end
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def authorize_action(record = Comment)
    authorize(record, "#{action_name}?", policy_class: policy_class)
  end

  def policy_class
    CommentPolicy
  end

  def comment_params
    params.permit(:body).merge(author_id: current_user.id)
  end
end
