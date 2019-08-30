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
                 kinniku= ["上腕二頭筋",
                 "上腕三頭筋",
                 "大胸筋",
                 "三角筋",
                 "腹直筋"].shuffle.first
                 
                 
                 if kinniku =="上腕二頭筋"
                     image_url="https://i1.wp.com/dbfactory.org/g-san/wp-content/uploads/middle_46ca9473-f2e0-46fe-aed8-0a8a12746d09.jpeg?w=486&ssl=1"
                     
                elsif kinniku =="上腕三頭筋"
                image_url="https://d2l930y2yx77uc.cloudfront.net/production/uploads/images/12365082/rectangle_large_type_2_a6a9b47a860ddb851b9da2d2005b9317.jpeg"
                
                elsif kinniku =="大胸筋"
                image_url="https://d2l930y2yx77uc.cloudfront.net/production/uploads/images/10285687/rectangle_large_type_2_73067d6d02038111b6e08df10daab063.jpeg"
                
                elsif kinniku =="三角筋"
                image_url="https://kaitosawahara.com/wp-content/uploads/2018/12/kata-1.jpg"
                
                elsif kinniku =="腹直筋"
                image_url="https://ag-skin.com/daily/doc/20190327060918.jpeg"
                
                 end
             
             message = [
               {
                 type: "text",
                 text: kinniku
               },
               {
                   type: "image",
                   originalContentUrl: image_url,
                   previewImageUrl: image_url
               }
             ]
            
             client.reply_message(event["replyToken"], message)
               
            elsif event.message['text'] =~ /下半身/
             kinniku2 = ["大殿筋(お尻の筋肉)",
                 "大腿四頭筋(太ももの筋肉)",
                 "ヒラメ筋💓",
                 "ハムストリングス"].shuffle.first 
                 
                 
                 
                  if kinniku2 =="大殿筋(お尻の筋肉)"
                     image_url2="https://i1.wp.com/dbfactory.org/g-san/wp-content/uploads/middle_46ca9473-f2e0-46fe-aed8-0a8a12746d09.jpeg?w=486&ssl=1"
                     
                elsif kinniku2 =="大腿四頭筋"
                image_url2="https://danlead.jp/wp-content/uploads/2019/04/AdobeStock_87141450.jpeg"
                
                elsif kinniku2 =="ヒラメ筋"
                image_url2="https://d2l930y2yx77uc.cloudfront.net/production/uploads/images/7552515/rectangle_large_type_2_c06a6cab847dc10cb9502c14d7ea7156.jpg"
                
                elsif kinniku2 =="ハムストリングス"
                image_url2="https://bodymakingtips.com/wp-content/uploads/2014/07/Hamstrings-workout-neveux.jpg"
                
                
                 end
             
             message = [
               {
                 type: "text",
                 text: kinniku2
               },
               {
                   type: "image",
                   originalContentUrl: image_url2,
                   previewImageUrl: image_url2
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
           
           elsif event.message["text"] =~ /筋トレ/
           message = [
             {
               type: "text",
               text:"大胸筋を鍛えるのにおすすめな筋トレ方法はこれ！👉https://mens-modern.jp/400"
             },
             {
               type: "text",
               text: "腹筋を鍛えるのにおすすめな筋トレ方法はこれ！👉https://smartlog.jp/53054"
             },
               {
               type: "text",
               text:"背筋を鍛えるのにおすすめな筋トレ方法はこれ！👉https://smartlog.jp/71258"
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
