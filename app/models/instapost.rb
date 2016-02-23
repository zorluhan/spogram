class Instapost < ActiveRecord::Base
	belongs_to :instauser , dependent: :destroy
end
