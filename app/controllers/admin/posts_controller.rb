# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    before_action :authorize_policy
    before_action :set_post!, only: %i[show destroy edit update]
    before_action :fetch_tags, only: %i[new edit]

    def index
      @posts = Post.all.order(created_at: :desc)
      @pagy, @posts = pagy(@posts, items: 6)
    end

    def show; end

    def new
      @post = Post.new
    end

    def edit; end

    def create
      @post = current_user.posts.build post_params

      authorize @post

      if @post.save
        flash[:success] = t('.success')
        redirect_to admin_posts_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @post.update post_params
        respond_to do |format|
          format.html do
            flash[:success] = t('.success')
            redirect_to admin_posts_path
          end

          format.turbo_stream do
            flash.now[:success] = t('.success')
          end
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy

      respond_to do |format|
        format.html do
          flash[:success] = t('.success')
          redirect_to admin_posts_path, status: :see_other
        end

        format.turbo_stream { flash.now[:success] = t('.success') }
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :description, :status, :photo, tag_ids: [])
    end

    def set_post!
      @post = Post.find params[:id]
    end

    def fetch_tags
      @tags = @post.tags
    end

    def authorize_policy
      authorize Post
    end
  end
end
