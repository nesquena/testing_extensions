# TestingExtensions
require File.expand_path(File.dirname(__FILE__) + "/helpers/shoulda_extensions.rb")
require File.expand_path(File.dirname(__FILE__) + "/helpers/general_test_helper.rb")
require File.expand_path(File.dirname(__FILE__) + "/helpers/record_test_helper.rb")
require File.expand_path(File.dirname(__FILE__) + "/helpers/controller_test_helper.rb")
require File.expand_path(File.dirname(__FILE__) + "/helpers/integration_test_helper.rb")

module TestingExtensions
  # include testing helpers
  include GeneralTestHelper
  include RecordTestHelper
  include ControllerTestHelper
  include IntegrationTestHelper
end