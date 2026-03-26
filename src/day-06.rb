input = File.read('../inputs/day-06.txt').lines

p input.map(&:split).transpose.map { |arr| eval(arr[..-2].join(arr[-1])) }.sum

transposed = input.map { |line| line.tr("\n", '').chars}
  .transpose.map(&:join)
  .chunk { |l| !l.strip.empty? }
  .select(&:first).map(&:last)

result = transposed.map do |arr|
  operator = arr.map { |n| n[-1] }.join.strip
  numbers = arr.map { |n| n[..-2].to_i }
  eval(numbers.join(operator))
end
p result.sum