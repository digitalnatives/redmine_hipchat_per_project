require 'redmine'

Issue.class_eval do
  include HipchatNotifier
  include ERB::Util

  after_create :notify_hipchat

  private
  def notify_hipchat
    send_issue_reported_to_hipchat self
  end
end

Journal.class_eval do
  include HipchatNotifier
  include ERB::Util

  after_create :notify_hipchat

  private
  def notify_hipchat
    send_issue_updated_to_hipchat(self) if self.journalized_type.to_s == 'Issue'
  end
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
