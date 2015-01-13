class User < ActiveRecord::Base

  #validates :username, presence: true,   length: { maximum: 16 }

  validates :password, presence: true,   length: { minimum: 8 }

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "Please enter valid email address."} 

   #validates_with GoodnessValidator
   attr_accessor :password_confirmation, :photo 
   has_secure_password
   before_create { generate_token(:auth_token) }
   mount_uploader :image, ImageUploader

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset(photo)
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self,photo).deliver
  end

  def self.create_with_omniauth(auth)
        create! do |user|
    p "=======#{auth["provider"]}========#{auth["credentials"]["token"]}======================="
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.password = "12345678"
    user.email = auth["info"]["email"]
    user.username = auth["info"]["name"]
    user.image = auth["info"]["image"]
      if auth["provider"].eql?("facebook") || auth["provider"].eql?("twitter")
    #   user.email = auth["info"]["nickname"]
      # else
      #   user.email = auth["info"]["email"]
      end
  end

  end



  def self.username(name)
    if name
      where('username LIKE ?', "%#{name}%")
    else
      scoped
    end
  end                  
end

# class GoodnessValidator < ActiveModel::Validator
#   def validate(record)
#     em = record.username.split(' ')[1]
#     unless em.nil? 
#     record.errors[:username] << "username should not contain space"
#     end
#   end
# end 

 