
require 'elasticsearch/model'


class Instauser < ActiveRecord::Base
	has_secure_password

	has_many :charges 
    has_many :brandusers, through: :charges
	 
	  include Elasticsearch::Model
	  include Elasticsearch::Model::Callbacks
	 
 
	      serialize :recent_media_urls
	end


 
