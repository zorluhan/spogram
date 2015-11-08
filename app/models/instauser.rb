
require 'elasticsearch/model'


class Instauser < ActiveRecord::Base
	has_secure_password
	 
	  include Elasticsearch::Model
	  include Elasticsearch::Model::Callbacks
	end


 
