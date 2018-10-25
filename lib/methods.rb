# require_all 'app'
require 'pry'

def day_length
  sun_rise = "2018-10-24T06:12:59.885084-02:00"
  sun_set = "2018-10-24T19:29:15.416047-02:00"
  sr1 = sun_rise.split(/[T.]/)[1]
  ss1 = sun_set.split(/[T.]/)[1]
  sr2 = sr1.split(":")
  ss2 = ss1.split(":")
  hour = ss2[0].to_i - sr2[0].to_i
  min = (60 - sr2[1].to_i) + (ss2[1].to_i)
  if min > 60
    hour += 1
    min -= 60
  end
  puts "Day length today is #{hour} hours and #{min} minutes."
end



# day_length
