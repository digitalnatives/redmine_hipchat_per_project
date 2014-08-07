module JournalPatch
  include HipchatNotifier

  def self.included(base)
    base.class_eval do
      after_create :send_hipchat
      
      def send_hipchat
        send_issue_updated_to_hipchat(journal) if journal.journalized_type.to_s == 'Issue'
    		super(journal) rescue nil
      end
    end
  end
end