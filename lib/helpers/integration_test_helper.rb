module IntegrationTestHelper
  
  # asserts that an email has been sent
  def assert_email_sent(keyword=nil)
    deliveries = ActionMailer::Base.deliveries
    assert deliveries.size > 0, "email should have been sent"
    assert_match(/#{keyword.to_s}/, deliveries[0].body, "email did not contain keyword '#{keyword}'") if keyword
  end
  
  def login_and_go(login, pass, destination_url)
    session[:user_id] = nil
    #user logging in
    xml_http_request :post, login_url, { :user => { :login => login, :password => pass } }
    assert_not_nil session[:user_id]
    #user browsing to url
    get destination_url
  end
  
  def click_link(destination_url, method=:get)
    assert @response.body.include?(destination_url), "That link does not exist on the page"
    method == :get ? get_via_redirect(destination_url) : (post_via_redirect destination_url)
  end
  
  # checks that a given checkbox on the form is checked
  # selector is the css selector to use i.e "#the-checkbox"
  def assert_select_checked(selector)
    assert_select selector, true, "Expected checkbox '#{selector}' to exist on page"
    assert_select "#{selector}[checked=checked]", true, "expected checkbox '#{selector}' to be checked"
  end
  
  # checks that a given checkbox on the form is  unchecked
  # selector is the css selector to use i.e "#the-checkbox"
  def assert_select_not_checked(selector)
    assert_select selector, true, "Expected checkbox '#{selector}' to exist on page"
    assert_select "#{selector}[checked=checked]", false, "expected checkbox '#{selector}' not to be checked"
  end
  
end
