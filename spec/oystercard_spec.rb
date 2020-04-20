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
end