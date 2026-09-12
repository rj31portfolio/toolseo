<?php
require __DIR__.'/unit.php';
$payload=GeminiAIProvider::payload([['role'=>'system','content'=>'System context'],['role'=>'user','content'=>'Write'],['role'=>'assistant','content'=>'Draft'],['role'=>'user','content'=>'Revise']]);
check($payload['systemInstruction']['parts'][0]['text']==='System context','Gemini system instruction separated from user contents');
check(array_column($payload['contents'],'role')===['user','model','user'],'Gemini conversation roles translated');
$body=json_encode(['candidates'=>[['finishReason'=>'STOP','content'=>['parts'=>[['text'=>'private reasoning','thought'=>true],['text'=>'Complete '],['text'=>'draft']]]]],'usageMetadata'=>['totalTokenCount'=>123]]);
$response=GeminiAIProvider::response(200,$body);
check($response===['text'=>'Complete draft','tokens'=>123],'Gemini joins text parts, excludes thoughts and records usage');
foreach([400,401,403,404,429,500] as $code)rejects(fn()=>GeminiAIProvider::response($code,'{"error":{"message":"secret provider details"}}'),'Gemini HTTP '.$code.' fails safely');
foreach(['MAX_TOKENS','SAFETY','RECITATION','OTHER'] as $reason)rejects(fn()=>GeminiAIProvider::response(200,json_encode(['candidates'=>[['finishReason'=>$reason,'content'=>['parts'=>[['text'=>'partial']]]]]])),'Reject incomplete Gemini output: '.$reason);
rejects(fn()=>GeminiAIProvider::response(200,'{"promptFeedback":{"blockReason":"SAFETY"}}'),'Reject blocked prompt');
rejects(fn()=>GeminiAIProvider::response(200,'{"candidates":[{"finishReason":"STOP"}]}'),'Reject empty generation');
rejects(fn()=>GeminiAIProvider::response(200,'invalid'),'Reject malformed provider JSON');
foreach(array_keys(AIWriting::tools()) as $tool){$_POST=['tool'=>$tool,'topic'=>'Gardening','source'=>'First section.\nSecond section.'];$prompt=AIWriting::prompt();check(str_contains($prompt,$tool==='humanize'?'Second section.':'Gardening'),'Writing tool builds prompt: '.$tool);}
$_POST=['tool'=>'humanize','source'=>str_repeat('a',30000)];check(str_contains(AIWriting::prompt(),str_repeat('a',30000)),'Full 30,000-character source retained');
$_POST=['tool'=>'humanize','source'=>str_repeat('a',30001)];rejects(fn()=>AIWriting::prompt(),'Reject oversized source without truncation');
$_POST=['tool'=>'humanize'];rejects(fn()=>AIWriting::prompt(),'Humanizer requires source');
$_POST=['tool'=>'blog'];rejects(fn()=>AIWriting::prompt(),'Blog requires topic');
$_POST=['tool'=>'unknown','topic'=>'Gardening'];rejects(fn()=>AIWriting::prompt(),'Reject unknown writing tools');
$_POST=['tool'=>'article','topic'=>'Gardening','words'=>'999999'];rejects(fn()=>AIWriting::prompt(),'Enforce word count options');
echo "PASS: $total total checks\n";
