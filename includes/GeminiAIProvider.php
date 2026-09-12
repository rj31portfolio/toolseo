<?php
final class GeminiAIProvider implements AIProviderInterface {
 public function complete(array $messages): array {
  $model=(string)cfg('AI_MODEL');
  if(!preg_match('/^[a-zA-Z0-9._-]+$/',$model)||!cfg('AI_API_KEY'))throw new AIProviderError('Invalid Gemini configuration.');
  $payload=self::payload($messages);
  $r=SafeHttp::request('https://generativelanguage.googleapis.com/v1beta/models/'.$model.':generateContent','POST',['Content-Type: application/json','x-goog-api-key: '.cfg('AI_API_KEY')],json_encode($payload,JSON_THROW_ON_ERROR),0,null,120);
  return self::response($r['status'],$r['body']);
 }
 public static function payload(array $messages): array {
  $contents=[];$system=[];
  foreach($messages as $message){
   if($message['role']==='system')$system[]=['text'=>$message['content']];
   else $contents[]=['role'=>$message['role']==='assistant'?'model':'user','parts'=>[['text'=>$message['content']]]];
  }
  $payload=['contents'=>$contents,'generationConfig'=>['maxOutputTokens'=>16384,'temperature'=>0.7]];
  if($system)$payload['systemInstruction']=['parts'=>$system];
  return $payload;
 }
 public static function response(int $status,string $body): array {
  if($status!==200)throw new AIProviderError(match($status){401,403=>'Gemini rejected the API key or its permissions. Update the key in Administration > Settings.',429=>'Gemini quota or rate limit reached. Check Google AI Studio usage and billing, then retry.',400=>'Gemini rejected the request. Check the API key and model in Administration > Settings.',404=>'Gemini model is unavailable. Update the model in Administration > Settings.',default=>'Gemini is temporarily unavailable. Please retry.'});
  $data=json_decode($body,true,64,JSON_THROW_ON_ERROR);
  if(!empty($data['promptFeedback']['blockReason']))throw new AIProviderError('Gemini could not process this content. Revise the request and try again.');
  $candidate=$data['candidates'][0]??[];
  if(($candidate['finishReason']??'')==='MAX_TOKENS')throw new AIProviderError('The draft exceeded the output limit. Try a shorter word count or humanize fewer sections at a time.');
  if(($candidate['finishReason']??'')!=='STOP')throw new AIProviderError('Gemini did not return a complete draft. Revise the request and try again.');
  $text='';foreach($candidate['content']['parts']??[] as $part)if(empty($part['thought'])&&is_string($part['text']??null))$text.=$part['text'];
  if(trim($text)==='')throw new AIProviderError('Gemini returned an empty response. Please retry.');
  return ['text'=>$text,'tokens'=>(int)($data['usageMetadata']['totalTokenCount']??0)];
 }
}
