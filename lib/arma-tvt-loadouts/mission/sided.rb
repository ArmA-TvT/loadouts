module ArmA
  module TvT
    module Loadouts

      module Mission
        module Sided

          MISSION_SIDES = { bluefor: 'WEST', redfor: 'EAST', greenfor: 'INDEPENDENT', civfor: 'CIVILIAN'}

          def get_side(color)
            MISSION_SIDES[color.downcase.to_sym]
          end

          def get_color(side)
            MISSION_SIDES.key(side.to_s.upcase)
          end

        end
      end
    end
  end
end
