# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @main_post = Post.find_by(main_post: true)
    @tags = Tag.joins(:posts).distinct.limit(5)
    @active_tags = params[:tags]
    @all_posts = Post.active.order(created_at: :desc)
    @posts = if @active_tags.present?
               @all_posts.joins(:tags).where(tags: { title: @active_tags }).distinct
             else
               @all_posts
             end
    @pagy, @posts = pagy(@posts, items: 6, fragment: '#posts-list')
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags.limit(3)
    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: @post.tags.pluck(:title) }).limit(3)
  end

  def search; end
end
