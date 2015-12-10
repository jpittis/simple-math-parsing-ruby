def parse_top_level(stream)
  left_side = parse_multiply_divide(stream)
  first = stream.shift
  case first
  when '+' then left_side + parse_top_level(stream)
  when '-' then left_side - parse_top_level(stream)
  when ')' then left_side
  when nil then left_side
  else raise "Unknown symbol '#{first}'."
  end
end

def parse_multiply_divide(stream)
  left_side = parse_literal(stream)
  first = stream.shift
  case first
  when '*' then left_side * parse_multiply_divide(stream)
  when '/' then left_side / parse_multiply_divide(stream)
  else stream.unshift(first); left_side
  end
end

def parse_literal(stream)
  first = stream.shift
  case first
  when '(' then parse_top_level(stream)
  when /[0-9]/ then first.to_i
  else raise "Unknown literal '#{first}'."
  end
end

def parse_string(input)
  no_white_space = input.gsub(/\s+/, '')
  stream = no_white_space.split('')
  begin
    result = parse_top_level(stream)
  rescue StandardError => e
    puts e
  else
    puts "#{input} evaluated to #{result}."
  end
end

parse_string(ARGV[0])

