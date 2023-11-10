# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:posts).where(posts: { status: :active }).distinct.limit(5)
    @active_tags = params[:tags]

    @posts = Posts::Filter.call(collection.active, params)
    @main_post = Post.active.find_by(main_post: true)

    @pagy, @posts = pagy(@posts, items: 6, fragment: '#posts-list')
  end

  def show
    @post = resourse
    post_tags = @post.tags.limit(3)
    validator = Ahoy::VisitsValidator.new(last_visit: request.session[:last_visit])
    Ahoy::EventProcess.call(ahoy, @post, request) if validator.valid?
    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: post_tags.pluck(:title) }).limit(3)
  end

  def search
    @posts = Posts::Filter.call(collection.active, { order: 'RANDOM()' }).limit(3)

    @results = Posts::Search.call(search_params)

    @results = Posts::Filter.call(@results, params) if @results.present?
  end

  private

  def search_params
    params.permit(:query, :search_in)
  end

  def collection
    Post.all
  end

  def resourse
    PostTranslation.find_by(slug: params[:id]).post
  end
end
