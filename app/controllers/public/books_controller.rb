class Public::BooksController < ApplicationController

  def index
    #楽天ブックス
    #RakutenWebService::Books::Bookにsearchメソッド使いタイトル検索結果表示。
    if params[:keyword]
      #@books = RakutenWebService::Books::Book.search(title: params[:keyword])
      # 引数に , page: ページ数を入れると次の30件が取得できる
      # orFlag: 1で複数検索可能
      @books = RakutenWebService::Books::Total.search(keyword: params[:keyword], orFlag: 1)
      #検証用
      #binding.pry
    end
  end



  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end
end
