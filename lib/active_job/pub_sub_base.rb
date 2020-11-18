module PubSubBase
    def pubsub
        @pubsub ||= begin
          project_id = Rails.application.config.x.settings["project_id"]
          Google::Cloud::Pubsub.new project_id: project_id
        end
    end
    def pubsub_topic
        @pubsub_topic ||= Rails.application.config.x.settings["pubsub_topic"]
    end

    def pubsub_subscription
        @pubsub_subscription ||= Rails.application.config.x.settings["pubsub_subscription"]
    end 
end    