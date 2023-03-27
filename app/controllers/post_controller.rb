# frozen_string_literal: true

class PostController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags.all
  end
end
