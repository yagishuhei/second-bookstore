class Public::SearchsController < ApplicationController
  def search
    @renge = params[:range]

    if @renge == "end_user"
      @end_users = EndUser.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end

end
