# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_post, only: :show
  before_action :check_present_post, only: :show

  def index
    @tags = Tag.joins(:posts).where(posts: { status: :active }).distinct.limit(5)
    @active_tags = params[:tags]

    @posts = Posts::Filter.call(active_collection, params)
    @main_post = Post.active.find_by(main_post: true)

    @pagy, @posts = pagy(@posts, items: Post::PAGY_LIMIT, fragment: '#posts-list')
  end

  def show
    process_event
    @similar_posts = Post.similar_posts(@post)
  end

  def search
    @posts = Posts::Filter.call(active_collection, { order: 'RANDOM()' }).limit(Post::LIMIT_COUNT)
    @results = Posts::Search.call(search_params)
    @results = Posts::Filter.call(@results, params) if @results.present?
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:id]) || Post.find_by(id: params[:id])
  end

  def check_present_post
    return if @post.present?

    redirect_to root_path, alert: t('home_controller.show.errors.not_found')
  end

  def search_params
    params.permit(:query, :search_in)
  end

  def active_collection
    Post.active
  end

  def last_visit_for_post
    request.session["last_visit_#{@post.id}"]
  end

  def process_event
    validator = Ahoy::VisitsValidator.new(last_visit_for_post:)
    Ahoy::EventProcess.call(ahoy, @post, request) if validator.valid?
  end
end
