# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    before_action :authenticate_user!, :authorize_policy
    before_action :set_post!, only: %i[show destroy edit update]
    before_action :fetch_tags, only: %i[new edit update]
    before_action :validate_localization, :normalize_main_post_param, only: %i[create update]

    def index
      @posts = Post.order(created_at: :desc)
      @pagy, @posts = pagy(@posts, items: 6)
    end

    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.build(post_params)

      authorize @post

      if @post.save
        Posts::Translator.call(@post, localization_params)

        @post.generate_slugs

        flash[:success] = t('.success')
        redirect_to admin_posts_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @post.update post_params
        Posts::Translator.call(@post, localization_params)

        @post.generate_slugs

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
      params.require(:post).permit(:title, :description, :subtitle, :status, :main_post, :photo, tag_ids: [])
    end

    def normalize_main_post_param
      params[:post][:main_post] = params[:post][:main_post] == 'active'
    end

    def localization_params
      params.require(:post).permit(title_localizations: {}, subtitle_localizations: {}, description_localizations: {})
    end

    def validate_localization
      errors = []

      localization_params.each do |field, translations|
        translations.each do |key, value|
          next if value != ''

          fieldname = field.delete_suffix('_localizations')
          errors << "#{I18n.t("activerecord.attributes.post.#{fieldname}")}: #{I18n.t(key).downcase}"
        end
      end

      flash[:warning] = "#{I18n.t('errors.messages.translation_missing')} #{errors.join(', ')}" if errors.present?
    end

    def set_post!
      @post = Post.friendly.find(params[:id])
    end

    def fetch_tags
      @tags = @post.present? ? @post.tags : []
    end

    def authorize_policy
      authorize Post
    end
  end
end
