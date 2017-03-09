#!/usr/bin/ruby

if 1 == 1 then
  print "1 == 1\n\n"
else
  print "1 != 1\n\n"
end

if "1" == 1 then
  print "\"1\" == 1\n\n"
else
  print "\"1\" != 1\n\n"
end

if "1" == "1" then
  print "\"1\" == \"1\"\n\n"
else
  print "\"1\" != \"1\"\n\n"
end

if "1" == 1 then
  print "\"1\" === 1\n\n"
else
  print "\"1\" !== 1\n\n"
end

if "1" == "1" then
  print "\"1\" === \"1\"\n\n"
else
  print "\"1\" !== \"1\"\n\n"
end
