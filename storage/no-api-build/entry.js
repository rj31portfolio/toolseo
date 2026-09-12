import * as csso from './node_modules/csso/lib/index.js';
import {minify as js} from './node_modules/terser/main.js';
import {minify as html} from './node_modules/html-minifier-terser/dist/htmlminifier.esm.bundle.js';
self.onmessage = async ({data}) => {
 try {
  let output;
  if(data.language==='javascript') output=(await js(data.source,{compress:false,mangle:false,format:{comments:'some'}})).code;
  else if(data.language==='css') output=csso.minify(data.source,{restructure:false}).css;
  else output=await html(data.source,{removeComments:true,collapseWhitespace:false,removeAttributeQuotes:true,minifyJS:false,minifyCSS:false});
  self.postMessage({output});
 } catch(error) {self.postMessage({error:error.message});}
};
