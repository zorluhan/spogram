class Branduser < ActiveRecord::Base
	has_secure_password 
    has_many :charges
    has_many :instausers, through: :charges
	has_many :messages 
	
	validates :phone , presence: true 
	validates :coname, presence: true
	validates :cowebsite, presence: true 
	validates :email, presence: true 
	validates :email, :email_format => {:message => 'is not looking good'}
	 validates :email, :uniqueness => {:link => Rails.application.routes.url_helpers.bsignup_path}

has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


end
