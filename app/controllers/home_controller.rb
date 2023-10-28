# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:posts).where(posts: { status: :active }).distinct.limit(5)
    @active_tags = params[:tags]

    @posts = Posts::Filter.new(Post.active, params).call
    set_main_post

    @pagy, @posts = pagy(@posts, items: 6, fragment: '#posts-list')
  end

  def show
    @post = PostTranslation.find_by(slug: params[:id]).post
    post_tags = @post.tags.limit(3)

    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: post_tags.pluck(:title) }).limit(3)
  end

  def search
    @posts = Post.order('RANDOM()').limit(3)
  end

  def set_main_post
    post = Post.active.find_by(main_post: true)

    @main_post = post&.translation_present? ? post : nil
  end
end
