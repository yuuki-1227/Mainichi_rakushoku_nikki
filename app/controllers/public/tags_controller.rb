class Public::TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

end
