class UserMailerPreview < ActionMailer::Preview
  def new_player
    UserMailer.new_player
  end
end