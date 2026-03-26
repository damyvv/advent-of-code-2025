ranges, avail = File.read('../inputs/day-05.txt').split("\n\n").each_cons(2).map { |a, b| [a.scan(/(\d+)-(\d+)/).map { |v| v.map(&:to_i) }, b.scan(/\d+/).map(&:to_i)] }.flatten(1)

class IngredientRange
  attr_accessor :min, :max

  def initialize(min, max)
    @min = min
    @max = max
  end

  def fresh?(value)
    value >= min && value <= max
  end

  def trim(other)
    if other.min <= max
        other.max = [other.max, max].max
        @max = other.min - 1
    end
  end

  def total_fresh
    [@max - @min + 1, 0].max
  end
end

ranges.map! { |min, max| IngredientRange.new(min, max) }

puts avail.filter { |value| ranges.any? { |range| range.fresh?(value) }}.count

ranges.sort_by!{|r| [r.min, r.max]}
ranges.each_cons(2) do |left, right|
    left.trim(right)
end
p ranges.sum(&:total_fresh)