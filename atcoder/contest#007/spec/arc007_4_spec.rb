require File.expand_path(File.dirname(__FILE__) + '/../arc007_4.rb')

describe EconomyPlanner do
  # describe '.new' do
  #   it 'sets to pattern' do
  #     STDIN.stub(:gets).and_return('oxoox')
  #     @planner = EconomyPlanner.new
  #     expect(@planner.instance_variable_get('@pattern')).to eql [true, false, true, true, false]
  #   end
  # end

  describe '#generate' do
    before do
      STDIN.stub(:gets).and_return(playing_pattern)
    end

    subject { EconomyPlanner.new.generate }

    context 'given oxxxxoooo' do
      let(:playing_pattern) { 'oxoxx' }
      it { should eql 3 }
    end

    context 'given oxxxxoooo' do
      let(:playing_pattern) { 'oxxxxoooo' }
      it { should eql 2 }
    end
  end
end

