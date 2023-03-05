class HomeController < ApplicationController
  def index
    @tags = Tag.all.limit(5)
  end
end
