#!/usr/bin/ruby

require "../utilities"

a = Array.new
command = Array.new

while(true)

  print "?: "
  rcommand = gets.chomp

  command = splice(rcommand, " ")

  if command[0] == "push" then
    a.push(command[1])
    printarr(a)

  elsif command[0] == "pop" then
    a.pop
    printarr(a)

  elsif command [0] == "pull" then
    a.shift
    printarr(a)

  else
    print "Sorry! Unknown command! Quitting!\n"
    break
  end
end
