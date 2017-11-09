class LoginController < ApplicationController

  def new
  end

  def auth
    val = params.permit(:name, :password)

    client = Aws::CognitoIdentityProvider::Client.new(
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    resp = client.sign_up({
      client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
      # secret_hash: ENV['AWS_COGNITO_APP_CLIENT_SECRET'],
      username: val['name'],
      password: val['password'],
      user_attributes: [
        {
          name: 'email',
          value: val['email'],
        },
        {
          name: 'name',
          value: val['name'],
        }
      ]
    })
    redirect_to '/signup/confirm'
  end
end
