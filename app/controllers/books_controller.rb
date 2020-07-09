class BooksController < ApplicationController
     before_action :authenticate_user!
     before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
     #(ログインユーザー以外の人が情報を遷移しようとした時に制限をかける)

	
	
	
	def create
        @user = current_user
		@book = Book.new(book_params)
        @book.user_id = (current_user.id)
	    if @book.save
        flash[:notice] = "You have creatad book successfully."
		redirect_to  book_path(@book.id)
        # redirect_to "/books/#{@book.id}"

            else
                @books = Book.all
                flash[:notice] = ' errors prohibited this obj from being saved:'
                render "index"
            end
        
        # book = Book.find(params[:post_image_id])
        #     comment = current_user.book_comments.new(book_comment_params)
        #     comment.book_id = book.id
        #     comment.save
        #     redirect_to book_path(book)
	end

    def show
        @user = current_user
    	@book = Book.find(params[:id])
    	@book_new = Book.new
    	@book_comment = Book.new
    end

    def index
        @user = current_user
        @books = Book.all
        @book = Book.new
    end

    def edit
    	@book = Book.find(params[:id])
    end


    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "You have creatad book successfully."
        redirect_to  book_path(@book.id)

        else
        @books = Book.all
         flash[:notice]= ' errors prohibited this obj from being saved:'
        render "edit"
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to "/books"
        BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
        redirect_to book_path(params[:book_id])
    end

	private

    def book_params
        params.require(:book).permit(:title, :body)
    end

     def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
     end

     def  ensure_current_user
      @book = Book.find(params[:id])
        if @book.user_id != current_user.id
        redirect_to books_path
        end
     end

    def post_comment_params
        params.require(:book_comment).permit(:comment)
    end


end


