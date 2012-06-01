require 'redmine'

require_dependency 'notification_hooks'

Redmine::Plugin.register :redmine_hipchat_per_project do
  name 'Redmine HipchatPerProject plugin'
  author 'Author name'
  description 'Hipchat notifications for projects'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'

	project_module :hipchat do
		permission :view_hipchat_settings, { :hipchat => :index }
		permission :set_hipchat_settings, { :hipchat => :save  }
	end

	settings :default => {}

	menu :project_menu, :hipchat, { :controller => 'hipchat', :action => 'index' }, :caption => 'HipChat settings', :param => :project_id
end
