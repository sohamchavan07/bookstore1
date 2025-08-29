class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    # Send email
    UserMailer.welcome_email(user).deliver_now

    # Store JobLog
    JobLog.create!(
      job_name: self.class.name,
      status: 'success',
      executed_at: Time.current,
      message: "Welcome email sent to #{user.email}"
    )
  rescue => e
    JobLog.create!(
      job_name: self.class.name,
      status: 'failed',
      executed_at: Time.current,
      message: e.message
    )
    raise e
  end
end
