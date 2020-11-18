class PushMessagePubsubJob < ApplicationJob
  queue_as :default
  def perform(message)
    puts "Pushing message => #{message.to_json}"
    QueueAdapter::PubSubAdapter.push_message(message)
  end
end
