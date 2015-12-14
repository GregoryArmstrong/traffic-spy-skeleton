require_relative '../test_helper'

class UserSeesAllEventsOnEventIndexPageTest < FeatureTest

  def test_user_sees_all_events_on_event_index_page_with_valid_events
    visit '/sources/JumpstartLabs/events'

    assert page.has_content?("Events Index")
    refute page.has_content?("Error")

    within '#event-index-table' do
      assert page.has_content?("socialLogin")
      assert page.has_content?(2)
    end
  end

  def test_user_sees_no_events_for_registered_user_with_no_payloads
    Client.create(name: "Turing", root_url: "http://turing.io")
    visit '/sources/Turing/events'

    assert page.has_content?("Error")
    assert page.has_content?("No events have been defined.")
  end

  def test_user_can_redirect_to_specific_event_page
    visit '/sources/JumpstartLabs/events'

    click_link("socialLogin")

    assert '/sources/JumpstartLabs/events/socialLogin', current_path
  end

end
