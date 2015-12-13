require_relative '../test_helper'

class UserSeesAllEventsOnEventIndexPageTest < FeatureTest

  def test_user_sees_all_events_on_event_index_page_with_valid_events
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
    ph = PayloadHandler.new(payload)

    visit '/sources/jumpstartlab/events'

    assert page.has_content?("Events Index")
    refute page.has_content?("Error")
  end

end
