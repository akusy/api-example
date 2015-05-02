module Api
  class ApplicationController < ::ApplicationController
    include Pundit

    after_action :verify_authorized, except: [:show, :index]

    skip_before_action  :verify_authenticity_token

    respond_to :json

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    def current_user
      @current_user
    end

    def http_authenticate_or_request
      authenticate_or_request_with_http_basic("Application") do |email, password|
        current_user_authentication(email, password)
      end
    end

    def http_authenticate_or_set_guest
      set_guest_user unless http_authenticate
    end

    private

    def http_authenticate
      authenticate_with_http_basic do |email, password|
        current_user_authentication(email, password)
      end
    end

    def set_guest_user
      @current_user = User.create_guest
    end

    def current_user_authentication email, password
      if user = User.find_by(email: email)
        @current_user = user.authenticate(password)
      end
    end

    def page
      params[:page] || 1
    end

    def record_not_found
      head :not_found
    end

    def not_authorized
      head :unauthorized
    end
  end
end
