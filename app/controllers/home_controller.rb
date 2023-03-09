class HomeController < ApplicationController
  def index
    @tags = Tag.all.limit(5)
    @posts = Post.all.order(created_at: :desc)
    @pagy, @posts = pagy(@posts, items: 9)
  end
end
