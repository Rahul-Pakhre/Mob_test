class SessionsController < ApplicationController

	def new
    # if current_user
    #  redirect_to user_path(user)
    # end
  end	

   def create
   
     user = User.find_by_username(params[:session][:username]) if params[:session]
     if user && user.authenticate(params[:session][:password])
         session[:user_id] = user.id
        if params[:remember_me]
         cookies.permanent[:auth_token] = user.auth_token
        else
         cookies[:auth_token] = user.auth_token  
        end
      redirect_to user_path(user)
     elsif 
        auth = request.env["omniauth.auth"]
      p "=====#{auth.inspect}========"
       user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
       session[:user_id] = user.id
       redirect_to user_path(user), :notice => "Signed in!"
        
    else
     flash[:notice] = "Invalid Username or Password"
     render "new"
    end
   end 
 

 def destroy 
    session[:user_id] = nil 
    cookies.delete(:auth_token)  
    redirect_to  root_url
    flash[:notice] = "You have successfully logged out."
    # P "-----------------HJGKJHJ"
 end  
end 




