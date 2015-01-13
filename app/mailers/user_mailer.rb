class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(user,photo)
    @user = user
    file_name = photo.original_filename
    attachments["#{file_name}"] = File.read("#{photo.path}")
    #attachments['filename.jpg'] = File.read('/path/to/filename.jpg')
    mail :to => user.email, :subject => "Password Reset"

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  
end
