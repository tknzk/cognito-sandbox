class LoginController < ApplicationController

  def new
  end

  def auth
    # binding.pry
    val = params.permit(:email, :name, :password)

    client = Aws::CognitoIdentityProvider::Client.new(
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    # signin
   #  @resp = client.initiate_auth({
   #    client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
   #    auth_flow: 'USER_SRP_AUTH',
   #    auth_parameters: {
   #      USERNAME: val['name'],
   #      PASSWORD: val['password'],
   #    }
   #  })
    # cog_provider.initiate_auth({client_id: "xxxxxxxxx", auth_parameters: { "name" => "xxx", "password" => "xxx"}, auth_flow: "USER_SRP_AUTH"})

    # SRP_A ではなく admin_auth_initiate で plain な passwordを送信
    @resp = client.admin_initiate_auth({
      auth_flow: 'ADMIN_NO_SRP_AUTH',
      auth_parameters: {
        USERNAME: val['name'],
        PASSWORD: val['password'],
      },
      user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
      client_id: ENV['AWS_COGNITO_APP_CLIENT_ID']
    })

  end
end
