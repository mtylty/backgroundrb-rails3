# Backgroundrb
# FIXME: check if data that we are writing to the socket should end with newline
require "pathname"
require "packet"
require "ostruct"

require "rails"
require "backgroundrb"

require "backgroundrb/bdrb_config"
require "backgroundrb/bdrb_client_helper"
require "backgroundrb/bdrb_job_queue"
require "backgroundrb/bdrb_conn_error"
require "backgroundrb/rails_worker_proxy"
require "backgroundrb/bdrb_connection"
require "backgroundrb/bdrb_cluster_connection"
require "backgroundrb/bdrb_start_stop"
require "backgroundrb/bdrb_result"


module BackgrounDRb
  class Railtie < Rails::Railtie
    config.bdrb = ActiveSupport::OrderedOptions.new

    unless config.bdrb.has_key? :root
      config.bdrb.root = File.expand_path(File.join(__FILE__, '..', '..', '..'))
    end
    BackgrounDRb::BACKGROUNDRB_ROOT = config.bdrb.root

    config.before_configuration do
      config_file = "#{Rails.root}/config/backgroundrb.yml"

      if File.exists?(config_file) && !config.bdrb.has_key?(:config)
        config.bdrb.config = BackgrounDRb::Config.read_config(config_file)
      end
      BackgrounDRb::BDRB_CONFIG = config.bdrb.config

      ::MiddleMan = BackgrounDRb::ClusterConnection.new if File.exists?(config_file)
    end

    rake_tasks do
      load "tasks/backgroundrb_tasks.rake"
    end

  end

end

