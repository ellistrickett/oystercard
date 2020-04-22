require 'oystercard'
RSpec.describe Oystercard do
  let(:entry_station){ double :station } 
  let(:exit_station){ double :station } 
  let(:trip){ {entry_station: entry_station, exit_station: exit_station} }


  it 'has a default balance of 0' do 
    expect(subject.balance).to eq 0
  end

  it 'tops up card by amount given' do 
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  it 'has a limit of £90' do 
    max_balance = Oystercard::MAX_BALANCE
    subject.top_up(max_balance)
    expect{ subject.top_up(90) }.to raise_error "Maximum Balance £#{max_balance} exceeded"
  end

  it 'deducts money from balance' do
    subject.top_up(10) 
    expect{ subject.deduct 3 }.to change{ subject.balance }.by -3
  end

  it 'starts off not in a journey' do 
    expect(subject).not_to be_in_journey
  end

  it 'raises error if balance is less than £1' do
    expect{ subject.touch_in(entry_station)  }.to raise_error 'Insufficient funds'
  end

  it 'has an empty list of trips by default' do 
    expect(subject.trips).to be_empty
  end

  describe '#touch_in' do 
    before do 
      subject.top_up(10)
      subject.touch_in(entry_station) 
    end
    it 'touches in' do
      expect(subject).to be_in_journey
    end
    it 'stores the entry station' do 
      expect(subject.touch_in(entry_station)).to eq entry_station
    end
  end

  describe '#touch_out' do 
    before do 
      subject.top_up(10) 
      subject.touch_in(exit_station) 
    end
    it 'touches out' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it 'deducts minumum fare from balance' do 
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -1
    end
  end

    it 'stores journey history' do 
      subject.top_up(10) 
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.trips).to include trip
    end
end 