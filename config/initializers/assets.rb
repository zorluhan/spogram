# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'


Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.js )
Rails.application.config.assets.precompile += %w( bootstrap-select.js )
Rails.application.config.assets.precompile += %w( bootstrap.css)
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( bootstrap-theme.css )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( bootstrap-theme.min.css )
Rails.application.config.assets.precompile += %w( bootstrap-select.min.css )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( jquery-1.12.0.min.js )
Rails.application.config.assets.precompile += %w( gmaps.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )



 
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

Rails.application.config.assets.precompile << Proc.new { |path, fn| fn =~ /vendor\/assets/ && !%w(.js .css).include?(File.extname(path)) }

 

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 #Rails.application.config.assets.precompile += %w( publish_proposal.js.erb , bootstrap_and_customization.css.scss)
