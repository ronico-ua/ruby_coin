# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # @tags = Tag.all.limit(5)
    @tags = Tag.joins(:posts).group('tags.id').order('COUNT(posts.id) DESC').limit(5)
    @active_tags = params[:tags]
    @all_posts = Post.all.order(created_at: :desc)
    @posts = if params[:tags].present?
               @all_posts.joins(:tags).where(tags: { title: params[:tags] })
             else
               @all_posts
             end
    @pagy, @posts = pagy(@posts, items: 6)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags.all.limit(3)
    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: @post.tags.pluck(:title) }).limit(3)
  end

  def search; end
end
