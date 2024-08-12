require File.expand_path('../../spec_helper.rb', __FILE__)

describe ::ArmA::TvT::Loadouts::Roster::Manager, '#<parse>' do

  let(:sqmFiles) {
    Dir.glob(File.expand_path('../../data/*/*', __FILE__)).map { |x|
      File.join(x, 'mission.sqm')
    }
  }

  let(:manager) {
    ::ArmA::TvT::Loadouts::Roster::Manager.new
  }

  it 'should parse an existing complex sqm file' do

    sqmFiles.each { |sqmFile|
      raise Exception.new "Mission '#{sqmFile}' sqm file is not available" unless File.exist?(sqmFile)
      config = {'mission-directory': File.dirname(sqmFile)}
      expect {
        begin
          manager.parse(config).to_json
        rescue Exception => e
          puts "Happens for #{sqmFile}"
          raise e
        end

      }.to_not raise_exception
    }
  end
end
