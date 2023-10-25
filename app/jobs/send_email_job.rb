
class SendEmailJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.registration_confirmation(user).deliver_now
  end
end
