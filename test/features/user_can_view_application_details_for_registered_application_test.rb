require_relative '../test_helper'
require_relative '../simulation_environment/client_environment_simulator'

class UserCanViewApplicationDetailsForRegisteredApplicationTest < FeatureTest

  def setup
    post '/sources', {"identifier" => "JumpstartLabs", "rootUrl" => "http://jumpstartlab.com"}
    post '/sources/JumpstartLabs/data', {"payload"=>
               "{\"url\":\"http://jumpstartlab.com/blog\",
               \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
               \"respondedIn\":37,
               \"referredBy\":\"http://jumpstartlab.com\",
               \"requestType\":\"GET\",
               \"parameters\":[],
               \"eventName\":\"socialLogin\",
               \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
               \"resolutionWidth\":\"1920\",
               \"resolutionHeight\":\"1280\",
               \"ip\":\"63.29.38.211\"}",
               "identifier"=>"JumpstartLabs"}
    post '/sources/JumpstartLabs/data', {"payload"=>
               "{\"url\":\"http://jumpstartlab.com/blog\",
               \"requestedAt\":\"2013-02-16 12:38:28 -0700\",
               \"respondedIn\":67,
               \"referredBy\":\"http://jumpstartlab.com\",
               \"requestType\":\"GET\",
               \"parameters\":[],
               \"eventName\":\"socialLogin\",
               \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
               \"resolutionWidth\":\"1920\",
               \"resolutionHeight\":\"1280\",
               \"ip\":\"63.29.38.211\"}",
               "identifier"=>"JumpstartLabs"}
  end

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
