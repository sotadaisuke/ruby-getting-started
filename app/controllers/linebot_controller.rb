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
             
             
             if event.message['text'] =~ /上半身/
             message = [
               {
                 type: "text",
                 text: ["上腕二頭筋",
                 "上腕三頭筋",
                 "大胸筋",
                 "三角筋",
                 "腹直筋"].shuffle.first 
               },
               {
                   type: "image"
                   originalContentUrl:https://www.google.com/search?q=%E4%B8%8A%E8%85%95%E4%BA%8C%E9%A0%AD%E7%AD%8B%E3%80%80jpeg&rlz=1C1PDZP_jaJP864&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj6nKqv66nkAhXhLqYKHaVoBeAQ_AUIESgB&biw=1368&bih=753#imgrc=JWe0GekJzT20SM:
                   previewImageUrl:https://i1.wp.com/dbfactory.org/g-san/wp-content/uploads/middle_46ca9473-f2e0-46fe-aed8-0a8a12746d09.jpeg?w=486&ssl=1
               }
             ]
            
             client.reply_message(event["replyToken"], message)
               
            elsif event.message['text'] =~ /下半身/
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
             
             elsif event.message["text"] =~ /プロテイン/
           message = [
             {
               type: "text",
               text:  "筋肉を大きくしたい人👉https://www.amazon.co.jp/%E6%98%8E%E6%B2%BB-%E3%82%B6%E3%83%90%E3%82%B9-%E3%83%9B%E3%82%A8%E3%82%A4%E3%83%97%E3%83%AD%E3%83%86%E3%82%A4%E3%83%B3100-%E3%82%B3%E3%82%B3%E3%82%A2%E5%91%B3%E3%80%9050%E9%A3%9F%E5%88%86%E3%80%91-050g/dp/B013OOYZ9A/ref=asc_df_B013OOYZ9A/?tag=jpgo-22&linkCode=df0&hvadid=218012095897&hvpos=1o4&hvnetw=g&hvrand=17488479983901425006&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=1009280&hvtargid=pla-353571922240&psc=1&th=1&psc=1"
             },
             {
               type: "text",
               text: "筋肉密度を高めたい人👉https://jp.iherb.com/pr/Optimum-Nutrition-Micronized-Creatine-Powder-Unflavored-1-32-lb-600-g/68616?gclid=Cj0KCQjw753rBRCVARIsANe3o46i6MAbDa7OZh5sWQkNF4SKXUfCe9zOFSqfejm0hHTyWzG4qrQyFtYaAl3vEALw_wcB&gclsrc=aw.ds"
              
             }
           ]
           client.reply_message(event["replyToken"], message)

             else message = [
               {
                 type: "text",
                 text: ["プロテイン足りてる？", 
                 "今日、ジム行く？",
                 "アーノルド・シュワルツェネッガー",
                 "ドウェイン・ジョンソン",
                 "乳酸たまってる？"].shuffle.first
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
