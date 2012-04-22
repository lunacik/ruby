

RSpec::Matchers.define :have_id_equal do |expected_id|
  match do |actual|
    actual.class.add(actual)
    actual.id ==  expected_id
  end
end


RSpec::Matchers.define :have do |expected_count|
  match do |actual|
    actual.count == expected_count
  end
end

