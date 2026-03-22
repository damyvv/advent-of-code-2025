input = File.open('../inputs/day-01.txt').readlines.map(&:chomp)
input.map! { |line| line.gsub("L", '-').gsub("R", '').to_i }

p input.reduce({:dial => 50, :count => 0}) { |dial, val|
  dial[:dial] = (dial[:dial] + val) % 100
  dial[:count] += 1 if dial[:dial] == 0
  dial
}

p input.reduce({:dial => 50, :count => 0}) { |dial, val|
  val.abs.times do |_|
      dial[:dial] = (dial[:dial] + (val.abs/val)) % 100
      dial[:count] += 1 if dial[:dial] == 0
  end
  dial
}