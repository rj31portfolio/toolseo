<?php
final class ExternalAIProvider implements AIProviderInterface {
 public function complete(array $messages): array {
  if(parse_url((string)cfg('AI_ENDPOINT'),PHP_URL_HOST)==='generativelanguage.googleapis.com')return (new GeminiAIProvider())->complete($messages);
  if(!cfg('AI_ENDPOINT')||!cfg('AI_API_KEY')||!cfg('AI_MODEL'))throw new RuntimeException('AI API not configured. Ask your administrator to configure an AI endpoint, model and API key.');
  $r=SafeHttp::request(cfg('AI_ENDPOINT'),'POST',['Content-Type: application/json','Authorization: Bearer '.cfg('AI_API_KEY')],json_encode(['model'=>cfg('AI_MODEL'),'messages'=>$messages,'max_tokens'=>1500]),0);
  if($r['status']!==200)throw new RuntimeException('AI provider is unavailable or rejected the request.');$data=json_decode($r['body'],true,64,JSON_THROW_ON_ERROR);$text=$data['choices'][0]['message']['content']??null;if(!is_string($text)||$text==='')throw new RuntimeException('AI provider returned an invalid response.');return ['text'=>$text,'tokens'=>(int)($data['usage']['total_tokens']??0)];
 }
}
