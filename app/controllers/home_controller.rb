class HomeController < ApplicationController
  def index
    @tags = Tag.all.limit(5)
    @posts = Post.all.limit(30)
  end
end
