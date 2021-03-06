class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(user_id)
    #token keeps 5 minutes
    expires_in = 5.minute.from_now.to_i
    payload = {user_id: user_id, exp: expires_in}
    JWT.encode(payload, 's3cr3t', 'HS256')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  #postする時のuser idをtokenから取得する
  def user_authentication
    @user_id = decoded_token[0]['user_id']['user_id']
  end
  
end
