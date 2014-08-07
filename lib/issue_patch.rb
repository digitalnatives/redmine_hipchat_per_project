module IssuePatch
  include HipchatNotifier

  def self.included(base)
    base.class_eval do
      after_create :send_hipchat
      
      def send_hipchat
        Rails.logger.info 'sending hipchat'
        send_issue_reported_to_hipchat(self)
    		super(self) rescue nil
      end
    end
  end
end