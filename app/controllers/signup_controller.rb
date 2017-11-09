class SignupController < ApplicationController

  def new
  end

  def create

    val = params.permit(:email, :name, :password)

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

  def confirm
  end

  def confirm_submit
    val = params.permit(:name, :code)

    client = Aws::CognitoIdentityProvider::Client.new(
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )


    resp = client.confirm_sign_up({
      client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
      # secret_hash: ENV['AWS_COGNITO_APP_CLIENT_SECRET'],
      username: val['name'],
      confirmation_code: val['code'],
      force_alias_creation: false
    })
    ::Rails.logger.debug(resp)

    redirect_to '/signup/done'
  end

  def done
  end

end
