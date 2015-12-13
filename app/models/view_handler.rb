module ViewHandler

  def self.assign_application_details_erb_path(client)
    return :application_details if client && !client.payloads.empty?
    return :error
  end

  def self.assign_application_details_error_message(client)
    return "No payload data has been received for this source." if client && client.payloads.empty?
    validate_identifier_message(client)
  end

  def self.assign_url_details_erb_path(path)
    return :url_details if Payload.unique_paths.include?(path)
    return :error
  end

  def self.assign_url_details_error_message(path)
    "That URL has not been requested." if !Payload.unique_paths.include?(path)
  end

  def self.assign_events_index_erb_path(client)
    return :events_index unless client.payloads.empty?
    return :error
  end

  def self.assign_events_index_error_message(client)
    validate_identifier_message(client)
    "No events have been defined." if client.payloads.empty?
  end

  def self.assign_event_details_erb_path(client, event_name)
    return :error if client.nil?
    return :event_details if Payload.find_by(event_name: event_name)
    return :event_details_error
  end

  def self.assign_event_details_error_message(client, event_name)
    return "The identifier does not exist." if client.nil?
    return "That event isn't defined." if !Payload.find_by(event_name: event_name)
  end

  def self.validate_identifier_message(client)
    return "The identifier does not exist." if client.nil?
  end

  def self.validate_identifier_erb(client)
    return :error if client.nil?
  end

end
