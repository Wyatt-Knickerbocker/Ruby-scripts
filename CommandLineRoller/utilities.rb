#!/usr/bin/ruby
def splice (str = "", delimit = " ")

  if str == "" then
    puts "Need to enter a non-zero string."
    return ""
  end

  group = Array.new
  group = str.each_line(delimit)

  spliced = Array.new
  group.each { |a|
                 if a[-1] == delimit then
                   spliced << a[0..-2]
                 else
                   spliced << a
                 end }

  return spliced

end

def printarr(arr)

  arr.each{ |a|
    p a
  }

end
