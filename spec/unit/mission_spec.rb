require File.expand_path('../../spec_helper.rb', __FILE__)

describe ::ArmA::TvT::Loadouts::Mission, '#read' do

  let(:missionDirs) {
    Dir.glob(File.expand_path('../../data/*/*', __FILE__)).map { |x| x }
  }

  it 'should read successfully an existing complex sqm file' do
    missionDirs.each { |missionDir|
      expect {
        begin
          m = ArmA::TvT::Loadouts::Mission::Mission.new(missionDir)
          m.read
        rescue Exception => e
          puts "Happens for #{missionDir}"
          raise e
        end

      }.to_not raise_exception
    }
  end
end

describe ::ArmA::TvT::Loadouts::Mission, '#create_backup' do

  let(:missionDirs) {
    Dir.glob(File.expand_path('../../data/*/*', __FILE__)).map { |x| x }
  }

  it 'should backup the SQM file' do
    missionDirs.each { |missionDir|
      expect {
        begin
          bkFile= File.join(missionDir, 'mission.sqm.orig')
          File.delete(bkFile) if File.exist?(bkFile)
          m = ArmA::TvT::Loadouts::Mission::Mission.new(missionDir)
          m.create_backup
          raise Error.new("backup file missing!") unless File.exist?(bkFile)
          raise Error.new("files differ!") unless Digest::SHA2.file(m.file) == Digest::SHA2.file(bkFile)
        rescue Exception => e
          puts "Happens for #{missionDir}"
          raise e
        end

      }.to_not raise_exception
    }
  end
end


describe ::ArmA::TvT::Loadouts::Mission, '#restore_backup' do

  let(:missionDirs) {
    Dir.glob(File.expand_path('../../data/*/*', __FILE__)).map { |x| x }
  }

  it 'should parse an existing complex sqm file' do
    missionDirs.each { |missionDir|
      expect {
        begin
          bkFile= File.join(missionDir, 'mission.sqm.orig')
          File.delete(bkFile) if File.exist?(bkFile)
          m = ArmA::TvT::Loadouts::Mission::Mission.new(missionDir)
          sha2 = Digest::SHA2.file(m.file)
          m.create_backup
          File.write(m.file, 'some text', mode: 'a+')
          m.restore_backup
          raise Error.new("SHA2 differs!") if sha2 != Digest::SHA2.file(m.file)
          raise Error.new("backup file already exists!") if File.exist?(bkFile)
        rescue Exception => e
          puts "Happens for #{missionDir}"
          raise e
        end

      }.to_not raise_exception
    }
  end
end
