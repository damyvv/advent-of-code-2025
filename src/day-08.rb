input = File.read('../inputs/day-08.txt').lines.map { |line| line.split(',').map(&:to_i) }

def closest_boxes(arr)
  arr.combination(2).sort_by { |a, b| (a[0]-b[0]).abs.pow(2) + (a[1]-b[1]).abs.pow(2) + (a[2]-b[2]).abs.pow(2) }
end

circuits = []
steps = 0
closest_boxes(input).each do |a, b|
  overlap, circuits = circuits.partition { |c| c.include?(a) || c.include?(b) }
  overlap.flatten!(1)
  overlap << a if !overlap.include?(a)
  overlap << b if !overlap.include?(b)
  circuits << overlap

  if circuits[0].length == input.length
    p a[0]*b[0]
    break
  end
  
  steps += 1
  if steps == 1000
    p circuits.map(&:length).max(3).reduce(1, &:*)
  end
end