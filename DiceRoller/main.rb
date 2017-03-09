#!/usr/bin/ruby

require '../utilities'
require './diceroll'

lastroll = ""
while(true)

  print "Roll: "
  raw = gets.chomp

  if raw == "exit" then
    puts "Thank you!"
    exit

  elsif raw == "help" then
    puts "Help incoming..."
    next

  elsif raw == "\e[A" then
    raw = lastroll
  end
  
  roll = Array.new
  lastroll = raw
  roll = (splice raw, '.')

  dieroll = roll.first

  /(\d+)?d(\d+)/ =~ dieroll

  numrolls = Regexp.last_match(1).to_i
  sides = Regexp.last_match(2).to_i

  to_roll = Array.new
  to_roll << numrolls
  to_roll << sides

#################################
######PARSING INTO FUNCTION######
#################################
  showflag = 0
  roll.each { |a|

    if /show/ =~ a then
      to_roll << 1
    showflag = 1
    break
    end
  }
  if showflag == 0 then
    to_roll << 0
  end
  verboseflag = false
  roll.each { |a|

    if /v/ =~ a then
      to_roll << true
    verboseflag = true
    break
    end
  }
  if verboseflag == false then
    to_roll << false
  end
  appendflag = 0
  roll.each { |a|

    if /add\(([-]?)(\d+)\)/ =~ a then
      #p "add success!"
      if Regexp.last_match(1) == "-" then
        to_roll << (0 - Regexp.last_match(2).to_i)
      else
        to_roll << Regexp.last_match(2).to_i
      end
    appendflag = 1
    break
    end
  }
  if appendflag == 0 then
    to_roll << 0
  end

  eachflag = 0
  roll.each { |a|
    if /each\(([-]?)(\d+)\)/ =~ a then
      if Regexp.last_match(1) == "-" then
        to_roll << (0 - Regexp.last_match(2).to_i)
      else
        to_roll << Regexp.last_match(2).to_i
      end
    eachflag = 1
    break
    end
  }
  if eachflag == 0 then
    to_roll << 0
  end

  aboveflag = 0
  roll.each { |a|
    if (/above\((\d+)\)/ =~ a) then
      to_roll << Regexp.last_match(1).to_i
    aboveflag = 1
    break
    end
  }
  if aboveflag == 0 then
    to_roll << 0
  end

  belowflag = 0
  roll.each { |a|
    if (/below\((\d+)\)/ =~ a) then
      to_roll << Regexp.last_match(1).to_i
    belowflag = 1
    break
    end
  }
  if belowflag == 0 then
    to_roll << 0
  end

  rollhighflag = 0
  roll.each { |a|
    if (/high\((\d+)\)/ =~ a) then
      to_roll << Regexp.last_match(1).to_i
    rollhighflag = 1
    break
    end
  }
  if rollhighflag == 0 then
    to_roll << 0
  end

  lowflag = 0
  roll.each { |a|

    if /low\((\d+)\)/ =~ a then
      to_roll << Regexp.last_match(1).to_i
    lowflag = 1
    break
    end
  }
  if lowflag == 0 then
    to_roll << 0
  end

  #Need to check for flags then pass them in, below, upon new.

  droll = Diceroll.new( to_roll[0], to_roll[1], to_roll[2], to_roll[3], to_roll[4], to_roll[5], to_roll[6], to_roll[7], to_roll[8], to_roll[9])

  droll.describe
  droll.rolldice

end
