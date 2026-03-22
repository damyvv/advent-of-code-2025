SURROUNDING = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
input = File.read('../inputs/day-04.txt').lines.each_with_index.map do |line, y|
  line.chars.each_with_index.map do |c, x|
    [x, y] if c == '@'
  end
end.flatten(1).compact.to_set

p input.count { |x, y| SURROUNDING.count { |dx, dy| input.include?([x + dx, y + dy]) } < 4 }

count = 0
loop do
  remove = input.select { |x, y| SURROUNDING.count { |dx, dy| input.include?([x + dx, y + dy]) } < 4 }
  input -= remove
  count += remove.size
  break if remove.empty?
end
p count