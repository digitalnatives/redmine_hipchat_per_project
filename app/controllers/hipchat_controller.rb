class HipchatController < ApplicationController
  unloadable

  before_filter :find_project, :authorize, :except => :find_project
  before_filter :get_settings, :only => :index

  def index
  end

  def save
    val = @settings.value ||= {}
    val[@project.id] = { :auth_token => params[:settings][:auth_token],
                         :room_id => params[:settings][:room_id],
                         :notify => params[:settings][:notify],
                         :message_color => params[:settings][:message_color] }
    @settings.update_attribute :value, val
    get_settings
    flash[:notice] = l(:notice_successful_update)
    redirect_to :action => 'index'
  end

  private

  def find_project
    @project = Project.find(params[:project_id]) rescue render_404
    @settings = Setting.find_or_initialize_by_name('plugin_redmine_hipchat_per_project')
  end

  def get_settings
    @auth_token = @settings.value[@project.id][:auth_token] rescue nil
    @room_id = @settings.value[@project.id][:room_id] rescue nil
    @notify = @settings.value[@project.id][:notify] rescue nil
    @colors = [ l(:hipchat_settings_color_yellow),
                l(:hipchat_settings_color_red),
                l(:hipchat_settings_color_green),
                l(:hipchat_settings_color_purple),
                l(:hipchat_settings_color_random)]
    @selected_color = @settings.value[@project.id][:message_color] rescue nil
  end
end
