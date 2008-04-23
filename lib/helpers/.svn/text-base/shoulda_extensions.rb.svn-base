module ThoughtBot::Shoulda::Controller::ClassMethods
 
  # checks that the the action has rendered json
  # ex. should_render_json :result => true, :confirmed => true, :user_id => "@user.id"
  #
  def should_render_json(expected_hash, response=nil)
    should "render json result in proper format" do
      assert_match(/json/, @response.headers['type'])
      result_hash = JSON.parse(response || @response.body).stringify_keys # parse json response to hash
      expected_hash = JSON.parse(eval_hash(expected_hash).to_json) # eval keys
      assert_equal expected_hash, result_hash, "should have returned expected json response"   
    end
  end

  # should_redirect_to_login :edit, :update, :show
  def should_check_for_login(*actions)
    actions.each do |action|
      context "on not being logged in for #{action} action" do
        should "redirect to login" do
          post action, nil, nil
          assert_redirected_to introduction_url, "should have been taken to login"
          assert_flash "Please log in to continue!", :notice
        end
      end
    end
  end
  
  def should_verify_post(*actions) 
    actions.each do |action|
      context "on performing get requests for #{action} action" do
        should "respond with 405 post only" do
          request_with_fred(:get, action, nil)
          assert_response 405
        end
      end
    end
  end

  # should_render_errors :first_name, :zipcode
  def should_render_errors(*errors)
    should "render errors for invalid fields" do
      assert_select "div#errorExplanation" do
        errors.each do |error|
           formatted_error = error.to_s.humanize
           assert_select "li", /#{formatted_error}/, "should have error for #{formatted_error}"
        end
      end
    end
  end
  
  # should_render_nothing
  def should_render_nothing
    should "render nothing" do            
      assert_template nil
    end
  end
  
  # should_contain_in_response /some regexp/
  def should_contain_in_response(pattern)
    should "contain the pattern within the response" do
      assert_match pattern, @response.body, "should contain the pattern '#{pattern}' in response"
    end
  end
  
  # options => { :as => '@heather' } 
  # should_assign_value_to :friend, :as => '@heather'
  def should_assign_value_to(name, options)    
    should "assign value to '@#{name}'" do
      value = (options[:as].kind_of? String) ? eval(options[:as]) : options[:as]
      assert_assigned value, name.to_sym
    end
  end
  
  # options => { :in => "session_key" }
  # should_store_to_session 1, :in => 'user_id'
  def should_store_to_session(value, options)
    key = options[:in]
    should "store session value '#{value}' in key '#{key}'" do
      value = (options[:as].kind_of? String) ? eval(options[:as]) : options[:as]
      assert_equal value, session[key.to_s]
    end
  end
  
  # asserts that a certain value should be nil
  # ex. should_be_nil "@user.id"
  def should_be_nil(value)
    should "be not have a value" do
      assert_nil value.class == String ? eval(value) : value
    end
  end  
end