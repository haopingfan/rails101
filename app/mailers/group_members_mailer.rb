class GroupMembersMailer < ApplicationMailer
  default from: "haopingfanfan@gmail.com"

  def new_post_mail(post)
    @user = post.user
    @group = post.group

    @group.members.each do |member|
      next if member == @user
      @member = member
      mail(to: member.email, subject: '[BonBonWo101] Your group has a new post!')
    end
  end
end
