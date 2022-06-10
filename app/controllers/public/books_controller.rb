class Public::BooksController < ApplicationController
   #ログインしているか確認、ログイン状態ではない場合ログインページに移動
  before_action :authenticate_end_user!

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
      @book = Book.new
    end
  end



  def index
    @book =Book.new
    @books = current_end_user.books
  end

  def create
    @book = Book.new(book_params)
    #カラの中にまずend_user_idがログインした会員idを入れる
    @book.end_user_id = current_end_user.id
    @book.save
    redirect_to public_book_path(@book)
  end

   def show
     @book = Book.find(params[:id])
     @review =Review.new
   end

  private

  def book_params
    params.require(:book).permit(:isbn, :title, :author, :publisher_name, :item_price, :item_url, :large_image_url, :medium_image_url)

  end
end
