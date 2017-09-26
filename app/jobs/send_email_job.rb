class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(post)
    @post = post
    GroupMembersMailer.new_post_mail(@post).deliver_later
  end
end
