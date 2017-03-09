class Diceroll


  def initialize (numrolls, sides, show, verbose, append, each, above, below, rerollhigh, rerolllow)
    @numrolls = numrolls
    @sides = sides
    @show = show
    @verbose = verbose;
    @append = append
    @each = each
    @above = above
    @below = below
    @rerollhigh = rerollhigh
    @rerolllow = rerolllow
    @rollcount = Array.new
    @success_count = 0
  end
  def describe
    if @verbose then
    puts "I am rolling a #{@sides}-sided die #{@numrolls} times."
    puts "I #{(@show == 0) ? "am not showing the result of each roll" : "am showing the result of each roll."}"
    puts "I #{(@each == 0) ? "am not adding" : "am adding #{@each}"} to each roll."
    puts "I #{(@append == 0) ? "am not adding" : "am adding #{@append}"} to the end of the roll."
    puts "I #{(@above != 0) ? "am looking for successes for rolls above #{@above}." : "am not looking for rolls above a certain number."}"
    puts "I #{(@below != 0) ? "am looking for successes for rolls above #{@below}." : "am not looking for rolls below a certain number."}"
    puts "I #{(@rerollhigh == 0) ? "am not rerolling high numbers." : "am rerolling and adding numbers higher than or equal to #{@rerollhigh}"}"
    puts "I #{(@rerolllow == 0) ? "am not rerolling low numbers" : "am rerolling and adding numbers less than or equal to #{@rerolllow}"}"
    end
  end

  def rolldice
    i = 0
    total = 0
    curr_roll = 0

    until i>= @numrolls do

      #This happens regardless.
      curr_roll = 1+rand(@sides)

      #Each flag should add its number to the roll.
      #It would be zero if not flagged so it should always be added.
      total += (curr_roll + @each)

      @rollcount << curr_roll

      if @above != 0 then
        if curr_roll >= @above then
          @success_count += 1
        end
      end

      if @below != 0 then
        if curr_roll <= @below then
          @success_count += 1
        end
      end

      #This will show each roll, with possible additions.
      if @show != 0 then
        if @each != 0 then
          puts "Rolled #{curr_roll}#{@each}"
        else
          puts "Rolled #{curr_roll}"
        end
      end

      if @rerollhigh != 0 then
        if curr_roll >= @rerollhigh then
          total +=  rollagain(curr_roll, 1)
        end
      end

      if @rerolllow != 0 then
        if curr_roll <= @rerolllow then
          total +=  rollagain(curr_roll, 1)
        end
      end





      #End of loop stuff
      i += 1
    end

      #Same as each above.
      total += @append


    puts "total is: " + total.to_s + "."
    if @above != 0 or @below != 0 then
      puts "#{@success_count} success#{@success_count == 1 ? "" : "es"}."
    end

  end

  def rollagain (totalcurr, rollcount)

    total = 0
    tab = "\t"
    rollagain = 1+rand(@sides)

    total += rollagain+@each

    if @above != 0 then
      if rollagain >= @above then
        @success_count += 1
      end
    end

    if @below != 0 then
      if rollagain <= @below then
        @success_count += 1
      end
    end


    if @show != 0 then
      if @each != 0 then
        puts "#{tab*rollcount}Rolled #{rollagain}#{@each}"
      else
        puts "#{tab*rollcount}Rolled #{rollagain}"
      end
    end

      if @rerollhigh != 0 then
        if rollagain >= @rerollhigh then
          total +=  rollagain(totalcurr, rollcount +1)
        end
      end

      if @rerolllow != 0 then
        if rollagain <= @rerolllow then
          total +=  rollagain(totalcurr, rollcount + 1)
        end
      end

    return total

  end

end
