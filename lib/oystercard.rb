require_relative 'station'

class Oystercard

  attr_reader :balance, :trips, :trip

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @entry_station = nil
    @balance = 0
    @trips = []
    @trip = {}
  end

  def top_up(amount)
    raise "Maximum Balance £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE 
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    @entry_station = entry_station
  end

  def in_journey?
    @entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    create_trip_hash
    @entry_station = nil
    deduct(MIN_BALANCE)
  end

  def create_trip_hash
    trip[:entry_station] = @entry_station
    trip[:exit_station] = @exit_station
    @trips << trip
  end
end