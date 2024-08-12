module ArmA
  module TvT
    module Loadouts

      module Command
        class Roster < Thor

          desc 'generate', 'generate an external file in the requested format, describing all slots'
          option :type, :required => true, alias: :t
          option :side, :required => true, alias: :s
          def generate
            begin
              ArmA::TvT::Loadouts::Config::Manager.instance.load_conf(opts)
              ArmA::TvT::Loadouts::Roster::Manager.new.generate
              ArmA::TvT::Loadouts::Config::Manager.instance.logger.info('Test successful.')
            rescue Exception => e
              ArmA::TvT::Loadouts::Config::Manager.instance.logger.fatal(e.message)
              ArmA::TvT::Loadouts::Config::Manager.instance.logger.error('Test failed !!!')
            end

          end

        end

      end
    end
  end
end
