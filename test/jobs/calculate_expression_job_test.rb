require 'test_helper'
require 'rails_helper'

class CalculateExpressionJobTest < ActiveJob::TestCase
  subject(:job) {described_class.perform_now({'a' => 1 , 'b' => 2 , 'retry' => 1 , start = '123123'}) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in default queue' do
    expect(CalculateExpressionJobTest.new.queue_name).to eq('default')
  end

  it 'executes perform' do
    perform_enqueued_jobs { job }
  end

  it 'handles invalid error and retry' do
    allow(CalculateExpressionJobTest).to receive(:call).and_return(false)

    perform_enqueued_jobs do
      expect_any_instance_of(CalculateExpressionJobTest)
        .to receive(:retry_job).with(wait: 5.seconds, queue: :default)

      job
    end
  end
end
