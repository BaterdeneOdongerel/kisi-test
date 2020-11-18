require "google/cloud/pubsub"
module Worker
  class PubSubWorker
    extend PubSubBase
    def self.run_worker!
        Rails.logger.info "Running [PubSubWorker] to lookup messages"
        topic        = pubsub.topic pubsub_topic
        subscription = topic.subscription pubsub_subscription
        subscriber = subscription.listen do |message|
          message.acknowledge!
          puts "[PubSubWorker] dequeue job (#{message.data})"
          Rails.logger.info "[PubSubWorker] dequeue job (#{message.data})"
          CalculateExpressionJob.perform_now(eval(message.data)) if message
        end
        subscriber.start
        sleep
      end
  end
end
