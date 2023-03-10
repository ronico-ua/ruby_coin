class PostController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
end
