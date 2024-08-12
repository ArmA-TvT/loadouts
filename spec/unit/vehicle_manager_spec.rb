require File.expand_path('../../spec_helper.rb', __FILE__)

describe ::ArmA::TvT::Loadouts::VehicleManager, '#list' do

  let(:missionDirs) {
    Dir.glob(File.expand_path('../../data/*/*', __FILE__)).map { |x| x }
  }

  let(:mgr) do
    ArmA::TvT::Loadouts::VehicleManager.new
  end

  it 'should list the right vehicle classes' do
    missionDirs.each { |missionDir|
      begin
        m = ArmA::TvT::Loadouts::Mission::Mission.new(missionDir)
        m.read
        vehicles = []
        expect {
          vehicles = mgr.list(m.json)
        }.to_not raise_exception
        ref =File.readlines(File.join(missionDir, 'vehicles.txt')).collect { |s| s.delete("\r\n")}
        vehicles.should match_array(ref)
      rescue Exception => e
        puts "Happens for #{missionDir}"
        raise e
      end
    }
  end
end

