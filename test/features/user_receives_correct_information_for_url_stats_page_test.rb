require_relative '../test_helper'

class UserReceivesCorrectInformationForURLStatsPageTest < FeatureTest

  def test_user_sees_error_that_identifier_doesnt_exist_when_requesting_url_page_for_unregistered_client
    visit '/sources/GOPATRIOTS/urls/pretzels'

    assert page.has_content?("The identifier does not exist.")
  end

  def test_user_sees_error_that_url_does_not_exist_when_it_hasnt_been_recorded
    Client.create(name: "Turing", root_url: "http://turing.io")

    visit '/sources/Turing/urls/pretzels'

    assert page.has_content?("That URL has not been requested.")
  end

  def test_user_sees_url_statistics_when_url_has_been_recorded
    visit '/sources/JumpstartLabs/urls/blog'

    assert "/sources/jumpstartlab/urls/blog", current_path
    refute page.has_content?("Error")

    within '#page-title' do
      assert page.has_content?("URL Details")
    end

    within '#response-time-table' do
      assert page.has_content?("URL Response Times")
      assert page.has_content?(67)
      assert page.has_content?(37)
      assert page.has_content?(52.0)
    end

    within '#request-type-table' do
      assert page.has_content?("HTTP Request Types")
      assert page.has_content?("GET")
      refute page.has_content?("POST")
    end

    within '#referrals-table' do
      assert page.has_content?("Referrals")
      assert page.has_content?("http://jumpstartlab.com")
      assert page.has_content?(2)
    end

    within '#top-user-agents-table' do
      assert page.has_content?("Top User Agents")
      assert page.has_content?("Chrome 24.0.1309.0")
      assert page.has_content?(2)
    end
  end

end
