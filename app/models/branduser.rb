class Branduser < ActiveRecord::Base
  has_secure_password 
  has_many :messages, dependent: :destroy
  has_many :charges,  dependent: :destroy
  has_many :instausers, through: :charges

  validates :phone , presence: true 
  validates :coname, presence: true
  validates :cowebsite, presence: true 
  validates :email, presence: true 
  validates :email, :email_format => {:message => 'is not looking good'}
  validates :email, :uniqueness => {:link => Rails.application.routes.url_helpers.bsignup_path}
  validates :title, presence: :true 
  validates :firstname, presence: :true 
  validates :lastname, presence: :true 

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  after_create :send_welcome_email

  def send_welcome_email
    if Rails.env.production?
      if email.present?
        UserMailer.branduser_welcome_email(id).deliver!
      end
    end
  end

end
