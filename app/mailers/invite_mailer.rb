class InviteMailer < ApplicationMailer
  def invite_email(email, invite, group, sender)
    @invite = invite
    @group = group
    @sender = sender
    mail(to: email, subject: "Invitation to join #{@group.name} from #{@sender.to_s}")
  end
end
