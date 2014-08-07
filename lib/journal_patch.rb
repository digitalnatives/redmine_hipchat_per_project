module JournalPatch
  include HipchatNotifier

  def self.included(base)
    base.class_eval do
      after_create :send_hipchat
      
      def send_hipchat
        send_issue_updated_to_hipchat(self) if journal.journalized_type.to_s == 'Issue'
    		super(self) rescue nil
      end
    end
  end
end