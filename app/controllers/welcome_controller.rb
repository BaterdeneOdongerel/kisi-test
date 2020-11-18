class WelcomeController < ApplicationController
  def index
    if (params.has_key?(:a) && params.has_key?(:b))
      puts "recieved get request => a=#{params[:a]} b=#{params[:b]}"
      message = {
        'a' => params[:a],
        'b' => params[:b],
        'retry' => 1,
        'start' => (Time.now.to_f * 1000).to_i
      }
      PushMessagePubsubJob.perform_now(message.to_s)
    end 
  end
end
