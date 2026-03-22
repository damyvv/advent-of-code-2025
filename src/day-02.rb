input = File.read('../inputs/day-02.txt').scan(/(\d+)-(\d+)/).map { |a| a.map(&:to_i) }

output = input.map do |a, b|
  (a..b).select { |n| n.to_s.length.even? && n.to_s.chars.each_slice(n.to_s.length/2).uniq.length == 1 }
end
p output.flatten.sum

output = input.map do |a, b|
  (a..b).select {|n| (1..n.to_s.length/2).select { |l| n.to_s.length % l == 0 }.any? { |l| n.to_s.chars.each_slice(l).uniq.length == 1 } }
end
p output.flatten.sum