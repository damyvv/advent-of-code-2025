require 'set'
layout = Hash.new {}
beams = Hash.new { 0 }
rows = 0
cols = 0
File.read('../inputs/day-07.txt').lines.each_with_index.each do |line, y|
  line.chars.each_with_index do |char, x|
    layout[[x, y]] = char if char == '^'
    beams[[x, y]] = 1 if char == 'S'
  end
  rows = y+1
  cols = line.length if y == 0
end

splits = 0
rows.times do |y|
  add_beam = -> (x,y,paths) { layout[[x, y]] = '|'; beams[[x, y]] += paths }
  row_beams = beams.select { |k, v| k[1] == y-1 }
  row_beams.each do |(x, _), paths|
    if layout[[x, y]] == '^'
      add_beam.call(x-1, y, paths)
      add_beam.call(x+1, y, paths)
      splits += 1
    else
      add_beam.call(x, y, paths)
    end
  end
end
p splits
p beams.filter { |k, _| k[1] == rows-1 }.values.sum