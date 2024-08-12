module ArmA
  module TvT
    module Loadouts

      module Roster
        class Manager

          include ArmA::TvT::Loadouts::Mission::Sided

          def initialize
            @slots = Hash.new
          end

          attr_accessor :slots
          def parse(config)
            sqm_file = File.join(config[:'mission-directory'], 'mission.sqm')
            mission = ArmA::TvT::Loadouts::Mission::Mission.new
            begin
              sqm_file_to_parse = File.exist?(sqm_file + '.orig') ? sqm_file + '.orig' : sqm_file
              logger.debug("parsing mission file '#{sqm_file_to_parse}'")
              json = mission.to_json(File.read(sqm_file_to_parse))
            rescue Exception => e
              logger.fatal("fail to parse mission file '#{sqm_file_to_parse}'")
              raise e
            end

            json[:Mission][:Entities].drop(1).select {|s| s[1][:dataType] == 'Group'}.each { |group|
              @slots[self.get_color(group[1][:side])] = Array.new if @slots[self.get_color(group[1][:side])] == nil
              items = group[1][:Entities].drop(1).select {|s| s[1][:Attributes][:isPlayable] == 1}.collect {|s|
                s[1][:Attributes][:description].nil? ? s[1][:type] : s[1][:Attributes][:description]
              }
              groupName = group[1][:CustomAttributes].nil? ? '' : group[1][:CustomAttributes][:Attribute0][:Value][:data][:value]
              @slots[self.get_color(group[1][:side])].push({groupName => items})
            }
            puts @slots
          end


          def get_loadout(mtkClassName, side)
            res = removeAll
            res += addGears(mtkClassName, side)
            res += addWeapons(mtkClassName, side)
            sanitize_init(res)
          end

        end

        def generate
          case config[:format]
          when :markdown
            ArmA::TvT::Loadouts::Roster::Markdown.process
          when :bbcode
            ArmA::TvT::Loadouts::Roster::BBCode.process
          else
            raise Exception.new "Unsupported format '#{config[:format]}'"
          end
        end

      end
    end
  end
end
