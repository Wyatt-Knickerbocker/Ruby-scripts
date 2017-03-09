sides = 20
rolldist = Array.new(sides, 0)
for i in 1..10000 do
  roll = rand(sides)
  rolldist[roll] += 1
end

i = 0
rolldist.each{ |a|
  puts "#{i+= 1}: #{a}"
}
