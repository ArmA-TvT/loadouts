module ArmA
  module TvT
    module Loadouts

      module Mission
        class Manager

          def initialize
            @config = ArmA::TvT::Loadouts::Config.Sing.instance
          end

          def self.insert_target(target)
            mission = ArmA::TvT::Loadouts::Mission::Mission.new(@config['mission-directory'])
            mission.create_backup unless config[:simulate]
            mission.read

            modified_json = mission.json
            case target
            when 'all'
              modified_json = ArmA::TvT::Loadouts::InfantryManager.new.generate(modified_json)
              modified_json = ArmA::TvT::Loadouts::VehicleManager.new.generate(modified_json)
            when 'infantry'
              modified_json = ArmA::TvT::Loadouts::InfantryManager.new.generate(modified_json)
            when 'vehicles'
              modified_json = ArmA::TvT::Loadouts::VehicleManager.new.generate(modified_json)
            else
              raise Error.new "unsupported target #{target}"
            end

            mission.write unless config[:simulate]
          end


          def self.list(target)
            mission = ArmA::TvT::Loadouts::Mission::Mission.new(@config['mission-directory'])
            case target
            when 'all'
              ArmA::TvT::Loadouts::InfantryManager.new.list(mission.json)
              ArmA::TvT::Loadouts::VehicleManager.new.list(mission.json)
            when 'infantry'
              ArmA::TvT::Loadouts::InfantryManager.new.list(mission.json)
            when 'vehicles'
            ArmA::TvT::Loadouts::VehicleManager.new.list(mission.json)
            else
              raise Error.new "unsupported target #{target}, must be one of {all|infantry|vehicles}"
            end
          end

        end
      end
    end
  end
end