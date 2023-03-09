class HomeController < ApplicationController

  before_action { @pagy_locale = I18n.locale.to_s }

  def index
    Pagy::DEFAULT[:items] = 9
    @tags = Tag.all.limit(5)
    @posts = Post.all.order(created_at: :desc)
    @pagy, @records = pagy(@posts)
  end
end
