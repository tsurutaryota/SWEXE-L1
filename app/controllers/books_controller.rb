class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "本を登録しました。"
    else
      flash.now[:alert] = "本の登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book, notice: "本を更新しました。"
    else
      flash.now[:alert] = "本の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path, notice: "本を削除しました。"
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :description)
  end
end