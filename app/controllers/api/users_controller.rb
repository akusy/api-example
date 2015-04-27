module Api
  class UsersController < Api::ApplicationController

    def show
      respond_with User.find(params[:id])
    end
  end
end
