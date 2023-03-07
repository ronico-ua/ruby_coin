class HomeController < ApplicationController
  def index
    @tags = Tag.all.limit(5)
    @posts = Post.all.order(created_at: :desc).limit(30)
  end
end
