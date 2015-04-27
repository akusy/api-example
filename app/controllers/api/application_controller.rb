module Api
  class ApplicationController < ::ApplicationController
    skip_before_action  :verify_authenticity_token

    respond_to :json
  end
end
