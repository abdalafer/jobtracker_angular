# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  jquery.self.js
  jquery_ujs.self.js
  angular.self.js
  angular-resource.self.js
  angular-route.self.js
  angular-rails-templates.self.js
  angular_controllers.self.js
  angular_main.self.js
  application.self.js
  templates/index.self.js
)