# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:posts).distinct.limit(5)

    @active_tags = params[:tags]

    @main_post = Post.find_by(main_post: true)
    @posts = if params[:tags].present?
               Post.active.ordered.joins(:tags).where(tags: { title: params[:tags] }).distinct
             else
               Post.active.ordered
             end

    @pagy, @posts = pagy(@posts, items: 6, fragment: '#posts-list')
  end

  def show
    @post = Post.find(params[:id])

    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: @post.tags.pluck(:title) }).limit(3)
  end
end
