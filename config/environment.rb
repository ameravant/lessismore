RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
require File.join(File.dirname(__FILE__), '../vendor/plugins/siteninja/engines/boot')

Rails::Initializer.run do |config|
  config.gem "geokit", :version => "1.4.1"
  config.gem "searchlogic"
  config.i18n.default_locale = :en
  config.active_record.observers = :comment_observer, :inquiry_observer

  if Rails.env.production?
    cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    config.action_mailer.default_url_options = { :host => "#{cms_config['website']['domain']}"}
  else
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
  end

require 'hirb'
Hirb.enable

MATERIALS = ["recycle", "reduce-reuse", "yard-waste", "hazardous-waste", "electronics", "trash"]
end

