class CalculateExpressionJob < ApplicationJob
  queue_as :default
  retry_on Exception, wait: 5.seconds, attempts: 4

  @@total= 0 
  @@total_time = 0
  def perform(message)
    retries = message['retry'].to_i
    Rails.logger.info  "[CalculateExpressionJob] begin job: #{message.to_json}" 
    puts "[CalculateExpressionJob] begin job: #{message.to_json}"   
    if (retries >= 4)
      Rails.logger.info "[CalculateExpressionJob] pushing morque queue job: #{message.to_json}"
      puts "[CalculateExpressionJob] pushing morque queue job: #{message.to_json}"
    else 
      Rails.logger.info "[CalculateExpressionJob] begin job: #{message.to_json}"  
      unless (isValid(message))
        message['retry'] = retries + 1
        Rails.logger.info "[CalculateExpressionJob] push to retry job: #{message.to_json}"
        puts "[CalculateExpressionJob] push to retry job: #{message.to_json}"
        raise "raise Invalid Error"
      end  
      @@total = @@total + 1
      t1 = message['start'].to_i
      t2 = (Time.now.to_f * 1000).to_i
      @@total_time = @@total_time + (t2 - t1)
      
      Rails.logger.info "[CalculateExpressionJob] Performed job: #{message.to_json}"
      Rails.logger.info "[CalculateExpressionJob] Answer:#{calculate(message)} Total jobs:#{@@total} Time:#{@@total_time}"
      puts "[CalculateExpressionJob] Performed job: #{message.to_json}"
      puts "[CalculateExpressionJob] Answer:#{calculate(message)} Total jobs:#{@@total} Total Time:#{@@total_time}"
    end 
  end
  
  private 
    def isValid(message)
      if (message.has_key?('a') && message.has_key?('b')) 
        if (is_i?(message['a']) && is_i?(message['b']))
          true
        else
          false 
        end    
      else
        false 
      end 
    end

    def is_i?(str)
      !!(str =~ /\A[-+]?[0-9]+\z/)
    end

    def calculate(message)
      a = message['a']
      b = message['b'] 
      a.to_i + b.to_i 
    end    
end
