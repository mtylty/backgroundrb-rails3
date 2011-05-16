# Include hook code here
%w{ controller }.each do |code_dir|
  $:.unshift File.join(File.dirname(__FILE__),"app",code_dir)
end
require 'logger'
require 'backgroundrb'
#require "backgroundrb_status_controller"
