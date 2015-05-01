module HttpAuthenticationHelper
  def http_authenticate_user email, password
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
