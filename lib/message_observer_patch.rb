module MessageObserverPatch
  include HipchatNotifier
  include ERB::Util

  def after_create(message)
    send_message_created_to_hipchat(message)
    super(message) rescue nil
  end
end
