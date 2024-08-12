require File.expand_path('../../spec_helper.rb', __FILE__)

describe ::ArmA::TvT::Loadouts::InfantryManager, '#list' do

  let(:missionDirs) {
    Dir.glob(File.expand_path('../../data/*/*', __FILE__)).map { |x| x }
  }

  let(:mgr) do
    ArmA::TvT::Loadouts::InfantryManager.new
  end

  it 'should list the right vehicle classes' do
    missionDirs.each { |missionDir|
      begin
        m = ArmA::TvT::Loadouts::Mission::Mission.new(missionDir)
        m.read
        units = []
        expect {
          units = mgr.list(m.json)
        }.to_not raise_exception

      rescue Exception => e
        puts "Happens for #{missionDir}"
        raise e
      end
    }
  end
end

