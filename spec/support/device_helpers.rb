module DeviseHelpers
  def authenticate_user(user = nil)
    user ||= FactoryBot.create(:user)
    token = JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.devise_jwt_secret_key!)
    { 'Authorization' => "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include DeviseHelpers, type: :request
end
