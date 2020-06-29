class UsersController < ApplicationController
     before_action :authenticate_user!
     #(ログインしていない状態で他のページに遷移しようとした場合、ログインページに繊維する)
     before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
     #(ログインユーザー以外の情報を遷移しようとした時に制限をかける)



    def new
        @book = Book.new
    end



	def show
		@book = Book.new
        @user = User.find(params[:id])
        @books = @user.books

    end

    def new
        @user = User.new(user_params)
        if @user.save
         redirect_to  user_path(current_user.id)#成功の場合
        else
         render "users/sign_up"#失敗の場合
        end
    end

    def edit
        @user = User.find(params[:id])
    end

   




    def index
        @users =User.all
    	@books = Book.all
    	@book = Book.new
        @user = current_user
    end





    def update
        @user = User.find(params[:id])
       if  @user.update(user_params)
        flash[:notice] = "You have updated user successfully."

        redirect_to "/users/#{current_user.id}"
        else
        flash[:notice] = " errors prohibited this obj from being saved:"
            render :edit

       end
     end







   private
   

    def book_params
        params.require(:book).permit(:title, :body)
    end

    def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
    end

    def  ensure_current_user
        @user = User.find(params[:id])
     if @user.id != current_user.id
        redirect_to user_path(current_user.id)

     end
  end
end



