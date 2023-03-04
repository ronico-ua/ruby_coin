# frozen_string_literal: true

module Admin
  class TagsController < ApplicationController
    before_action :set_tag!, only: %i[show destroy edit update]

    def index
      @new_tag = Tag.new
      @tags = Tag.all
    end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(post_params)

      if @tag.save
        respond_to do |format|
          format.html do
            flash[:success] = 'Successfully deleted the post'
            redirect_to admin_tags_path, status: :see_other
          end

          format.turbo_stream { flash.now[:success] = 'Successfully deleted the post' }
        end
      else
        render 'new'
      end
    end

    def destroy
      @tag.destroy

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
      params.require(:tag).permit(:name, :status)
    end

    def set_tag!
      @tag = Tag.find params[:id]
    end
  end
end
