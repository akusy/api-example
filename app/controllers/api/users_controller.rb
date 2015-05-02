module Api
  class UsersController < Api::ApplicationController

    before_action :http_authenticate_or_request

    def show
      respond_with user
    end

    def index
      respond_with User.page(page)
    end

    def create
      user = User.new(create_user_params)
      if user.save
        render json: user
      else
        render json: { errors: user.errors.messages }, status: :unprocessable_entity
      end
    end

    def update
      if user.update(update_user_params)
        render json: user
      else
        render json: { errors: user.errors.messages }, status: :unprocessable_entity
      end
    end

    def destroy
      respond_with user.destroy
    end

    private

    def user
      User.find(params[:id])
    end

    def update_user_params
      params.require(:user).permit(:email, :name, :password)
    end

    def create_user_params
      params.require(:user).permit(:email, :name, :password, :role)
    end
  end
end
