module ArmA
  module TvT
    module Loadouts
      module Config
        class Sing

          attr_accessor :conf

          def logger
            @logger ||= ArmA::TvT::Loadouts::Config::Manager.instance.logger
          end

          def load_conf(options = {})
            @conf = options.dup

            validate_path(options['mission-directory'])
            sqm_file = File.join(options['mission-directory'], 'mission.sqm')
            sqm_file = "#{sqm_file}.orig" if File.exist? "#{sqm_file}.orig"
            validate_sqm(sqm_file)

            %W'bluefor redfor greenfor civilians'.each { |color|
              %W(classes-#{color} infantry-#{color} vehicles-#{color}).each { |file|
                unless options[file.to_sym].nil?
                  ArmA::TvT::Loadouts::Config::Manager.instance.logger.info("loading data file '#{options[file.to_sym]}'")
                  @instance[file.to_sym] = options[:no_symbol] ? YAML.load_file(options[file.to_sym]) : load_yaml_with_symbolized_keys(options[file.to_sym])
                end
              }
            }
          end


        end
      end
    end
  end
end
