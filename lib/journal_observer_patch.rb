module JournalObserverPatch
  include HipchatNotifier
  include ERB::Util

  def after_create(journal)
    send_issue_updated_to_hipchat(journal) if journal.journalized_type.to_s == 'Issue'
    super(journal) rescue nil
  end
end