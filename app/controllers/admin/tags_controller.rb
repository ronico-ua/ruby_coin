# frozen_string_literal: true

module Admin
  class TagsController < ApplicationController
    before_action :authorize_policy
    before_action :set_tag!, only: %i[destroy edit update]

    def index
      @tag = Tag.new
      @tags = policy_scope(Tag).order(created_at: :desc)
      @pagy, @tags = pagy(@tags, items: 8)
    end

    def new
      @tag = Tag.new
    end

    def edit; end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        respond_to do |format|
          format.html do
            flash[:success] = t('.success')
            redirect_to admin_tags_path, status: :see_other
          end
        end
      else
        render 'index'
      end
    end

    def update
      if @tag.update(tag_params)
        respond_to do |format|
          format.html do
            flash[:success] = t('.success')
            redirect_to admin_tags_path, status: :see_other
          end

          format.turbo_stream { flash.now[:success] = t('.success') }
        end
      else
        render 'index'
      end
    end

    def destroy
      @tag.destroy

      respond_to do |format|
        format.html do
          flash[:success] = t('.success')
          redirect_to admin_tags_path, status: :see_other
        end

        format.turbo_stream { flash.now[:success] = t('.success') }
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:title)
    end

    def set_tag!
      @tag = Tag.find params[:id]
    end

    def authorize_policy
      authorize Tag
    end
  end
end
