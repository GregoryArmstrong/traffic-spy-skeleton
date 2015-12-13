require_relative '../test_helper'

class UserCanViewEventDetailsTest < FeatureTest

  def test_user_can_view_event_details_happy_path
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
    ph = PayloadHandler.new(payload)

    visit '/sources/jumpstartlab/events/socialLogin'

    refute page.has_content?("Error")
    within '#event-details-title' do
      assert page.has_content?("Event Details")
      assert page.has_content?("socialLogin")
    end
  end

  def test_user_cannot_view_event_details_for_unregistered_identifier
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
    ph = PayloadHandler.new(payload)

    visit '/sources/iguanas/events/socialLogin'

    within '#error-message' do
      assert page.has_content?("The identifier does not exist.")
    end
  end

  def test_user_cannot_view_event_details_for_event_that_hasnt_been_recorded
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
    ph = PayloadHandler.new(payload)

    visit '/sources/jumpstartlab/events/makingtaylorcryaftermethodicallydisassemblinghiminsupersmashbrothers'

    within '#error-message' do
      assert page.has_content?("That event isn't defined.")
    end
  end



end
