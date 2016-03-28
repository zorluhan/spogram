class Branduser < ActiveRecord::Base

  devise :omniauthable

  has_secure_password 
  has_many :messages, dependent: :destroy
  has_many :charges,  dependent: :destroy
  has_many :instausers, through: :charges
  has_many :authorizations

  validates :phone , presence: true 
  validates :coname, presence: true
  validates :cowebsite, presence: true 
  validates :email, presence: true 
  validates :email, uniqueness: true 
  validates :email, :email_format => {:message => 'is not an email, pls enter an email'}
  # validates :email, :uniqueness => {:link => Rails.application.routes.url_helpers.bsignup_path}
  validates :title, presence: :true 
  validates :firstname, presence: :true 
  validates :lastname, presence: :true 
  #validates :password, presence: :true  , on: :create


  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  after_create :send_welcome_email

  def send_welcome_email
    # if Rails.env.production?
      # if email.present? # email needs to be present
        UserMailer.branduser_welcome_email(id).deliver!
      # end
    # end
  end

  def profile_filled?
    coname.present? and cowebsite.present? and phone.present? and title.present?
  end

  def self.from_omniauth(auth)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s).first_or_initialize
    if authorization.branduser.blank?
      user = Branduser.find_by_email(auth["info"]["email"])
      if user.blank?
        user = Branduser.new(:password => Devise.friendly_token,
                            :email => auth.info.email)
      end
    else
      user = authorization.branduser
    end
    user.firstname = auth["info"]["first_name"] unless user.firstname.present?
    user.lastname = auth["info"]["last_name"] unless user.lastname.present?
    user.is_authenticated = true
    user.auth_token = nil
    user.save(:validate => false)
    authorization.token = auth.credentials.token
    authorization.secret = auth.credentials.secret
    authorization.username = auth.info.nickname
    authorization.branduser_id = user.id
    authorization.save
    authorization.branduser
 end

end
