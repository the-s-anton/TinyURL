class EventWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'event_handlers'

  def perform(event_klass, event_record_id, event_payload, event_handler_klass)
    event = Event.from(event_klass, event_payload, event_record_id)
    event_handler = event_handler_klass.constantize.new(event)
    event_handler.perform_async
  end
end
