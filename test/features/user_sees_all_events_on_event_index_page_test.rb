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

end
