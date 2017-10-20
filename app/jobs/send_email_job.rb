class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(id)
    GroupMembersMailer.new_post_mail(id).deliver_later
  end
end
