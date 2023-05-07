class EventRepository
  include Singleton

  def subscribers
    @subscribers ||= {}
  end

  def notify_subscribers(event)
    subscribers[event.class.name].each do |subscriber|
      event_handler = subscriber.constantize

      if event_handler.async?
        EventWorker.perform_async(event.class.name, event.record.id, event.as_json, subscriber)
      else
        event_handler.new(event).perform
      end
    end
  end
end
