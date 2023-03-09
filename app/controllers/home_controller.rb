class HomeController < ApplicationController
  Pagy::DEFAULT[:items] = 9

  before_action { @pagy_locale = I18n.locale.to_s }

  def index
    @tags = Tag.all.limit(5)
    @posts = Post.all.order(created_at: :desc)
    @pagy, @records = pagy(@posts)
  end
end
