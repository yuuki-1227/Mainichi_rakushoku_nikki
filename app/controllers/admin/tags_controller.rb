class Admin::TagsController < ApplicationController

  def index
    @tags = Genre.all
    @tag = Genre.new
  end

end