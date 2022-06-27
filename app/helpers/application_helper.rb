module ApplicationHelper

  #メソッド化して対応できるようにする

  #categoryを取り出し配列を取っていく上で
  def  book_category(end_user)
    end_user.books.map {|book| book.category.name}.uniq
  end
end
