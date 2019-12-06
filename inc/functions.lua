--[[
#    ____    _     ____  _   _    _
#   | __ \  / \   / ___|| | | |  / \
#   |_ __/ / _ \  \___ \| |_| | / _ \
#   | __ \/ ___ \  ___) |  _  |/ ___ \
#   |____/_/   \_\|____/|_| |_/_/   \_\ DEV:@MOKHTAR77     
--]]

function dl_cb(a,d) end
 
function GetInputFile(file)
local file = file or "" 
if file:match('/') then
infile = {ID= "InputFileLocal", path_  = file}
elseif file:match('^%d+$') then
infile = {ID= "InputFileId", id_ = file}
else
infile = {ID= "InputFilePersistentId", persistent_id_ = file}
end
return infile
end

local clock = os.clock
function sleep(time)  
local untime = clock()
while clock() - untime <= time do end
end

function sendMsg(chat_id,reply_id,text,funcb,Arg)
tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,Arg or nil)
end

function sendPhoto(chat_id,reply_id,photo,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ''
}
},func or dl_cb,nil)
end
	
	 
function sendVoice(chat_id,reply_id,voice,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = '',
waveform_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAnimation(chat_id,reply_id,animation,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = '',
title_ = title or '',
performer_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendSticker(chat_id,reply_id,sticker,func)
tdcli_function({
ID='SendMessage',
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil)
end

function sendVideo(chat_id,reply_id,video,caption,func)
tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end


function sendDocument(chat_id,reply_id,document,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil)
end


function fwdMsg(chat_id,from_chat_id,msg_id,func)
tdcli_function({
ID="ForwardMessages",
chat_id_ = chat_id,
from_chat_id_ = from_chat_id,
message_ids_ = {[0] = msg_id},
disable_notification_ = 0,
from_background_ = 0
},func or dl_cb,nil)
end


function SendMention(chat_id,user_id,msg_id,Text,offset, length) 
tdcli_function ({ 
ID = "SendMessage", 
chat_id_ = chat_id, 
reply_to_message_id_ = msg_id, 
disable_notification_ = 0, 
from_background_ = 1, 
reply_markup_ = nil, 
input_message_content_ = { 
ID = "InputMessageText", 
text_ = Text, 
disable_web_page_preview_ = 1, 
clear_draft_ = 0, 
entities_ = {[0]={ 
ID="MessageEntityMentionName", 
offset_ = offset , 
length_ = length , 
user_id_ = user_id },},},
},dl_cb, nil)
end
   
function sendChatAction(chatid,action,func,Arg)
tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,Arg or nil)
end

--================================{{  GetChannelFull  }} ===================================
function download_file(Link,Bath)
local Get_Files, res = https.request(Link)
print(res)
if res == 200 then
print("DONLOADING_FROM_URL: "..Link)
local FileD = io.open(Bath,'w+')
FileD:write(Get_Files)
FileD:close()
end
end
--================================{{  GetChannelFull  }} ===================================

function GetFullChat(GroupID,func,Arg)
tdcli_function({ID="GetChannelFull",channel_id_ = tostring(GroupID):gsub("-100","")},func or dl_cb,Arg or nil)
end

--================================{{  KickUser  }} ===================================

function kick_user(user_id,chat_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusKicked"}},func or dl_cb,Arg or nil)
end

--================================{{  UnBlock  }} ===================================

function StatusLeft(chat_id,user_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusLeft"}},func or dl_cb,Arg or nil)
end
--================================{{  DeleteMsg  }} ===================================

function Del_msg(GroupID,msg_id,func,Arg)
tdcli_function({ID="DeleteMessages",chat_id_=GroupID,message_ids_={[0]=msg_id}},func or dl_cb,Arg or nil)
end


function GetPhotoUser(User,func,Arg)
tdcli_function({ID='GetUserProfilePhotos',user_id_=User,offset_=0,limit_=1},func,Arg or nil)
end
  
function GetMsgInfo(UID,Msg_id,Cb,Arg)
tdcli_function({ID="GetMessage",chat_id_ = UID,message_id_ = Msg_id},Cb,Arg or nil)
end

function GetUserName(User,Cb,Arg)
tdcli_function({ID="SearchPublicChat",username_ = User},Cb,Arg or nil)
end

function GetUserID(User,Cb,Arg)
tdcli_function({ID="GetUser",user_id_ = User},Cb,Arg or nil)
end

function GroupTitle(GroupID,func,Arg)
tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,Arg or nil)
end

function GetChannelAdministrators(GroupID,func,limit,Arg)
tdcli_function({ID="GetChannelMembers",channel_id_= tostring(GroupID):gsub('-100',''),filter_={ID = "ChannelMembersAdministrators"},offset_=0,limit_=limit or 25},func,Arg or nil)
end 

function GetChatMember(GroupID,UserID,func,Arg)
tdcli_function({ID='GetChatMember',chat_id_ = GroupID,user_id_ = UserID},func,Arg or nil)
end 

function GetHistory(GroupID,NumDel,func,Arg)
tdcli_function({ID="GetChatHistory",chat_id_ = GroupID,from_message_id_ = 0,offset_ = 0,limit_ = NumDel},func,Arg or nil)
end
-----------------------{ Start Api Token Bot}-----------------------------
function getr(br)
if br then
return "✓"
else
return "✖️"
end
end

function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end


--================================{{  ExportChatInviteLink  }} ===================================

function ExportLink(GroupID)
local GetLin,res = https.request(ApiToken..'/exportChatInviteLink?chat_id='..GroupID)
print(res)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, GetLin)
return (res or "")
end

function Restrict(chat_id,user_id,right)
if right >= 30 then
zx = ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false&until_date='..os.time()+until_date
elseif right == 1 then
zx = ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false'
elseif right == 2 then
zx = ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true'
elseif right == 3 then
zx = ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false'
end
ii = https.request(zx)
print(ii)
print(zx)
return ii
end


function send_msg(chat_id,text,msg_id)
local url = ApiToken..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end

function EditMsg(chat_id,message_id,text,funcb)
local url = ApiToken..'/editMessageText?chat_id='..chat_id ..'&message_id='..tonumber(message_id/2097152/0.5)..'&text='..URL.escape(text)..'&parse_mode=Markdown&disable_web_page_preview=true'
return GetApi(url)
end

function send_key(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 

function GetFilePath(FileID)
local UrlInfo = https.request(ApiToken..'/getfile?file_id='..FileID)
return ApiToken..'/'..JSON.decode(UrlInfo).result.file_path
end

----------------------{ End Api Token Bot }-----------------------------

----------------------{ Get Name Bot }-----------------------------
Bot_Name = redis:get(basha..":NameBot:")


function GetType(ChatID) 
if tostring(ChatID):match('^-100') then
return 'channel' 
elseif tostring(ChatID):match('-') then
return 'chat' 
else 
return 'pv'
end 
end

function All_File()
local Text = "🗂| قائمه الملفات : \nـ------------------------------------\n\n"
local Num = 0
local allfiles = io.popen('ls plugins'):lines()
for Files in allfiles do
if Files:match(".lua$") then
Num = Num +1
Text = Text..Num..'- * '..Files..' * \n' 
end
end 
if Num == 0 then
Text = Text.."📛| Not files ~⪼ لا يوجد ملفات !"
end 
return Text.."\n\n🗃| لتحميل المزيد من الملفات ادخلل لمتجر الملفات بالامر الاتي {` متجر الملفات `}"
end


function ResolveUserName(data)
if data.username_ then 
USERNAME = '@'..Flter_Markdown(data.username_)
else 
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
USERNAME = FlterName(Name,20) 
end
return USERNAME
end


function FlterName(Name,Num)
if Name.last_name_ then
Name = Name.first_name_ .." "..Name.last_name_ 
elseif Name.first_name_ then
Name = Name.first_name_ 
end
local CharNumber = tonumber(Num or 25)
local Name = tostring(Name):lower()
Name = Name:gsub("https://[%a%d_]+",'') 
Name = Name:gsub("http://[%a%d_]+",'') 
Name = Name:gsub("telegram.dog/[%a%d_]+",'') 
Name = Name:gsub("telegram.me/[%a%d_]+",'') 
Name = Name:gsub("t.me/[%a%d_]+",'') 
Name = Name:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Name = Name:gsub("@[%a%d_]+",'')
Name = Name:gsub("#[%a%d_]+",'')

Name = FlterEmoje(Name)
Name = Flterzhrfa(Name)
Name = utf8.gsub(Name,"✸","")
Name = utf8.gsub(Name,"ﮧ","")
Name = utf8.gsub(Name,"┊","")
Name = utf8.gsub(Name,"ٜ","")
Name = utf8.gsub(Name,"༒","")
Name = utf8.gsub(Name,"ᬼ","")
Name = utf8.gsub(Name,"̅","")
Name = utf8.gsub(Name,"❦","")
Name = utf8.gsub(Name,"ᝢ","")
Name = utf8.gsub(Name,"༼","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"༽","")
Name = utf8.gsub(Name,"⎨","")
Name = utf8.gsub(Name,"ௌ","")
Name = utf8.gsub(Name,"⎬","")
Name = utf8.gsub(Name,"ۤ","")
Name = utf8.gsub(Name,"꧄","")
Name = utf8.gsub(Name,"░","")
Name = utf8.gsub(Name,"͝","")
Name = utf8.gsub(Name,"¥","")
Name = utf8.gsub(Name,"َ","")
Name = utf8.gsub(Name,"✧","")
Name = utf8.gsub(Name,"ֆ","")
Name = utf8.gsub(Name,"ۖ","")
Name = utf8.gsub(Name,"(])","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"֧","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"﴿","")
Name = utf8.gsub(Name,"₪","")
Name = utf8.gsub(Name,"ૣ","")
Name = utf8.gsub(Name,"☆","")
Name = utf8.gsub(Name,"͞","")
Name = utf8.gsub(Name,"ٖ","")
Name = utf8.gsub(Name,"֯","")
Name = utf8.gsub(Name,"‘","")
Name = utf8.gsub(Name,"ُ","")
Name = utf8.gsub(Name,"ꪆ","")
Name = utf8.gsub(Name,"↡","")
Name = utf8.gsub(Name,"᭄","")
Name = utf8.gsub(Name,"௵","")
Name = utf8.gsub(Name,"♚","")
Name = utf8.gsub(Name,"ﹻ","")
Name = utf8.gsub(Name,"ۦ","")
Name = utf8.gsub(Name,"͟","")
Name = utf8.gsub(Name,"̶","")
Name = utf8.gsub(Name,"_","")
Name = utf8.gsub(Name,"`","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"͡","")
Name = utf8.gsub(Name,"⸨","")
Name = utf8.gsub(Name,"▓","")
Name = utf8.gsub(Name,"ـ","")
Name = utf8.gsub(Name,"ஞ","")
Name = utf8.gsub(Name,"❥","")
Name = utf8.gsub(Name,"ꨩ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"ೈ","")
Name = utf8.gsub(Name,"٘","")
Name = utf8.gsub(Name,"ࣧ","")
Name = utf8.gsub(Name,"“","")
Name = utf8.gsub(Name,"•","")
Name = utf8.gsub(Name,']',"")
Name = utf8.gsub(Name,'[[]',"")
Name = utf8.gsub(Name,"}","")
Name = utf8.gsub(Name,"ཻ","")
Name = utf8.gsub(Name,"⸩","")
Name = utf8.gsub(Name,"ِ","")
Name = utf8.gsub(Name,"ࣩ","")
Name = utf8.gsub(Name,"ٰ","")
Name = utf8.gsub(Name,"ہ","")
Name = utf8.gsub(Name,"ۙ","")
Name = utf8.gsub(Name,"ৡ","")
Name = utf8.gsub(Name,"҉","")
Name = utf8.gsub(Name,"ٙ","")
Name = utf8.gsub(Name,"ّ","")
Name = utf8.gsub(Name,"ۨ","")
Name = utf8.gsub(Name,"ै","")
Name = utf8.gsub(Name,"ೋ","")
Name = utf8.gsub(Name,"๋","")
Name = utf8.gsub(Name,"͢","")
Name = utf8.gsub(Name,"ﮩ","")
Name = utf8.gsub(Name,"❁","")
Name = utf8.gsub(Name,"⃤","")
Name = utf8.gsub(Name,"ﮮ","")
Name = utf8.gsub(Name,"⸽","")
Name = utf8.gsub(Name,"̝","")
Name = utf8.gsub(Name,"{","")
Name = utf8.gsub(Name,"𖤍","")
Name = utf8.gsub(Name,"|","")
Name = utf8.gsub(Name,"ۧ","")
Name = utf8.gsub(Name,"ۗ","")
Name = utf8.gsub(Name,"ۣ","")
Name = utf8.gsub(Name,"ٍ","")
Name = utf8.gsub(Name,"ؔ","")
Name = utf8.gsub(Name,"ٌ","")
Name = utf8.gsub(Name,"͜","")
Name = utf8.gsub(Name,"ꪸ","")
Name = utf8.gsub(Name,"ۂ","")
Name = utf8.gsub(Name,"»","")
Name = utf8.gsub(Name,"̚","")
Name = utf8.gsub(Name,"𖣁","")
Name = utf8.gsub(Name,"۫","")
Name = utf8.gsub(Name,"ْ","")
Name = utf8.gsub(Name,"ৣ","")
Name = utf8.gsub(Name,"ے","")
Name = utf8.gsub(Name,"♱","")
Name = utf8.gsub(Name,"℘","")
Name = utf8.gsub(Name,"ً","")
Name = utf8.gsub(Name,"۪","")
Name = utf8.gsub(Name,"❰","")
Name = utf8.gsub(Name,"꯭","")
Name = utf8.gsub(Name,"ٚ","")
Name = utf8.gsub(Name,"﷽","")
Name = utf8.gsub(Name,"ۛ","")
Name = utf8.gsub(Name,"〞","")
Name = utf8.gsub(Name,"█","")
Name = utf8.gsub(Name,"✮","")
Name = utf8.gsub(Name,"✿","")
Name = utf8.gsub(Name,"✺","")
Name = utf8.gsub(Name,"̐","")
Name = utf8.gsub(Name,"ྀ","")
Name = utf8.gsub(Name,"←","")
Name = utf8.gsub(Name,"↝","")
Name = utf8.gsub(Name,"ؒ","")
Name = utf8.gsub(Name,"̷","")
Name = utf8.gsub(Name,"⇣","")
Name = utf8.gsub(Name,"«","")
Name = utf8.gsub(Name,"ٛ","")
Name = utf8.gsub(Name,"ॠ","")
Name = utf8.gsub(Name,"̲","")
Name = utf8.gsub(Name,"-","")
Name = utf8.gsub(Name,"͛","")
Name = utf8.gsub(Name,"☬","")
Name = utf8.gsub(Name,"ٓ","")
Name = utf8.gsub(Name,"❱","")
Name = utf8.gsub(Name,"ۓ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"௸","")
Name = utf8.gsub(Name,"°","")
Name = utf8.gsub(Name,"ᔕ","")
Name = utf8.gsub(Name,"[⁽₎]","")
Name = utf8.gsub(Name,"͒","")
Name = utf8.gsub(Name,"❀","")
Name = utf8.gsub(Name,"◎","")
Name = utf8.gsub(Name,"ᴗ̈","")
Name = utf8.gsub(Name,"►","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"⋮","")
Name = utf8.gsub(Name,"┋","")
Name = utf8.gsub(Name,"♛","")
Name = utf8.gsub(Name,"✫","")
Name = utf8.gsub(Name,"՞","")
Name = utf8.gsub(Name,"﴾","")
Name = utf8.gsub(Name,"♡","")
Name = utf8.gsub(Name,"彡","")
Name = utf8.gsub(Name,"卍","")
Name = utf8.gsub(Name,"』","")
Name = utf8.gsub(Name,"『","")
Name = utf8.gsub(Name,"∫","")
Name = utf8.gsub(Name,"Ξ","")
Name = utf8.gsub(Name,"۩","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"ᵎ","")
Name = utf8.gsub(Name,"║","")
Name = utf8.gsub(Name,"ꪾ","")
Name = utf8.gsub(Name,"ꪳ","")

if utf8.len(Name) > CharNumber then
Name = utf8.sub(Name,0,CharNumber)..'...' 
end
local CheckName = Name:gsub(' ','')
if not CheckName then 
Name = 'الاسم سبام 📛'
end
return utf8.escape(Name)
end

function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub('*','\\*')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](.*)[)]')
local Hyperlink1 = Text:match('[[](.*)[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](.*)[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](.*)[]]',Hyperlink1 ) 
end
return Text 
end



function Get_Ttl(msgs)
local MsgShow = '' 
local NumMsg = tonumber(msgs)
if NumMsg < 10 then 
MsgShow = 'غير متفاعل ✘' 
elseif NumMsg < 50 then
MsgShow = 'ضعيف 🥀' 
elseif NumMsg < 100 then 
MsgShow = 'متوسط 🎋' 
elseif NumMsg < 500 then 
MsgShow = 'متفاعل 💐' 
elseif NumMsg < 1000 then 
MsgShow = 'قوي جدا ⚡️' 
elseif NumMsg < 1500 then 
MsgShow = 'قمه التفاعل ✨' 
elseif NumMsg < 2000 then 
MsgShow = 'اقوى تفاعل 🔥' 
elseif NumMsg > 5000 then 
MsgShow = ' ملك امبراطورية التفاعل 🔥' 
end
return MsgShow 
end

function Getrtba(UserID,ChatID)
if UserID == our_id then 
var = 'هذا البوت 🙄☝🏿' 
elseif  UserID == SUDO_ID then
var = 'مطور اساسي 👨🏻‍✈️' 
elseif redis:sismember(basha..':SUDO_BOT:',UserID) then
var = 'مطور ثانوي 👨🏽‍💻' 
elseif redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then
var = ' المنشىء 👷🏽' 
elseif redis:sismember(basha..'owners:'..ChatID,UserID) then
var = 'مدير البوت 👨🏼‍⚕️' 
elseif redis:sismember(basha..'admins:'..ChatID,UserID) then
var = 'ادمن في البوت 👨🏼‍🎓' 
elseif redis:sismember(basha..'whitelist:'..ChatID,UserID) then
var = 'عضو مميز ⭐️' 
else
var = 'فقط عضو 🙍🏼‍♂️' 
end
return var
end


function SaveNumMsg(msg)
if msg.edited then
redis:incr(basha..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.text and not msg.forward_info_ then
redis:incr(basha..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
elseif msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(basha..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessagePhoto" then
redis:incr(basha..':photo:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageSticker" then
redis:incr(basha..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVoice" then
redis:incr(basha..':voice:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAudio" then
redis:incr(basha..':audio:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVideo" then
redis:incr(basha..':video:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAnimation" then
redis:incr(basha..':animation:'..msg.chat_id_..':'..msg.sender_user_id_)
end
end


--================================{{  We Sudoer  }} ===================================

function we_sudo(msg)
if msg.sender_user_id_ == SUDO_ID then
return true 
else
return false
end 
end


--================================{{  List Sudoer  }} ===================================


function sudolist(msg)
local list = redis:smembers(basha..':SUDO_BOT:')
message = '👨🏽‍💻*¦* قائمه الـمـطـوريـن : \n\n`★`*_* '..SUDO_USER..' ➣ (' ..SUDO_ID.. '){'..redis:scard(basha..'mtwr_count'..SUDO_ID)..'}\n*----------------------------------*\n'
if #list==0 then  message = message.."* لا يوجد مطورين حاليا \n📛 *"
else
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
local count = redis:scard(basha..'mtwr_count'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l '..(info.username or '')..' » (`' ..v.. '`){'..count..'} \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`){'..count..'} \n'
end
end 
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض الردود بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  List owner  }} ===================================

function ownerlist(msg)
local message = '*⭐️¦ المنشئيين :*\n\n'
local monsha = redis:smembers(basha..':MONSHA_BOT:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."📛| Not Creator ~⪼ لا يوجد منشئيين !\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message .."`★_l` ["..info.username..'] » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message .."`★_l` "..(username or '')..' l » (`' ..v.. '`) \n'
end
end
end
message = message..'*----------------------------------\n\n📋¦ قائمه المدراء :*\n\n'
local list = redis:smembers(basha..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."📛| Not Director ~⪼ لا يوجد مدراء !\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l '..(info.username or '')..' » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`) \n'
end
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المدراء بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{ List Admins  }} ===================================

function GetListAdmin(msg)
local list = redis:smembers(basha..'admins:'..msg.chat_id_)
if #list==0 then  return  "📛*¦* لا يوجد ادمن في هذه المجموعه \n❕" end
message = '📋*¦ قائمه الادمنيه :*\n\n'
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l '..info.username..' » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض الادمنيه بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  List WhiteList  }} ===================================

function whitelist(msg)
local list = redis:smembers(basha..'whitelist:'..msg.chat_id_)
if #list == 0 then return "*📛¦ لا يوجد مميزين في القائمه *" end
message = '📋*¦* قائمه الاعضاء المميزين :\n'   
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المميزين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  Mute User And List Mute User   }} ===================================

function MuteUser(Group, User)
if redis:sismember(basha..'is_silent_users:'..Group,User) then 
return true 
else
return false
end 
end


function MuteUser_list(msg)
local list = redis:smembers(basha..'is_silent_users:'..msg.chat_id_)
if #list==0 then return "📋*¦*  لايوجد اعضاء مكتومين " end
message = '📋*¦*  قائمه الاعضاء المكتومين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المكتومين بسبب القائمه كبيره جدا ."
else
return message
end
end


--================================{{  Check Banned And List Banned  }} ===================================


function Check_Banned(Group,User)
if redis:sismember(basha..'banned:'..Group,User) then 
return true 
else
return false
end 
end

function GetListBanned(msg)
local list = redis:smembers(basha..'banned:'..msg.chat_id_)
if #list==0 then return "📋*¦* لايوجد أعضاء محظورين " end
message = '📋*¦* قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`) \n'
end 
end 
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end



--================================{{  Sudoer  }} ===================================
function GeneralBanned(User)
if redis:sismember(basha..'gban_users',User) then 
return true 
else
return false
end 
end

function GetListGeneralBanned(msg)
local list = redis:smembers(basha..'gban_users')
if #list==0 then return  "*📛¦ لايوجد اعضاء محظورين عام*" end
message = '🛠*¦* قائمه المحظورين عام :\n'
for k,v in pairs(list) do
local info = redis:hgetall(basha..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
if info.username:match("^(%d+)") then
username = info.username
else
username = info.username:match("[(]tg://user[?]id=(%d+)[)]")
end
message = message ..k.. '-l '..(username or '')..' l » (`' ..v.. '`) \n'
end
end 
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  Filter Words  }} ===================================

function FilterX(msg)
local var = false
local Text = (msg.text or msg.content_.caption_)
local list = redis:smembers(basha..':Filter_Word:'..msg.chat_id_)
if #list ~=0 then
for k,word in pairs(list) do
if Text:match('^('..word..')$') or Text:match(word..' .*') or Text:match('.* '..word) then
Del_msg(msg.chat_id_,msg.id_)
print("Word is Del")
var = true
else
var = false
end
end
else
var = false
end 
return var
end


function FilterXList(msg)
local list = redis:smembers(basha..':Filter_Word:'..msg.chat_id_)
if #list == 0 then return "🛠*¦* قائمه الكلمات الممنوعه فارغه" end
filterlist = '🛠*¦* قائمه الكلمات الممنوعه :\n'    
for k,v in pairs(list) do
filterlist = filterlist..'*'..k..'* -  '..Flter_Markdown(v)..'\n'
end
if utf8.len(filterlist) > 4096 then
return "📛| لا يمكن عرض الممنوعين بسبب القائمه كبيره جدا ."
else
return filterlist
end
end

function AddFilter(msg, word)
if redis:sismember(basha..':Filter_Word:'..msg.chat_id_,word) then 
return  "📝*¦* الكلمه *{"..word.."}* هي بالتأكيد من قائمه المنع✓️" 
else
redis:sadd(basha..':Filter_Word:'..msg.chat_id_,word) 
return  "📝*¦* الكلمه *{"..word.."}* تمت اضافتها الى قائمه المنع ✓️"
end
end

function RemFilter(msg, word)
if redis:sismember(basha..':Filter_Word:'..msg.chat_id_,word) then 
redis:srem(basha..':Filter_Word:'..msg.chat_id_,word) 
return  "📝*¦* الكلمه *{"..word.."}* تم السماح بها ✓️" 
else
return  "📝*¦* الكلمه *{"..word.."}* هي بالتأكيد مسموح بها✓️" 
end
end

------------------------------------------

function CheckFlood(User,ChatID,Flood)
local NumberFlood = tonumber(redis:get(basha..':Flood_Spam:'..User..':'..ChatID..':msgs') or 0)
if NumberFlood >= Flood then 
result = false
else
redis:setex(basha..':Flood_Spam:'..User..':'..ChatID..':msgs',2,NumberFlood+1)
result = true
end
return result
end


function buck_up_groups(msg)

json_data = '{"BotID": '..basha..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(basha..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(basha..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end

local admins = redis:smembers(basha..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(basha..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creator = redis:smembers(basha..':MONSHA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(basha..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(basha..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(basha..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

json_data =  json_data.."}"
end

local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(msg.chat_id_,msg.id_,"./inc/"..Bot_User..".json","🚸| ملف النسخه الاحتياطيه ...\n🔖| المجموعات » { "..#All_Groups_ID.." }\n📋| للبوت » "..Bot_User.."\n📆| التاريخ » "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end

function chat_list(msg)
local list = redis:smembers(basha..'group:ids')
message = '📋*¦* قائمه المجموعات :\n\n'
for k,v in pairs(list) do 
local info = redis:get(basha..'group:name'..v)
if info then 
if utf8.len(info) > 25 then
info = utf8.escape(utf8.gsub(info,0,25))..'...'
end
message = message..k..'ـ '..Flter_Markdown(info).. ' \nــ •⊱ { `' ..v.. '` } ⊰•\n\n'
else 
message = message..k.. 'ـ '..' ☜ •⊱ { `' ..v.. '` } ⊰• \n'
end 
end
all_groups = '📋¦ قائمه المجموعات :<br><br>'
for k,v in pairs(list) do 
local info = redis:get(basha..'group:name'..v)
if info then
all_groups = all_groups..' '..k..'- <span style="color: #bd2a2a;">'..info.. '</span> <br> ايدي ☜ (<span style="color:#078883;">' ..v.. '</span>)<br>'
else
all_groups = all_groups..' '..k.. '- '..' ☜ (<span style="color:#078883;">' ..v.. '</span>) <br>'
end 
end

if utf8.len(message) > 4096 then
sendMsg(msg.chat_id_,1,'🚸*¦* عذرا لديك الكثير من المجموعات\n👨🏽‍💻*¦* سوف ارسل لك ملف فيها قائمه مجموعات المفعله انتظر لحظه ...')
file = io.open("./inc/All_Groups.html", "w")
file:write([[
<html dir="rtl">
<head>
<title>قائمه المجموعات 🗣</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Harmattan" rel="stylesheet">

</head>
<style>*{font-family: 'Harmattan', sans-serif;font-weight: 600;text-shadow: 1px 1px 16px black;}</style>
<body>
<p style="color:#018bb6;font-size: 17px;font-weight: 600;" aligin="center">قائمه المجموعات 🗣</p>
<hr>
]]..all_groups..[[

</body>
</html>
]])
file:close()
return sendDocument(msg.chat_id_,msg.id_,'./inc/All_Groups.html','👨🏽‍✈️¦ قائمه المجموعات بالكامله ✓ \n🗃¦ يحتوي ('..#list..') مجموعه \n🖥¦افتح الملف في عارض HTML او بالمتصفح',dl_cb,nil)
else 
return sendMsg(msg.chat_id_,1,message) 
end 
end


function rem_data_group(id_group)
redis:del(
basha..'group:add'..id_group,
basha..'lock_link'..id_group, 
basha..'lock_id'..id_group,
basha..'lock_spam'..id_group, 
basha..'lock_webpage'..id_group,
basha..'lock_markdown'..id_group,
basha..'lock_flood'..id_group,
basha..'lock_bots'..id_group,
basha..'mute_forward'..id_group,
basha..'mute_contact'..id_group,
basha..'mute_location'..id_group,
basha..'mute_document'..id_group,
basha..'mute_keyboard'..id_group,
basha..'mute_game'..id_group,
basha..'mute_inline'..id_group,
basha..'lock_username'..id_group,
basha..'num_msg_max'..id_group,
basha..'mute_text'..id_group,
basha..'admins:'..id_group,
basha..':Filter_Word:'..id_group,
basha..'banned:'..id_group,
basha..'is_silent_users:'..id_group,
basha..'whitelist:'..id_group,
basha..':MONSHA_BOT:'..id_group,
basha..':lock_id_photo:'..id_group,
basha..'replay'..id_group
)
redis:srem(basha..'group:ids',id_group)
end



function set_admins(msg) 
GetChannelAdministrators(msg.chat_id_,function(arg,data)
local NumAdmin = 0
for k,v in pairs(data.members_) do
if not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
NumAdmin = NumAdmin + 1
if not redis:sismember(basha..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(basha..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(basha..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end
end
end
if NumAdmin == 0 then 
sendMsg(arg.chat_id_,arg.id_,"📮¦ لا يـوجـد أدمـنـيـه لكي يتـم رفعهم \n")
else
sendMsg(arg.chat_id_,arg.id_,"📮¦ تم رفع  { *"..NumAdmin.."* } مـن آلآدمـنيهہ‌‏ في آلبوت \n✓️")
end
end,30,{chat_id_=msg.chat_id_,id_=msg.id_})
end




function modadd(msg)

if redis:get(basha..'lock_service') then
lock_service = true
else
lock_service = false
end 

if not msg.SudoUser and not lock_service then return '🚸¦ أنـت لـسـت الـمـطـور ⚙️' end
if msg.is_post_ then return "🚸¦ عذرا هذا بوت حمايه للمجموعات وليس للقنوات  " end
if msg.type ~= "channel" then return '🚸¦ البوت يعمل فقط في المجموعات العامه لذا يجب ترقية المجموعه ووضع معرف للمجموعه لتصبح عامه ⚙️' end
if redis:get(basha..'group:add'..msg.chat_id_) then  return '🎗*¦* المجموعه بالتأكيد ✓️ تم تفعيلها' end

local UserChaneel = redis:get(basha..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
print(url) 
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return "🚸| آشـترگ بآلقنآ‌‏هہ آولآ ["..UserChaneel.."] \n🔛| ثم آرجع آرسـل تفعيل ."
end
else
return "🚸| آشـترگ بآلقنآ‌‏هہ آولآ ["..UserChaneel.."] \n🔛| ثم آرجع آرسـل تفعيل ."
end
end
 


GetFullChat(msg.chat_id_,function(arg,data) 
local GroupUsers = tonumber(redis:get(basha..':addnumberusers') or 0)
local Groupcount = tonumber(data.member_count_)
if GroupUsers  >= Groupcount and not arg.SudoBase then
return sendMsg(arg.chat_id_,arg.id_,'🚸*¦* لآ يمـگنني تفعيل آلبوت في آلمـجمـوعهہ‏ يجب آن يگون آگثر مـن *【'..GroupUsers..'】* عضـو 👤')
end
if data.channel_ and data.channel_.status_.ID  == "ChatMemberStatusMember" then
return sendMsg(arg.chat_id_,arg.id_,'📛*¦* عذرا البوت ليس ادمن  في المجموعه ♨️\n🔙*¦* يرجى ترقيته ادمن لتتمكن من تفعيل البوت ✓️')
end

if arg.lock_service then 
sendMsg(arg.chat_id_,arg.id_,'📮*¦ تـم تـفـعـيـل الـمـجـمـوعـه ✓️ \n👨🏽‍🔧¦¦* وتم رفع جمـيع آلآدمـنيهہ‏‏‏ آلگروب بآلبوت \n✓')
else
sendMsg(arg.chat_id_,arg.id_,'📮¦ تـم تـفـعـيـل آلمـجمـوعهہ‏‏ \n✓️')
end


GetChannelAdministrators(arg.chat_id_,function(arg,data)
for k,v in pairs(data.members_) do
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(basha..'username:'..data.id_,'username', ResolveUserName(data))
redis:sadd(basha..':MONSHA_BOT:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
elseif arg.lock_service and not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
if not redis:sismember(basha..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(basha..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(basha..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
end
end
end
end,25,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,lock_service=arg.lock_service})



GroupTitle(arg.chat_id_,function(arg,data)

redis:mset(
basha..'group:add'..arg.chat_id_,true,
basha..'lock_id'..arg.chat_id_,true, 
basha..'lock_link'..arg.chat_id_,true, 
basha..'lock_spam'..arg.chat_id_,true,
basha..'lock_webpage'..arg.chat_id_,true,
basha..'lock_markdown'..arg.chat_id_,true,
basha..'lock_flood'..arg.chat_id_,true,
basha..'lock_bots'..arg.chat_id_,true,
basha..'mute_forward'..arg.chat_id_,true,
basha..'mute_contact'..arg.chat_id_,true,
basha..'mute_location'..arg.chat_id_,true,
basha..'mute_document'..arg.chat_id_,true,
basha..'mute_keyboard'..arg.chat_id_,true,
basha..'mute_game'..arg.chat_id_,true,
basha..'mute_inline'..arg.chat_id_,true,
basha..'lock_username'..arg.chat_id_,true,
basha..'num_msg_max'..arg.chat_id_,5, 
basha..'lock_edit'..arg.chat_id_,true,
basha..'replay'..arg.chat_id_,true,
basha..':lock_id_photo:'..arg.chat_id_,true
)
redis:sadd(basha..'group:ids',arg.chat_id_) 
redis:sadd(basha..'mtwr_count'..arg.sender_user_id_,arg.chat_id_)

local NameGroup = data.title_
redis:set(basha..'group:name'..arg.chat_id_,NameGroup)
if not arg.invite_link_ then
Gp_Link = ExportLink(arg.chat_id_)
if Gp_Link and Gp_Link.result then
Gp_Link = Gp_Link.result
else
Gp_Link = ""
end
else
Gp_Link = arg.invite_link_
end
redis:set(basha..'linkGroup'..arg.chat_id_,Gp_Link)
if arg.sender_user_id_ == SUDO_ID then return false end
GetUserID(arg.sender_user_id_,function(arg,datai)
if datai.username_ then 
USERNAME_T = '🎟*¦* الـمعرف  •⊱ @['..datai.username_..'] ⊰•\n'
else 
USERNAME_T = ''
end
send_msg(SUDO_ID,'👮🏽*¦* قام شخص بتفعيل البوت ...\n\nــــــــــــــــــــــــــــــــــــــــــ\n📑¦ معلومات المجموعه\n'
..'🗯¦ الاسم •⊱ ['..arg.NameGroup..']('..arg.Gp_Link..') ⊰• \n'
..'📛¦ الايدي •⊱`'..arg.chat_id_..'`⊰•\n'
..'🙋🏻‍♂¦ ألاعـضـاء •⊱{ *'..arg.Groupcount..'* }⊰• \nــــــــــــــــــــــــــــــــــــــــــ\n⚖️¦ معلومات الشخص \n'
..'👨🏽‍💻*¦* الاسـم •⊱{ ['..FlterName(datai.first_name_..' '..(datai.last_name_ or ""),23)..'](tg://user?id='..arg.sender_user_id_..') }⊰•\n\n'
..USERNAME_T..'📆¦ التاريخ •⊱* '..os.date("%Y/%m/%d")
..' *⊰•\n⏱¦ الساعه •⊱* '..os.date("%I:%M%p")..' *⊰•')
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,NameGroup=NameGroup,Gp_Link=Gp_Link,Groupcount=arg.Groupcount})
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,Groupcount=Groupcount,invite_link_=data.invite_link_})


end,{chat_id_=msg.chat_id_,id_=msg.id_,sender_user_id_=msg.sender_user_id_,lock_service=lock_service})
return false
end

function action_by_reply(arg,data)  --===  معلومات الرد 
local MsgID = arg.msg.id_
local ChatID = arg.msg.chat_id_
if data.sender_user_id_ then
local cmd = arg.cmd
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)

local Resolv = ResolveUserName(data)

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)

-- Replay is all Done Function


-- End Cmd 
end,nil)
else
return sendMsg(ChatID,MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕")
end 
end

function action_by_username(arg,data)
local cmd = arg.cmd 

local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if data.id_ then
local UserID = data.id_
local UserName = '@'..arg.msg.text:match('@[%a%d_]+'):gsub('@',''):gsub('_',[[\_]])
print(UserName)

else
return sendMsg(ChatID,MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕")
end 

end

function action_by_id(arg, data)
local cmd = arg.cmd
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if not data.id_ then 
sendMsg(ChatID,MsgID,"📛*¦* العضو لا يوجد\n❕") 
return false
end
local UserID = data.id_
local Resolv = ResolveUserName(data)

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)


if cmd == "tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك تقييد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(basha..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور الثانوي\n🛠") 
elseif redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(basha..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(basha..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد الادمن\n🛠") 
end
Restrict(ChatID,UserID,1)
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..':tqeed:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم تقييد آلعضـو بنجآح \n✓️',12,USERCAR) 
end 
if cmd =="fktqeed" then
Restrict(ChatID,UserID,2)
redis:srem(basha..':tqeed:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم فگ تقييد آلعضـو بنجآح \n✓️',12,USERCAR) 
end
if cmd == "setwhitelist" then
if redis:sismember(basha..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد من عضو مميز \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تمت ترقيته ليصبح ضمن عضو مميز \n✓️',12,USERCAR) 
end
if cmd == "setmnsha" then
if redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد منشىء  \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تمت ترقيته ليصبح منشىء في البوت \n✓️',12,USERCAR) 
end
if cmd == "remmnsha" then
if not redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد ليس منشىء \n✓️',12,USERCAR) 
end
redis:srem(basha..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم تنزيله من المنشىء \n✓️',12,USERCAR) 
end
if cmd == "remwhitelist" then
if not redis:sismember(basha..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد ليس من عضو مميز \n✓️',12,USERCAR) 
end
redis:srem(basha..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تمت تنزيله من عضو مميز \n✓️',12,USERCAR) 
end
if cmd == "setowner" then
if redis:sismember(basha..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد مدير \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تمت ترقيته ليصبح مدير \n✓️',12,USERCAR) 
end
if cmd == "promote" then
if redis:sismember(basha..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد ادمن \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'admins:'..ChatID,UserID) 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تمت ترقيته ليصبح ادمن \n✓️',12,USERCAR) 
end
if cmd == "remowner" then
if not redis:sismember(basha..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد ليس مدير \n✓️',12,USERCAR) 
end
redis:srem(basha..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم تنزيله من الاداره \n✓️',12,USERCAR) 
end
if cmd == "demote" then
if not redis:sismember(basha..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد ليس ادمن \n✓️',12,USERCAR) 
end
redis:srem(basha..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم تنزيله من الادمنيه \n✓️',12,USERCAR) 
end
if cmd == "whois" then
GetChatMember(ChatID,UserID,function(arg,data1)
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " لا يوجد " end
return SendMention(ChatID,UserID,MsgID,'🤵🏼¦ الاسم » '..namei..'\n'
..'🎫¦ الايدي » {'..UserID..'} \n'
..'🎟¦ المعرف » '..useri..'\n'
..'📮¦ الرتبه » '..Getrtba(UserID,ChatID)..'\n'
..'🕵🏻️‍♀️¦ نوع الكشف » بالايدي\n➖',13,utf8.len(namei))
end)
end

if cmd == "up_sudo" then
if redis:sismember(basha..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ انه بالتأكيد مطور \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم ترقيته ليصبح مطور \n✓️',12,USERCAR) 
end

if cmd == "dn_sudo" then
if not redis:sismember(basha..':SUDO_BOT:',UserID) then return sendMsg(ChatID,MsgID,'👤*¦* العضو » '..USERNAME..' \n🎫*¦* الايدي » (`'..UserID..'`)\n🛠*¦* انه بالتأكيد ليس مطور \n✓') end
redis:srem(basha..':SUDO_BOT:',UserID) 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم تنزيله من المطورين \n✓️',12,USERCAR) 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠") 
elseif redis:sismember(basha..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور الثانوي\n🛠") 
elseif redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المنشئ\n🛠") 
elseif redis:sismember(basha..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المدير\n🛠") 
elseif redis:sismember(basha..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر الادمن\n🛠") 
end
if Check_Banned(ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم بالتأكيد حظره \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'banned:'..ChatID,UserID)
kick_user(UserID, ChatID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم حظره  \n✓️',12,USERCAR) 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(basha..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور الثانوي\n🛠") 
elseif redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(basha..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(basha..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد الادمن\n🛠") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'📛*¦* لا يمكنني طرد العضو .\n🎟*¦* لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'📛*¦* لا يمكنني طرد العضو .\n🎟*¦* ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم طرد العضو \n✓️',12,USERCAR) 
end)
end

if cmd == "uban" then
if not Check_Banned(ChatID,UserID) then 
 SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم بالتأكيد الغاء حظره \n✓️',12,USERCAR) 
else
 SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم الغاء حظره \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:srem(basha..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return false
end

if cmd == "ktm" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المطور الاساسي\n🛠") 
elseif redis:sismember(basha..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المطور الثانوي\n🛠") 
elseif redis:sismember(basha..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المنشئ\n🛠") 
elseif redis:sismember(basha..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المدير\n🛠") 
elseif redis:sismember(basha..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم الادمن\n🛠") 
end
if redis:sismember(basha..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المدراء او الادمنيه\n🛠") 
end
if MuteUser(ChatID, UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم بالتأكيد كتمه \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم كتمه  \n✓️',12,USERCAR) 
end

if cmd == "unktm" then
if not MuteUser(ChatID, UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم بالتأكيد الغاء كتمه \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:srem(basha..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم الغاء كتمه \n✓️',12,USERCAR) 
end

if cmd == "bandall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠")
elseif redis:sismember(basha..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور الثانوي\n🛠") 
end
if GeneralBanned(UserID) then 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم بالتأكيد حظره عام \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:sadd(basha..'gban_users',UserID)
kick_user(UserID,ChatID) 
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم حظره عام \n✓️',12,USERCAR) 
end

if cmd == "unbandall" then
if not GeneralBanned(UserID) then
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم بالتأكيد الغاء حظره العام \n✓️',12,USERCAR) 
end
redis:hset(basha..'username:'..UserID, 'username', Resolv)
redis:srem(basha..'gban_users',UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'👤¦ العضو » '..USERNAME..' \n🎫¦ الايدي » {'..UserID..'}\n🛠¦ تم الغاء حظره العام \n✓️',12,USERCAR) 
end

end

function settingsall(msg)
if redis:get(basha..'welcome:get'..msg.chat_id_) then welcomex = "{ مفعل }" else welcomex = "{ معطل }" end
if redis:get(basha..'lock_id'..msg.chat_id_) then lock_idx = "{ مفعل }" else lock_idx = "{ معطل }" end
if redis:get(basha..'replay'..msg.chat_id_)  then replayx  = "{ مفعل }" else replayx  = "{ معطل }" end
if redis:get(basha..'lock_woring'..msg.chat_id_) then lock_woringx = "{ مفعل }" else lock_woringx  = "{ معطل }" end
list_settings = "*👮🏾¦*` اعدادات المجموعه :` \n"
.."\n📝¦ التعديل » "..(redis:get(basha..'lock_edit'..msg.chat_id_) or 'false')
.."\n🔗¦ الروابط » "..(redis:get(basha..'lock_link'..msg.chat_id_) or 'false')
.."\n#️⃣¦ التاك » "..(redis:get(basha..'lock_tag'..msg.chat_id_) or 'false')
.."\n©¦ المعرفات » "..(redis:get(basha..'lock_username'..msg.chat_id_) or 'false')
.."\n\n💱¦ التكرار » "..(redis:get(basha..'lock_flood'..msg.chat_id_) or 'false')
.."\n📑¦ الكلايش » "..(redis:get(basha..'lock_spam'..msg.chat_id_) or 'false')
.."\n🌐¦ الويب » "..(redis:get(basha..'lock_webpage'..msg.chat_id_) or 'false')
.."\n⚜️¦ الماركدوان » "..(redis:get(basha..'lock_markdown'..msg.chat_id_) or 'false')
.."\n🏌🏻¦ البوتات بالطرد » "..(redis:get(basha..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n🤖¦ البوتات » "..(redis:get(basha..'lock_bots'..msg.chat_id_) or 'false')
.."\n➕¦ عدد التكرار » "..(redis:get(basha..'num_msg_max'..msg.chat_id_) or 'false')
.."\n\n🎬¦` اعدادات الوسائط :`\n"
.."\n*¦* المتحركه » "..(redis:get(basha..'mute_gif'..msg.chat_id_) or 'false')
.."\n💭¦ الدردشه » "..(redis:get(basha..'mute_text'..msg.chat_id_) or 'false')
.."\n◽️¦ الانلاين » "..(redis:get(basha..'mute_inline'..msg.chat_id_) or 'false')
.."\n🎮¦ الالعاب » "..(redis:get(basha..'mute_game'..msg.chat_id_) or 'false')
.."\n🏞¦ الصور » "..(redis:get(basha..'mute_photo'..msg.chat_id_) or 'false')
.."\n🎥¦ الفيديو » "..(redis:get(basha..'mute_video'..msg.chat_id_) or 'false')
.."\n🎙¦ البصمات » "..(redis:get(basha..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n🔉¦ الصوت » "..(redis:get(basha..'mute_voice'..msg.chat_id_) or 'false')
.."\n🎎¦ الملصقات » "..(redis:get(basha..'mute_sticker'..msg.chat_id_) or 'false')
.."\n📞¦ الجهات » "..(redis:get(basha..'mute_contact'..msg.chat_id_) or 'false')
.."\n💱¦ التوجيه » "..(redis:get(basha..'mute_forward'..msg.chat_id_) or 'false')
.."\n🌐¦ الموقع » "..(redis:get(basha..'mute_location'..msg.chat_id_) or 'false')
.."\n🗂¦ الملفات » "..(redis:get(basha..'mute_document'..msg.chat_id_) or 'false')
.."\n🔅¦ الاشعارات » "..(redis:get(basha..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n🔒¦ الكيبورد » "..(redis:get(basha..'mute_keyboard'..msg.chat_id_) or 'false')
.."\n\n*⚒¦*` اعدادات اخرى : `"
.."\n*🙋🏼‍♂️¦* الترحيب » "..welcomex
.."\n*💬¦*  الردود » "..replayx
.."\n*🚸¦*  التحذير » "..lock_woringx
.."\n*🎫¦* الايدي » "..lock_idx
list_settings = list_settings:gsub('true', '{ مقفول }')
list_settings = list_settings:gsub('false', '{ مفتوح }')
return sendMsg(msg.chat_id_,1,'➖\n'..list_settings..'\n')
end

function settings(msg)
list_settings = "👮🏾¦` اعدادات المجموعه :` "
.."\n\n*#️⃣¦* التاك » "..(redis:get(basha..'lock_tag'..msg.chat_id_) or 'false')
.."\n*©¦* المعرفات » "..(redis:get(basha..'lock_username'..msg.chat_id_) or 'false')
.."\n*📝¦* التعديل » "..(redis:get(basha..'lock_edit'..msg.chat_id_) or 'false')
.."\n*🔗¦* الروابط » "..(redis:get(basha..'lock_link'..msg.chat_id_) or 'false')
.."\n\n*💱¦* التكرار » "..(redis:get(basha..'lock_flood'..msg.chat_id_) or 'false')
.."\n*📑¦* الكلايش » "..(redis:get(basha..'lock_spam'..msg.chat_id_) or 'false')
.."\n\n*🌐¦* الويب » "..(redis:get(basha..'lock_webpage'..msg.chat_id_) or 'false')
.."\n*⚜️¦* الماركدوان » "..(redis:get(basha..'lock_markdown'..msg.chat_id_) or 'false')
.."\n*🏌🏻¦* البوتات بالطرد » "..(redis:get(basha..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n*🤖¦* البوتات » "..(redis:get(basha..'lock_bots'..msg.chat_id_) or 'false')
.."\n*➕¦* عدد التكرار » "..(redis:get(basha..'num_msg_max'..msg.chat_id_) or 'false')
.."\n\n*💱¦*` اعدادات التقـييد :`\n"
.."\n*💢¦* التقييد بالتوجيه » "..(redis:get(basha..':tqeed_fwd:'..msg.chat_id_) or 'false')
.."\n*📸¦* التقييد بالصور » "..(redis:get(basha..':tqeed_photo:'..msg.chat_id_) or 'false')
.."\n*🔗¦* التقييد بالروابط » "..(redis:get(basha..':tqeed_link:'..msg.chat_id_) or 'false')
.."\n*🎉¦* التقييد بالمتحركه » "..(redis:get(basha..':tqeed_gif:'..msg.chat_id_) or 'false')
.."\n*🎥¦* التقييد الفيديو » "..(redis:get(basha..':tqeed_video:'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '{ مقفول }')
list_settings = list_settings:gsub('false', '{ مفتوح }')
return sendMsg(msg.chat_id_, msg.id_,'➖\n'..list_settings..'\n')
end

function media(msg)
list_settings = "*👮🏾¦*` اعدادات الوسائط:`\n"
.."\n*🎑¦* المتحركه » "..(redis:get(basha..'mute_gif'..msg.chat_id_) or 'false')
.."\n*💭¦* الدردشه » "..(redis:get(basha..'mute_text'..msg.chat_id_) or 'false')
.."\n*◽️¦* الانلاين » "..(redis:get(basha..'mute_inline'..msg.chat_id_) or 'false')
.."\n*🎮¦* الالعاب » "..(redis:get(basha..'mute_game'..msg.chat_id_) or 'false')
.."\n*🏞¦* الصور » "..(redis:get(basha..'mute_photo'..msg.chat_id_) or 'false')
.."\n*🎥¦* الفيديو » "..(redis:get(basha..'mute_video'..msg.chat_id_) or 'false')
.."\n*🎙¦* البصمات » "..(redis:get(basha..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n*🔉¦* الصوت » "..(redis:get(basha..'mute_voice'..msg.chat_id_) or 'false')
.."\n*🎎¦* الملصقات » "..(redis:get(basha..'mute_sticker'..msg.chat_id_) or 'false')
.."\n*📞¦* الجهات » "..(redis:get(basha..'mute_contact'..msg.chat_id_) or 'false')
.."\n*💱¦* التوجيه » "..(redis:get(basha..'mute_forward'..msg.chat_id_) or 'false')
.."\n*🌐¦* الموقع » "..(redis:get(basha..'mute_location'..msg.chat_id_) or 'false')
.."\n*🗂¦* الملفات » "..(redis:get(basha..'mute_document'..msg.chat_id_) or 'false')
.."\n*🔅¦* الاشعارات » "..(redis:get(basha..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n*🔒¦* الكيبورد » "..(redis:get(basha..'mute_keyboard'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '{ مقفول }')
list_settings = list_settings:gsub('false', '{ مفتوح }')
return sendMsg(msg.chat_id_,msg.id_,'➖\n'..list_settings..'\n')
end
