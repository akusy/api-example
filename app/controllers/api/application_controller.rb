module Api
  class ApplicationController < ::ApplicationController
    skip_before_action  :verify_authenticity_token

    before_action :http_authenticate_user

    respond_to :json

    def current_user
      @current_user
    end

    def http_authenticate_user
      authenticate_or_request_with_http_basic("Application") do |email, password|
        if user = User.find_by(email: email)
          @current_user = user.authenticate(password)
        end
      end
    end

    private

    def set_guest_user
      @current_user = User.create_guest
    end
  end
end
