# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    before_action :set_post!, only: %i[show destroy edit update]
    before_action :fetch_tags, only: %i[new edit]

    def index
      @posts = Post.all
    end

    def show; end

    def new
      @post = Post.new
    end

    def edit; end

    def create
      @post = current_user.posts.build post_params

      if @post.save
        flash[:success] = 'Successfully created new post'
        redirect_to admin_posts_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @post.update post_params
        respond_to do |format|
          format.html do
            flash[:success] = 'Successfully updated the post' # t('.success')
            redirect_to admin_posts_path
          end

          format.turbo_stream do
            flash.now[:success] = 'Successfully updated the post' # t('.success')
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
          flash[:success] = 'Successfully deleted the post'
          redirect_to admin_posts_path, status: :see_other
        end

        format.turbo_stream { flash.now[:success] = 'Successfully deleted the post' }
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
      @tags = Tag.all
    end
  end
end
