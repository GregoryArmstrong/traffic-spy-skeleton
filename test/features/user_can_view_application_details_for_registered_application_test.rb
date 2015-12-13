require_relative '../test_helper'
require_relative '../simulation_environment/client_environment_simulator'

class UserCanViewApplicationDetailsForRegisteredApplicationTest < FeatureTest

  def test_user_can_view_application_details_for_registered_application
    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/google/'

    within '#client-name' do
      assert page.has_content?("Google")
    end

    within '#url-request-table' do
      assert page.has_content?("URL Paths")
    end

    within '#user-agent-table' do
      assert page.has_content?("Browser")
      assert page.has_content?("Operating System")
      assert page.has_content?("Resolution")
    end

    within '#response-time-table' do
      assert page.has_content?("URL Response Times")
    end

    within '#paths-table' do
      assert page.has_content?("URL Links")
    end
  end

  def test_user_sees_error_message_when_trying_to_view_application_details_for_unregistered_application
    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/butterflies/'

    within '#error-message' do
      assert page.has_content?("The identifier does not exist.")
    end
  end


end
