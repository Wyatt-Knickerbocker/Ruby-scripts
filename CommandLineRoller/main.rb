#!/usr/bin/ruby

require '~/CompSci/Languages/Ruby/CommandLineRoller/utilities'
require '~/CompSci/Languages/Ruby/CommandLineRoller/roll'
def printhelp()
  puts("A command-line dice roller.")
  puts("xdy rolls y dice x times")
  puts("ex: 2d6 rolls a six-sided dice twice.")
  puts("To modify the roll, seperate each below with a '.'")
  puts("s will show you the results of each roll")
  puts("v will show you what your roll does (for debugging purposes)")
  puts("ax will add x to the end of the roll")
  puts("ex: 2d6.a3 will roll 2 six-sided dice and add 3 to the result")
  puts("ex will add x to the result of EACH roll")
  puts("ex: 2d6.e3 will roll 2 dice and add three to each roll")
  puts("hx will reroll all dice at or above x and add the result")
  puts("ex: 2d6.h5 will reroll each dice above 5 and add each result")
  puts("lx works like ux except it rerolls below a certain number")
  puts("abx will count a success for each dice at or above x")
  puts("ex: 2d6.ab5 will print success if a dice rolls at or above 5")
  puts("blx works like abx except it counts success below a number")
end

lastroll = ""

  raw = ARGV[0]

  if raw == nil then
    printhelp()
    exit
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

    if /s/ =~ a then
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

    if /a([-]?)(\d+)/ =~ a then
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
    if /e([-]?)(\d+)/ =~ a then
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
    if (/ab(\d+)/ =~ a) then
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
    if (/bl(\d+)/ =~ a) then
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
    if (/h(\d+)/ =~ a) then
      if Regexp.last_match(1).to_i <= 1 then
        puts("Please enter a number greater than 1.")
        exit
      end
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

    if /l(\d+)/ =~ a then
      if Regexp.last_match(1).to_i >= sides then
        puts("Please enter a number less than the number of sides.")
        exit
      end
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
