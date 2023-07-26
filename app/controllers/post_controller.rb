# frozen_string_literal: true

class PostController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags.all
    @similar_posts = similar_posts(@post)
  end

  private

  def similar_posts(post)
    post_tags = post.tags.pluck(:id)
    Post.joins(:tags).where(tags: { id: post_tags }).where.not(id: post.id).distinct.limit(3)
  end
end
