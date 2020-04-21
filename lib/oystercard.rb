class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90

  def initialize 
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum Balance £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE 
    @balance += amount
  end
end