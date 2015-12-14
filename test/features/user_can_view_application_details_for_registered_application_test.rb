require_relative '../test_helper'
require_relative '../simulation_environment/client_environment_simulator'

class UserCanViewApplicationDetailsForRegisteredApplicationTest < FeatureTest

  def test_user_can_view_application_details_for_registered_application
    visit '/sources/JumpstartLabs/'

    refute page.has_content?("Error")

    within '#client-name' do
      assert page.has_content?("Jumpstartlabs")
    end

    within '#url-request-table' do
      assert page.has_content?("URL Paths")
      assert page.has_content?(2)
      assert page.has_content?("blog")
      refute page.has_content?(3)
      refute page.has_content?("pretzels")
    end

    within '#user-agent-table' do
      assert page.has_content?("Browser")
      assert page.has_content?("Chrome 24.0.1309.0")
      refute page.has_content?("Mozilla")
      assert page.has_content?("Operating System")
      assert page.has_content?("Mac OS X 10.8.2")
      refute page.has_content?("Windows")
      assert page.has_content?("Resolution")
      assert page.has_content?("1920 x 1280")
    end

    within '#response-time-table' do
      assert page.has_content?("URL Response Times")
      assert page.has_content?(52.0)
      assert page.has_content?("blog")
    end

    within '#paths-table' do
      assert page.has_content?("URL Links")
      assert page.has_content?("http://jumpstartlab.com/blog")
    end
  end

  def test_user_sees_error_message_when_trying_to_view_application_details_for_unregistered_application
    visit '/sources/butterflies/'

    within '#error-message' do
      assert page.has_content?("The identifier does not exist.")
    end
  end


end
