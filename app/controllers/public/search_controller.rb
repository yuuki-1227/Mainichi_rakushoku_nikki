class Public::SearchController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model,@content,@method)
  end

  private

  def search_for(model,content,method)
    if model == 'end_user'
      if method == 'perfect'
        EndUser.where(last_name: content)
      elsif method == 'partial'
        EndUser.where('last_name LIKE ?', '%' + content + '%')
      elsif method == 'forward_match'
        EndUser.where('last_name LIKE ?', "#{content}%")
      elsif method == 'backward_match'
        EndUser.where('last_name LIKE ?', "#{content}%")
      end
    elsif model == 'post'
      if method == 'perfect'
        Post.where(title: content)
      elsif method == 'partial'
        Post.where('title LIKE ?', '%' + content + '%')
      elsif method == 'forward_match'
        EndUser.where('title LIKE ?', "#{content}%")
      elsif method == 'backward_match'
        EndUser.where('title LIKE ?', "#{content}%")
      end
    end
  end
end
