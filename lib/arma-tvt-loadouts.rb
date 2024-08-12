require 'singleton'
require 'json'
require 'yaml'
require 'thor'

class Thor
  def self.basename
    File.basename($PROGRAM_NAME, '.rb').split(" ").first + '.exe'
  end
end

require 'sqm2json'
require 'fileutils'
require 'logger'
require 'liquid'

require File.expand_path('../arma-tvt-loadouts/version', __FILE__)

require File.expand_path('../arma-tvt-loadouts/config/manager', __FILE__)
require File.expand_path('../arma-tvt-loadouts/config/config', __FILE__)

require File.expand_path('../arma-tvt-loadouts/mission/sided', __FILE__)
require File.expand_path('../arma-tvt-loadouts/mission/mission', __FILE__)
require File.expand_path('../arma-tvt-loadouts/mission/manager', __FILE__)

require File.expand_path('../arma-tvt-loadouts/roster/manager', __FILE__)

require File.expand_path('../arma-tvt-loadouts/loadout/infantry_manager', __FILE__)
require File.expand_path('../arma-tvt-loadouts/loadout/vehicle_manager', __FILE__)
require File.expand_path('../arma-tvt-loadouts/loadout/script', __FILE__)

require File.expand_path('../arma-tvt-loadouts/command/roster', __FILE__)
require File.expand_path('../arma-tvt-loadouts/command/main_cli', __FILE__)

