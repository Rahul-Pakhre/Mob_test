class UsersController < ApplicationController
  # helper_method :search_column
	#before_action :logged_in_user, only: [:index, :update]
 
   def new 
     @user = User.new
   end

  def create
    Rails.logger.info"======#{params.inspect}===params"
     @user = User.create(user_params)
     if @user.save
   	 flash[:notice] = "You have signed up successfully!"
     #UserMailer.confirmation(@user).deliver
     redirect_to root_path
   else
     render 'new'
   end
  end

   def show
     @user = User.find(params[:id])
   end

   def  index
      @users = User.all
      @users = User.username(params[:search]) if params[:search]
   end
   def edit
     @user = User.find(params[:id])
   end

   def update 
   	  @user = User.find(params[:id])
     if @user.update_attributes(user_params)
     	flash[:notice] = "Profile Updated"
       redirect_to @user

      else
         render "edit"  
      end   
   end

   def destroy
     @user = User.find(params[:id])
     @user.destroy

     redirect_to users_path
   end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation, :dob, :image, :file_size)
    end

end
   # def logged_in_user
   #    if current_user == nil 
   #      flash[:notice] = "Please Login to access!"
   #      redirect_to root_url
   #    end
   #  end  

