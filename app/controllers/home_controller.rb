# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tags = Tag.all.limit(5)
    @posts = Post.all.order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 6)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags.all.limit(3)
    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: @post.tags.pluck(:title) }).limit(3)
  end
end
