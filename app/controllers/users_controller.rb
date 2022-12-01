class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id

        render json: user
    end

    def show
        user = User.find_by(id: session[:user_id])
        if(user.nil?)
            render json: {error: "Not authorized"}, status: 401
        else
            render json: user
        end
    end


    private
    def record_invalid(invalid)
        render json: invalid.record.errors.full_messages, status: :unprocessable_entity
    end

    def record_not_found
        render json: {error: "Record not found"}, status: 404
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end