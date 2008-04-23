module GeneralTestHelper
  # asserts that the given statement is true
  def assert_true(statement, message ='')
    assert_equal true, statement, message
  end
  
  # asserts that the given statement is false
  def assert_false(statement, message='')
    assert(statement == false || statement == nil, message)
  end
  
  # asserts that the given expression is not blank
  def assert_not_blank(expression)
    assert_false expression.blank?
  end
  
  # asserts that the given item or an item in an array is of a given type
  # ex. assert_kind :some_class, @object => checks that @object.class == SomeClass
  def assert_kind(expected_class, actual_object)
    expected_class = expected_class.to_s.camelize # turn the expected class into a camelized string
    actual_object = actual_object.first if actual_object.respond_to? "each" # check first item
    assert_equal expected_class, actual_object.class.to_s, "expected object to be class '#{expected_class}' but was '#{actual_object.class}'"
  end
  
  # asserts that the given collection has the specified size
  # ex. assert_size 10, @collection
  def assert_size(expected_count, actual_collection)
    assert_equal expected_count, actual_collection.size, "collection expected size was '#{expected_count}' but actually was '#{actual_collection.size}'"
  end
  
  # asserts that a given item or item array is contained within the collection
  def assert_includes(expected_items, collection)
    expected_items = [ expected_items ] unless expected_items.respond_to? "size"
    expected_items.each { |item| assert collection.include?(item), "#{item.inspect} should be contained in the collection" }
  end
  
  # asserts that a given item or item array is not contained within the collection
  def assert_not_includes(expected_items, collection)
    expected_items = [ expected_items ] unless expected_items.respond_to? "size"
    expected_items.each { |item| assert_false collection.include?(item), "#{item.inspect} should not be contained in the collection" }
  end

  # evaluates each value in the hash turning it into the actual value  
  def eval_hash(raw_hash)
    raw_hash.each_pair { |key, value| raw_hash[key] = value.class == String ? eval(value) : value  }
  end
  
  #stops time within the block
  def stop_time(&block)
    current_time = Time.now
    Time.stubs(:now).returns(current_time)
    block.call
  end
end