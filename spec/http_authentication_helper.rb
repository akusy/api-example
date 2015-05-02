module HttpAuthenticationHelper
  def http_authenticate_or_request email, password
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
