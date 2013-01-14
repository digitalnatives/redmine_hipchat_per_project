module HipchatNotifier
  include Redmine::I18n
  include ActionView::Helpers::TagHelper
  include IssuesHelper

  def send_issue_reported_to_hipchat(issue)
    return unless @settings = get_settings(issue)
    send_message headline_for_issue(issue, 'reported')
  end

  def send_issue_updated_to_hipchat(journal)
    issue = journal.issue
    return unless @settings = get_settings(issue)
    # rescue is for link_to(attachment)
    details = journal.details.map{|d| show_detail(d) rescue show_detail(d, :no_html) }.join("<br />")
    comment = CGI::escapeHTML(journal.notes)

    text    = headline_for_issue(issue, 'updated')
    text   += "<br /> #{details}" unless details.blank?
    text   += "<br /> <b>Comment</b> <i>#{truncate(comment)}</i>" unless comment.blank?

    send_message text
  end

  private

  def send_message(message)
    if @settings[:auth_token].nil?    ||
       @settings[:room_id].nil?       ||
       @settings[:auth_token].blank?  ||
       @settings[:room_id].blank?
      RAILS_DEFAULT_LOGGER.info "Unable to send HipChat message : config missing."
      return
    end

    RAILS_DEFAULT_LOGGER.info "Sending message to HipChat: #{message}."

    req = Net::HTTP::Post.new("/v1/rooms/message")
    req.set_form_data({
      :auth_token => @settings[:auth_token],
      :room_id => @settings[:room_id],
      :notify => @settings[:notify] ? 1 : 0,
      :from => 'Redmine',
      :message => message,
      :color => @settings[:message_color]
    })
    req["Content-Type"] = 'application/x-www-form-urlencoded'

    http = Net::HTTP.new("api.hipchat.com", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    begin
      http.start do |connection|
        connection.request(req)
      end
    rescue Net::HTTPBadResponse => e
      RAILS_DEFAULT_LOGGER.error "Error hitting HipChat API: #{e}"
    end
  end

  def headline_for_issue(issue, mode)
    project = issue.project
    author  = CGI::escapeHTML(User.current.name)
    tracker = CGI::escapeHTML(issue.tracker.name.downcase)
    subject = CGI::escapeHTML(issue.subject)
    url     = get_url issue

    "#{author} #{mode} #{project.name} #{tracker} <a href=\"#{url}\">##{issue.id}</a>: #{subject}"
  end

  def get_url(object)
    case object
      when Issue then "#{Setting[:protocol]}://#{Setting[:host_name]}/issues/#{object.id}"
    else
      RAILS_DEFAULT_LOGGER.info "Asked redmine_hipchat for the url of an unsupported object #{object.inspect}"
    end
  end

  def get_settings(issue)
    Setting.find_by_name('plugin_redmine_hipchat_per_project').value[issue.project_id] rescue nil
  end

  def truncate(text, length = 20, end_string = '...')
    return unless text
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end

end