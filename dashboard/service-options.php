<section class="expert-intro"><span class="eyebrow">A SPECIALIST ON YOUR SIDE</span><h2>Choose the help your website needs.</h2><p>Pick a service, tell us your goals, and send a request for review. Track the request and any quote in this workspace.</p><div class="expert-steps"><span><b>1</b> Choose a service</span><span><b>2</b> Share your goals</span><span><b>3</b> Review your quote</span></div></section>
<div class="expert-grid"><?php foreach([
 'SEO Audit Review'=>['Get help interpreting findings and deciding which issues to fix first.','scan'],
 'Technical SEO'=>['Request help with crawling, indexing, broken pages and site structure.','settings'],
 'On-Page SEO'=>['Get support with titles, descriptions, headings and page content.','file'],
 'Keyword Research'=>['Request keyword research tailored to your audience and goals.','search'],
 'Content Optimization'=>['Improve clarity, structure and coverage in existing content.','edit'],
 'Local SEO'=>['Request help improving your local business search presence.','globe'],
 'Monthly SEO Management'=>['Discuss a recurring plan for SEO priorities and progress reviews.','chart'],
 ] as $service=>[$copy,$icon]):?><button type="button" class="expert-card" data-select-service="<?=e($service)?>"><span class="service-symbol"><?=WorkspaceUI::icon($icon)?></span><span class="expert-card-copy"><strong><?=e($service)?></strong><span><?=e($copy)?></span><em>Select service →</em></span></button><?php endforeach;?></div>
