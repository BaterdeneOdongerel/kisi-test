require "google/cloud/pubsub"
module QueueAdapter
  class PubSubAdapter
    extend PubSubBase
    def self.push_message job
      Rails.logger.info "[PubSubQueue] enqueue job #{job}"
      topic = pubsub.topic pubsub_topic
      topic.publish job
    end
  end
end
