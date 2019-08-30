class LinebotController < ApplicationController
     require "line/bot"  # gem "line-bot-api"
 
     # callbackアクションのCSRFトークン認証を無効
     protect_from_forgery :except => [:callback]
 
     def client
       @client ||= Line::Bot::Client.new { |config|
         config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
         config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
       }
     end
     
     def callback
       body = request.body.read
   
       signature = request.env["HTTP_X_LINE_SIGNATURE"]
       unless client.validate_signature(body, signature)
         error 400 do "Bad Request" end
       end
   
       events = client.parse_events_from(body)
   
       events.each { |event|
         case event
         when Line::Bot::Event::Message
           case event.type
           when Line::Bot::Event::MessageType::Text
             message = [
               {
                 type: "text",
                 text: ["プロテイン足りてる？", 
                 "今日、ジム行く？",
                 "アーノルド・シュワルツェネッガー",
                 "ドウェイン・ジョンソン",
                 "乳酸たまってる？"].shuffle.first
               }
             ]
             
             if event.message['text'] =~ /上半身/
             message = [
               {
                 type: "text",
                 text: ["上腕二頭筋",
                 "上腕三頭筋",
                 "大胸筋",
                 "三角筋",
                 "腹直筋"].shuffle.first 
               }
             ]
            
            else event.message['text'] =~ /下半身/
             message = [
               {
                 type: "text",
                 text: ["大殿筋(お尻の筋肉)",
                 "大腿四頭筋(太ももの筋肉)",
                 "ヒラメ筋💓",
                 "ハムストリングス"].shuffle.first 
               }
             ]
            
             client.reply_message(event["replyToken"], message)
            end
         
           when Line::Bot::Event::MessageType::Location
             message = {
               type: "location",
               title: "あなたはここにいますか？",
               address: event.message["address"],
               latitude: event.message["latitude"],
               longitude: event.message["longitude"]
             }
             client.reply_message(event["replyToken"], message)
           end
          
            
         end
       }
   
       head :ok
     end
 end
