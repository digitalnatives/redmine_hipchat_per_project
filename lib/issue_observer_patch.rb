module IssueObserverPatch
  include HipchatNotifier
  include ERB::Util

  def after_create(issue)
    send_issue_reported_to_hipchat(issue)
    super(issue) rescue nil
  end
end