require 'redmine'

require_dependency 'issue_observer_patch'
require_dependency 'journal_observer_patch'
require_dependency 'message_observer_patch'

Rails.configuration.to_prepare do
  IssueObserver.instance.extend(IssueObserverPatch)
  JournalObserver.instance.extend(JournalObserverPatch)
  MessageObserver.instance.extend(MessageObserverPatch)
end

Redmine::Plugin.register :redmine_hipchat_per_project do
  name        'Redmine HipchatPerProject plugin'
  author      'Digital Natives'
  description 'Hipchat notifications for projects'
  version     '0.2.0'
  url         'https://github.com/digitalnatives/redmine_hipchat_per_project'

	project_module :hipchat do
		permission :view_hipchat_settings, { :hipchat => :index }
		permission :set_hipchat_settings, { :hipchat => :save  }
	end

	settings :default => {}

	menu     :project_menu,
           :hipchat, { :controller => 'hipchat', :action => 'index' },
           :caption => 'HipChat settings',
           :param => :project_id
end
