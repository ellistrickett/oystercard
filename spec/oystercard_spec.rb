require 'oystercard'
RSpec.describe Oystercard do 
  it 'has a default balance of 0' do 
    expect(subject.balance).to eq 0
  end
  it { is_expected.to respond_to(:top_up).with(1).argument }
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
  describe '#touch_in' do 
    it 'touches in' do
      subject.top_up(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it 'raises error if balance is less than £1' do
      expect{ subject.touch_in }.to raise_error 'Insufficient funds'
    end
  end

  it 'touches out' do
    subject.top_up(10) 
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
end 