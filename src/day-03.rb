input = File.read('../inputs/day-03.txt').lines.map { |line| line.scan(/\d/).map(&:to_i) }
p input.map { |a| [a[0..-2].max, a[a.find_index(a[0..-2].max)+1..].max].join.to_i }.sum

p (input.map do |i|
  (1..12).reverse_each.reduce({:arr => i, :bank => []}) do |mp, idx|
    choices = mp[:arr][0..-idx]
    mp[:bank] << choices.max
    mp[:arr] = mp[:arr][choices.find_index(choices.max)+1..]
    mp
  end[:bank].join.to_i
end).sum
