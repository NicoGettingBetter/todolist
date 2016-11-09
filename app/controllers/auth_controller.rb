class AuthController < Devise::OmniauthCallbacksController

  respond_to :json

  def signup
    @user = User.create auth_params.merge(confirmed_at: Time.zone.now)
    
    if @user.id
      render json: { token: JWT.encode({user_id: @user.id}, '1a5b356e56c96ad') }
    else
      render json: { error: 'Email is registered' }, status: :unauthorized
    end
  end

  def login
    @user = User.find_by email: params[:email] if params[:email].present?

    if @user && @user.valid_password?(params[:password])
      render json: { token: JWT.encode({user_id: @user.id}, '1a5b356e56c96ad') }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def facebook
    init params
    @user = User.from_omniauth({
      email: @data['email'],
      uid: @data['id'],
      token: @access_token
      })

    if @user.persisted?
      render json: { token: JWT.encode({user_id: @user.id}, '1a5b356e56c96ad') }
    else
      session["devise.facebook_data"] = @user
      redirect_to new_user_registration_url
    end
  end

  private

    ACCESS_TOKEN_URL = 'https://graph.facebook.com/v2.7/oauth/access_token'
    DATA_URL = 'https://graph.facebook.com/v2.7/me'

    def init params
      @provider = 'facebook'
      prepare_params params
      @client = HTTPClient.new
      @access_token = params[:access_token].presence || get_access_token
      get_data if @access_token.present?
    end

    def get_data
      response = @client.get(DATA_URL, access_token: @access_token, fields: 'email')
      @data = JSON.parse(response.body).with_indifferent_access
      @uid = @data[:id] ||= @data[:sub]
      @data
    end

    def get_access_token
      response = @client.post(self.class::ACCESS_TOKEN_URL, @params)
      puts "ACCESS TOKEN RESPONSE - #{response.body}"
      JSON.parse(response.body)["access_token"]
    end

    def prepare_params params
      @params = {
        code:          params[:code],
        redirect_uri:  params[:redirectUri],
        client_id:     params[:clientId],
        client_secret: 'e766489c6a49e8467858a6e54adad7fa',
        grant_type:    'authorization_code'
      }
    end

    def authorized?
      @access_token.present?
    end

    def auth_params
      params.require(:auth).permit(:email, :password)
    end
end