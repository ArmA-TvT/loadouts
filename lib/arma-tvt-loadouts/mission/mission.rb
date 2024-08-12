module ArmA
  module TvT
    module Loadouts
      module Mission
        class Mission

          include Sqm2Json,Sqm2Json::Reverse

          attr_accessor :json, :file

          def initialize(path)
            if File.directory? path
              @file = File.join(path, 'mission.sqm')
            elsif File.exist?(path) && File.basename == 'mission.sqm'
              @file = path
            else
              raise Error.new "Unsupported file '" + path + "'"
            end
            @backup_file = @file + '.orig'
            @logger = ArmA::TvT::Loadouts::Config::Manager.instance.logger
          end

          def read
            begin
              sqm_file_to_parse = self.backup_exists? ? @backup_file : @file
              @logger.debug("parsing mission file '#{sqm_file_to_parse}'")
              @json = self.to_json(File.read(sqm_file_to_parse))
            rescue Exception => e
              @logger.fatal("fail to parse mission file '#{sqm_file_to_parse}'")
              raise e
            end
          end

          def write
            @logger.debug("writing new mission file '#{@file}'")
            File.open(@file, 'w+') { |f|
              f.puts Sqm2Json.to_sqm(@json) #JSON::pretty_generate modified_json
            }
            @logger.info("loadouts successfully written to '#{@file}'")
          end

          def create_backup
            @logger.debug("creating back-up file '#{@backup_file}")
            if File.exist?(@backup_file)
              @logger.warn("aborting, original mission back-up already exists: #{@backup_file}")
            else
              FileUtils.cp(@file, @backup_file)
            end
          end

          def restore_backup
            @logger.info("restoring back-up file '#{@backup_file}")
            if File.exist?(@backup_file)
              @logger.debug("deleting current mission file '#{@file}'")
              FileUtils.remove(@file)
              @logger.debug("renaming backup '#{@backup_file}' to '#{@file}'")
              FileUtils.move(@backup_file, @file)
            else
              @logger.error("'#{@backup_file}' back-up file not found !")
            end
          end

          def backup_exists?
            File.exist?(@backup_file)
          end
        end
      end
    end
  end
end