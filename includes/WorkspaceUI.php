<?php
final class WorkspaceUI {
 public static function catalog(): array {return [
  'no-api-tools'=>['Create','No-API tools','Local SEO, text, code and image utilities.','Choose a utility and enter your content.','Generated files, image exports and content checks.','code'],
  'audit'=>['Discover','Website audit','Find technical and content issues on your website.','Run an audit, then review issues in priority order.','A health score, affected pages and recommended fixes.','scan'],
  'local-seo'=>['Discover','GBP / Local SEO analyzer','Audit manually entered business profile and local website details.','Enter your profile, reviews, hours and comparison details.','A local readiness score, recommendations, schema, saved history and PDF report.','globe'],
  'pages'=>['Discover','Page analysis','Understand what each crawled page needs.','Open a page to review its title, headings and metadata.','Page details and suggestions you can act on.','file'],
  'research'=>['Discover','Keyword research','Find search terms relevant to your audience.','Enter a topic or seed keyword to explore related searches.','Keyword suggestions and available provider metrics.','search'],
  'competitors'=>['Discover','Competitor research','Keep the websites you compete with in one place.','Add a competitor website and your research notes.','An organized competitor list for future research.','layers'],
  'keywords'=>['Track','Your keywords','Organize the searches you want to be found for.','Add keywords individually or import a CSV file.','Your keyword list, target pages and saved positions.','key'],
  'rankings'=>['Track','Google rankings','See where your pages appear in Google search.','Add keywords, then check their positions.','Saved positions, ranking URLs and movement over time.','chart'],
  'backlinks'=>['Track','Backlinks','Review the links pointing to your website.','Add or import links, then check their status.','Link details and verification results.','link'],
  'reports'=>['Track','SEO reports','Share your website progress in a clear report.','Generate a report using this project’s saved data.','A report you can review, print or download as a PDF.','file'],
  'ai-assistant'=>['Create','AI writing & assistant','Write titles, keywords, blogs and articles with AI.','Choose a writing tool or ask about your project.','A saved draft you can read, copy, download and humanize.','spark'],
  'content'=>['Create','Content planner','Turn a topic into a focused content plan.','Add your topic, target keyword and audience.','Saved content projects and editable AI or manual briefs.','edit'],
  'schema'=>['Create','Schema generator','Help search engines understand your page content.','Choose a schema type and provide its properties.','JSON-LD code to review and add to your website.','code'],
  'sitemap-generator'=>['Create','Sitemap generator','Create an XML list of pages for search engines.','Paste page URLs or add pages from your latest completed audit.','A sitemap.xml file you can copy, download and publish.','layers'],
  'robots-generator'=>['Create','Robots.txt generator','Control which paths search crawlers may access.','Choose crawlers, add path rules and link your sitemap.','A robots.txt file with a preview and download.','code'],
  'internal-links'=>['Create','Internal links','Connect related pages on your website.','Run the analysis after crawling your pages.','Suggested source pages, destinations and anchor text.','link'],
  'tasks'=>['Manage','SEO tasks','Keep improvements organized and moving forward.','Create tasks, assign a priority and update their status.','A shared list of next steps and completed work.','check'],
  'automations'=>['Manage','Automation rules','Create follow-up tasks from audit findings.','Enable the rules you want, then run an audit.','Tasks created when a matching issue is found.','bolt'],
  'human-services'=>['Manage','Expert SEO services','Get help from an SEO specialist.','Choose a service and describe your goals and budget.','A request for review, a quote and progress updates.','people'],
  'team'=>['Manage','Team & branding','Work together and personalize your reports.','Assign registered members to this project.','Shared project access and saved report branding.','people'],
 ];}
 public static function icon(string $name): string {
  $paths=['scan'=>'M8 3H3v5m13-5h5v5M3 16v5h5m13-5v5h-5M7 12h10','search'=>'M21 21l-5-5M18 10a8 8 0 1 1-16 0 8 8 0 0 1 16 0','file'=>'M14 2H5v20h14V7zM14 2v6h5M8 12h8M8 16h6','layers'=>'M12 3 2 8l10 5 10-5-10-5zM2 12l10 5 10-5M2 16l10 5 10-5','key'=>'M14 5a5 5 0 1 1-7 7L2 17v5h5v-3h3l3-3','chart'=>'M3 3v18h18M7 15l4-5 4 2 6-7','link'=>'M10 13a5 5 0 0 0 7 0l4-4a5 5 0 0 0-7-7l-3 3M14 11a5 5 0 0 0-7 0l-4 4a5 5 0 0 0 7 7l3-3','spark'=>'m12 3 3 6 6 3-6 3-3 6-3-6-6-3 6-3 3-6zM20 2v4m-2-2h4','edit'=>'m16 3 5 5-12 12-6 1 1-6L16 3zM13 6l5 5','code'=>'m8 6-6 6 6 6m8-12 6 6-6 6M14 3l-4 18','check'=>'M9 11l3 3L22 4M21 12v9H3V3h12','bolt'=>'m13 2-9 12h7l-1 8 10-12h-7l1-8z','people'=>'M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2M13 7a4 4 0 1 1-8 0 4 4 0 0 1 8 0M17 3a4 4 0 0 1 0 8M22 21v-2a4 4 0 0 0-3-4','grid'=>'M3 3h7v7H3zM14 3h7v7h-7zM3 14h7v7H3zM14 14h7v7h-7z','globe'=>'M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0M3 12h18M12 3c5 5 5 13 0 18-5-5-5-13 0-18','settings'=>'M4 7h16M4 17h16M8 4v6m8 4v6'];
  return '<svg class="ui-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="'.($paths[$name]??$paths['grid']).'"/></svg>';
 }
}
