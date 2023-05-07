class Event < Dry::Struct
  transform_keys(&:to_sym)

  attr_reader :record

  def to_s
    self.class.name
  end

  def publish!
    EventRecord.create!(name: self.class.name, params: self.to_h).tap do |record|
      self.send(:assign_record, record)
      self.class.repository.notify_subscribers(self)
    end
  end

  def self.inherited(base)
    base.extend(ClassMethods)

    class_name, method_name = base.name.split('::')

    class_name.constantize.define_singleton_method(method_name.underscore.to_sym) do |**kwargs|
      base.new(**kwargs)
    end

    class_name.constantize.define_singleton_method("publish_#{method_name.underscore}!") do |**kwargs|
      publish_event base, **kwargs
    end

    class_name.constantize.define_method(method_name.underscore.to_sym) do |**kwargs|
      base.new(**kwargs)
    end

    class_name.constantize.define_method("publish_#{method_name.underscore}!") do |**kwargs|
      publish_event base, **kwargs
    end

    super
  end

  def self.from(klass, payload, record_id)
    record = EventRecord.find(record_id)

    klass.constantize.new(payload.to_h).tap do |event|
      event.send(:assign_record, record)
    end
  end

  def self.repository
    @repository ||= EventRepository.instance
  end

  module ClassMethods
    def subscribers
      repository.subscribers[self.to_s]
    end

    def subscribe(handler)
      repository.subscribers[self.to_s] ||= []

      return if repository.subscribers[self.to_s].include?(handler.to_s)

      repository.subscribers[self.to_s] << handler.to_s
    end
  end

  private

  def assign_record(record)
    @record = record
  end
end
