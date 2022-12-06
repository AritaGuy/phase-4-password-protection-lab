class UsersController < ApplicationController
    def create
        user = User.create!(user_params) 
        session[:user_id] = user.id 
        if user.valid?  
            render json: user, status: :created
        else
            render json:{errors: errors.full_messages}, status: :unprocessable_entity
        end
    end
     
    def show
        return render json:{error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
        user = User.find_by(id: params[:id])
        render json: user, status: :ok
    end

    private
    def user_params
        params.permit(:username, :password)
    end
end
