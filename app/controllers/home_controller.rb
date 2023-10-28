# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:posts).where(posts: { status: :active }).distinct.limit(5)
    @active_tags = params[:tags]

    @main_post = Post.find_by(main_post: true)
    @posts = if @active_tags.present?
               Post.active.ordered.joins(:tags).where(tags: { title: @active_tags }).distinct
             else
               Post.active.ordered
             end

    @pagy, @posts = pagy(@posts, items: 6, fragment: '#posts-list')
  end

  def show
    @post = PostTranslation.find_by(slug: params[:id]).post
    post_tags = @post.tags.limit(3)
    process_ahoy(request.remote_ip)

    if first_visit_or_more_than_24_hours?
      ahoy.track 'Viewed Post', title: @post.title, post_id: @post.id
      update_last_visit_timestamp
    end
    @similar_posts = Post.where.not(id: @post.id).includes(:tags)
                         .where(tags: { title: post_tags.pluck(:title) }).limit(3)
  end

  def search
    @posts = Post.order('RANDOM()').limit(3)
  end

  private

  def process_ahoy(remote_ip)
    @visit = Ahoy::Visit.where(ip: remote_ip).last
  end

  def first_visit_or_more_than_24_hours?
    last_visit_timestamp = session[:last_visit_timestamp]
    return true if last_visit_timestamp.nil?

    last_visit_time = Time.zone.at(last_visit_timestamp)
    24.hours.ago >= last_visit_time
  end

  def update_last_visit_timestamp
    session[:last_visit_timestamp] = Time.zone.now.to_i
  end
end
