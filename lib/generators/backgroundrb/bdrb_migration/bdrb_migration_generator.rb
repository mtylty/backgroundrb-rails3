require 'rails/generators/active_record'

module Backgroundrb
  module Generators
    class BdrbMigrationGenerator < ActiveRecord::Generators::Base
      def self.source_root
        @source_root ||= File.expand_path('../templates', __FILE__)
      end

      def copy_backgroundrb_migration
        migration_template "migration.rb", "db/migrate/backgroundrb_create_backgroundrb_queue_table"
      end
    end
  end
end
