
# Kisi-test.

## Basic Info.

  A rails App that sends 2 value 'a' and 'b' to background job. The Background job calculates summary of the numbers or it fails if the numbers are unable to be converted into Integer.

  There are two ActiveJobs "PushMessagePubsubJob" and "CalculateExpressionJob".
  PushMessagePubsubJob pushes a message to GooglePubSub. The message comes from A WelcomeController.
  Pubsub listerer - worker - recieves the message from Google PubSub and it pushes the message to "CalculateExpressionJob".
  CalculateExpressionJob runs to calculate the values in the message.
  It fails and retries if the values are not Integer.

## How to Run

  I hope you already have Google SDK and google service account.
  - edit config/settings.yml
  
     project_id: [PROJECT_ID].
     
     pubsub_topic: baterdene-kisi-topic
     
     pubsub_subscription: baterdene-kisi-sub
     
  - __[PROJECT_ID] value needs to be changed into an unique Cloud ID. Please change it !!!__
  
  - run following commands to create pubsub project, topic ,and sub.
  
     * __gcloud projects create [PROJECT_ID]__
     
     * __gcloud pubsub topics create baterdene-kisi-topic__
     
     * __gcloud pubsub subscriptions create baterdene-kisi-topic --topic baterdene-kisi-sub__
     
     * Please make sure that you are loggin in google cloud service and account if you face any errors.
     * it might ask you to log in with google service account. 
        
  - run following commands to run background worker.
  
     __bundle exec run run_worker__
     
  - Open different command console and run following commands to start Rails app server.
     1. __bundle install 
     2. __rails s -p 8080__
  - Open your browser and visit localhost:8080.
  
  - Send numbers or other strings and take a look at other console. 
