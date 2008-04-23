module ControllerTestHelper
  # asserts that the given pattern exists within the response body for the current request
  # pattern is either a string or a regular expression
  def assert_response_matches(pattern)
    assert_match pattern, @response.body, "should contain pattern #{pattern.to_s} in response"
  end
  
  # asserts that the expected value is assigned to the specified variable
  # variable => "symbol representing assigned value" (:user for @user)
  def assert_assigned(expected_value, variable)
    assert_equal expected_value, assigns(variable)
  end
  
  # asserts that the specified pattern matches the given flash variable
  # variable => "symbol for the flash key" (i.e :notice)
  def assert_flash expected_pattern, variable
    assert_match expected_pattern, flash[variable]
  end
  
  # request_with_fred(:get, :create, :session_param => "value")
  def request_with_fred(request_method, action, params={}, session={})
    session.reverse_merge!(:user_id => users(:fred).id)
    method(request_method).call(action, params, session)
  end
  
  # xhr_request_with_fred(:get, :create, :session_param => "value")
  def xhr_request_with_fred(request_method, action, params={}, session={})
    session.reverse_merge!(:user_id => users(:fred).id)
    xhr request_method, action, params, session
  end
  
  # request_with_george(:get, :create, :session_param => "value")
  def request_with_george(request_method, action, params={}, session={})
    session.reverse_merge!(:user_id => users(:george).id)
    method(request_method).call(action, params, session)
  end
  
  # xhr_request_with_george(:get, :create, :session_param => "value")
  def xhr_request_with_george(request_method, action, params={}, session={})
    session.reverse_merge!(:user_id => users(:george).id)
    xhr request_method, action, params, session
  end
end