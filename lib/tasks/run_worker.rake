desc "start worker queue"
task run_worker: :environment do
  Worker::PubSubWorker.run_worker!
end

