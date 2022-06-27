class Public::BooksController < ApplicationController
   #ログインしているか確認、ログイン状態ではない場合ログインページに移動
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:destroy]


  def rakuten_result
    #楽天ブックス
    #RakutenWebService::Books::Bookにsearchメソッド使いタイトル検索結果表示。
    if params[:keyword]
      #@books = RakutenWebService::Books::Book.search(title: params[:keyword])
      # 引数に , page: ページ数を入れると次の30件が取得できる
      # orFlag: 1で複数検索可能
      @books = RakutenWebService::Books::Total.search(keyword: params[:keyword], orFlag: 1, hits: 12)

      #検証用
      #binding.pry
      @book = Book.new
    end
  end

  def create
    @book = Book.new(book_params)
    @book_isbn = @book.isbn
    #カラの中にまずend_user_idがログインした会員idを入れる
    @book.end_user_id = current_end_user.id
    if @book_isbn != Book.find_by(isbn: :isbn)
      @book.save
      redirect_to book_path( @book), notice: "本の登録が完了しました。"
    else
      redirect_to books_path(end_user_id: current_end_user.id), alert: "選択された本はすでにご登録されています。"
    end
  end

  def index
    @end_user = EndUser.find(params[:end_user_id])
    @books = @end_user.books
    @books = @books.page(params[:page])
  end

  def destroy
    book = current_end_user.books.find(params[:id])
    book.destroy
    redirect_to books_path(end_user_id: book.end_user.id), notice: "登録本の削除が完了しました。"
  end


  def show
     @book = Book.find(params[:id])
     @review =Review.new
  end

  private

  def book_params
    params.require(:book).permit(
      :isbn,
      :title,
      :author,
      :publisher_name,
      :category_id,
      :item_caption,
      :item_url,
      :large_image_url,
      :medium_image_url
      )
  end


  def ensure_correct_end_user
    @book = Book.find(params[:id])
    @end_user = @book.end_user
    unless @end_user == current_end_user
      redirect_to root_path, alert: "他のユーザー情報を変更することはできません。"
    end
  end
end
