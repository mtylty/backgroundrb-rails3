module Backgroundrb
  module Generators
    class WorkerGenerator < Rails::Generators::NamedBase
      def self.source_root
        @source_root ||= File.expand_path('../templates', __FILE__)
      end

      def copy_backgroundrb_worker
        template "worker.rb", "lib/workers/#{file_name}_worker.rb"
        #template "unit_test.rb", "test/unit/#{file_name}_worker_test.rb"
      end
    end
  end
end
