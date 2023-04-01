class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find_by(id: session[:user_id])

        if user
            render json: user, status: :created
        else
            render json: { errors: ["Unauthorized"] }, status: :unauthorized
        end
    end

    def create
        if params[:password] == params[:password_confirmation]
            user = User.create!(user_params)
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: ["Passwords do not match"] }, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.permit(:username, :password, :image_url, :bio)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  
end
