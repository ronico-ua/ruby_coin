# frozen_string_literal: true

class PostController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags.all
    @similar_posts = @post.similar_posts
  end
end
