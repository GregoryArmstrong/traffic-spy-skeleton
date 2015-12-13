module ViewHandler

  # Assign ERB Path Logic

  def self.assign_application_details_erb_path(client)
    return :application_details if client && !client.payloads.empty?
    return :error
  end

  def self.assign_url_details_erb_path(path)
    return :url_details if Payload.unique_paths.include?(path)
    return :error
  end

  def self.assign_events_index_erb_path(client)
    return :events_index unless client.payloads.empty?
    return :error
  end

  def self.assign_event_details_erb_path(client, event_name)
    return :error if client.nil?
    return :event_details if Payload.find_by(event_name: event_name)
    return :event_details_error
  end

  def self.assign_application_details_error_message(client)
    return "The identifier does not exist." if client.nil?
    return "No payload data has been received for this source." if client && client.payloads.empty?
  end



  # Assign Error Message Logic (if applicable)

  def self.validate_identifier_message(client)
    return "The identifier does not exist." if client.nil?
  end

  def self.assign_url_details_error_message(client, path)
    return "The identifier does not exist." if client.nil?
    return "That URL has not been requested." if !Payload.unique_paths.include?(path)
  end

  def self.assign_events_index_error_message(client)
    return "The identifier does not exist." if client.nil?
    return "No events have been defined." if client.payloads.empty?
  end


  def self.assign_event_details_error_message(client, event_name)
    return "The identifier does not exist." if client.nil?
    return "That event isn't defined." if !Payload.find_by(event_name: event_name)
  end


  # Helper Methods

  def self.set_path(client, path)
    if client
      client.root_url + "/#{path}"
    else
      nil
    end
  end

end
