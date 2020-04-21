class Oystercard

  attr_reader :balance
  attr_reader :entry_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @entry_station = nil
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum Balance £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE 
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    @in_use = true
    @entry_station = station
  end

  def in_journey?
    @entry_station
  end

  def touch_out
    @in_use = false
    deduct(MIN_BALANCE)
    @entry_station = nil
  end
end