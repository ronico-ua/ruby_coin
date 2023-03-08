class HomeController < ApplicationController
  Pagy::DEFAULT[:items] = 9
  def index
    @tags = Tag.all.limit(5)
    @posts = Post.all.order(created_at: :desc)
    @pagy, @records = pagy(@posts)
  end
end
