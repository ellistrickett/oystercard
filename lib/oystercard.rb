class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90

  def initialize
    @in_use = false 
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum Balance £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE 
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_use = true
  end

  def in_journey?
    @in_use
  end

  def touch_out
    @in_use = false
  end
end