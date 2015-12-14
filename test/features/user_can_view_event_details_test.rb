require_relative '../test_helper'

class UserCanViewEventDetailsTest < FeatureTest

  def test_user_can_view_event_details_happy_path
    visit '/sources/JumpstartLabs/events/socialLogin'

    refute page.has_content?("Error")
    within '#event-details-title' do
      assert page.has_content?("Event Details")
      assert page.has_content?("socialLogin")
    end

    within '#event-details-table' do
      assert page.has_content?(12)
      assert page.has_content?(21)
      assert page.has_content?(24)
    end
  end

  def test_user_cannot_view_event_details_for_unregistered_identifier
    visit '/sources/iguanas/events/socialLogin'

    within '#error-message' do
      assert page.has_content?("The identifier does not exist.")
    end
  end

  def test_user_cannot_view_event_details_for_event_that_hasnt_been_recorded
    visit '/sources/JumpstartLabs/events/makingtaylorcryaftermethodicallydisassemblinghiminsupersmashbrothers'

    within '#error-message' do
      assert page.has_content?("That event isn't defined.")
    end
  end



end
