
#Kisi-test.

##Basic Info.

  A rails App that sends 2 value 'a' and 'b' to background job. The Background job calculates summary of the numbers or it fails if the numbers are unable to be converted into Integer.

  There are two ActiveJobs "PushMessagePubsubJob" and "CalculateExpressionJob".
  PushMessagePubsubJob pushes a message to GooglePubSub. The message comes from A WelcomeController.
  Pubsub listerer - worker - recieves the message from Google PubSub and it pushes the message to "CalculateExpressionJob".
  CalculateExpressionJob runs to calculate the values in the message.
  It fails and retries if the values are not Integer.

##How to Run

  I hope you already have Google SDK and google service account.
  1. edit config/settings.yml
  
     project_id: [PROJECT_ID].
     
     pubsub_topic: baterdene-kisi-topic.
     
     pubsub_subscription: baterdene-kisi-sub
     
  2. [PROJECT_ID] value needs to be changed so that it can be unique Cloud uniqeq ID. Please change it !!!
  
  3. run following commands to create pubsub project, topic ,and sub.
  
     1. gcloud projects create [PROJECT_ID].
     
     2. gcloud pubsub topics create baterdene-kisi-topic.
     
     3. gcloud pubsub subscriptions create baterdene-kisi-topic --topic baterdene-kisi-sub.
     
        Please make sure that you are loggin in google cloud service and account if you face any errors.
        
  4. run following commands to run background worker.
  
     bundle exec run run_worker
     
  5. enter 2 number and send.
  
  6. Take look at the other console that runs worker.
