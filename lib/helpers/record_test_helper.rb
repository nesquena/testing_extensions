=begin

  This will include methods involving asserting various conditions on records.  

=end

module RecordTestHelper
  def assert_invalid(model, message='')
    assert_equal false, model.valid?, message
  end
  
  # Checks that the given record has an error on a specified attribute field
  # record = activerecord object
  # field  = symbol attribute name
  #
  # ex. assert_invalid_attribute(@user, :age)
  #
  def assert_invalid_attribute(record, field)
    assert_invalid record, "#{record.class} should not be saving with invalid value '#{record.send(field)}' for '#{field}'"
    assert record.errors.on(field), "'#{field}' should have an error' "
  end
  
  # Checks that each value is valid for that field within the record
  # ex. assert_valid_format(@user, :mobile_number, [ 'foo', 'bar' ]
  # checks that 'foo', 'bar', are acceptable values for the mobile number field
  def assert_valid_format(record, field, values)
    values.each do |value|
      record.send("#{field}=", value)
      assert record.valid?, "#{record.class} invalid with value '#{value}' for '#{field}'"
    end
  end
  
  # Checks that each value is invalid for that field within the record
  # record = activerecord object
  # field  = symbol attribute name
  # values = array of string values to try
  #
  # ex. assert_invalid_format(@user, :mobile_number, [ 'foo', 'bar' ])
  # checks that 'foo', 'bar', are not acceptable values for the mobile number field
  #
  def assert_invalid_format(record, field, values)
    values = [ values ] unless values.respond_to? :each # convert to array
    values.each do |value|
      record.send("#{field}=", value)
      assert_invalid_attribute(record, field)
    end
  end
  
  def assert_saved_record instance_variable
    assert_false assigns(instance_variable).new_record?, 'record should be saved'
  end
  
  def assert_new_record instance_variable
    assert_true assigns(instance_variable).new_record?, 'record should be new'
  end
  
  # expected_attributes = { :foo => "bar" } (Hash)
  # instance_variable = :person (Symbol)
  def assert_record_updated(expected_attributes, instance_variable, reload=true)
    assigns(instance_variable).reload if reload
    expected_attributes.each do |attribute, expected_value|
      attribute_value = assigns(instance_variable).send(attribute)
      assert_attributes_equal expected_value, attribute_value, "attribute '#{attribute}' expected to be '#{expected_value}', was '#{attribute_value}''"
    end
  end
  
  alias_method :assert_attributes_match, :assert_record_updated
  
  def assert_record_not_updated expected_attributes, instance_variable
    assigns(instance_variable).reload
    expected_attributes.each do |k, v|
      assert_not_equal v, assigns(instance_variable).send(k)
    end
  end
  
  def assert_attributes_equal(expected_value, actual_value, message=nil)
    expected_value = Time.parse(expected_value) if actual_value.class == Time 
    assert_equal expected_value, actual_value, message
  end
end