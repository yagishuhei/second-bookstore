class Public::BooksController < ApplicationController

  def rakuten_result
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

  def index
    @book =Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    #カラの中にまずend_user_idがログインした会員idを入れる
    @book.end_user_id = current_end_user.id
    @book.save
    redirect_to request.referer
  end

   def show
     @book = Book.find(params[:id])
    # @review =Review.new
   end

  private

  def book_params
    params.require(:book).permit(:title, :author,)

  end
end
