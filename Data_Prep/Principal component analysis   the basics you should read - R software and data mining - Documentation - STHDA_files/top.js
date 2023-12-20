/* Prototype 1.7.1 */
var Prototype={Version:"1.7.1",Browser:function(){var a=navigator.userAgent,b="[object Opera]"==Object.prototype.toString.call(window.opera);return{IE:!!window.attachEvent&&!b,Opera:b,WebKit:-1<a.indexOf("AppleWebKit/"),Gecko:-1<a.indexOf("Gecko")&&-1===a.indexOf("KHTML"),MobileSafari:/Apple.*Mobile/.test(a)}}(),BrowserFeatures:{XPath:!!document.evaluate,SelectorsAPI:!!document.querySelector,ElementExtensions:function(){var a=window.Element||window.HTMLElement;return!(!a||!a.prototype)}(),SpecificElementExtensions:function(){if("undefined"!==
typeof window.HTMLDivElement)return!0;var a=document.createElement("div"),b=document.createElement("form"),d=!1;a.__proto__&&a.__proto__!==b.__proto__&&(d=!0);return d}()},ScriptFragment:"<script[^>]*>([\\S\\s]*?)\x3c/script\\s*>",JSONFilter:/^\/\*-secure-([\s\S]*)\*\/\s*$/,emptyFunction:function(){},K:function(a){return a}};Prototype.Browser.MobileSafari&&(Prototype.BrowserFeatures.SpecificElementExtensions=!1);
var Class=function(){function a(){}var b;a:{for(var d in{toString:1})if("toString"===d){b=!1;break a}b=!0}return{create:function(){function b(){this.initialize.apply(this,arguments)}var d=null,g=$A(arguments);Object.isFunction(g[0])&&(d=g.shift());Object.extend(b,Class.Methods);b.superclass=d;b.subclasses=[];d&&(a.prototype=d.prototype,b.prototype=new a,d.subclasses.push(b));for(var d=0,n=g.length;d<n;d++)b.addMethods(g[d]);b.prototype.initialize||(b.prototype.initialize=Prototype.emptyFunction);
return b.prototype.constructor=b},Methods:{addMethods:function(a){var d=this.superclass&&this.superclass.prototype,g=Object.keys(a);b&&(a.toString!=Object.prototype.toString&&g.push("toString"),a.valueOf!=Object.prototype.valueOf&&g.push("valueOf"));for(var n=0,m=g.length;n<m;n++){var l=g[n],c=a[l];if(d&&Object.isFunction(c)&&"$super"==c.argumentNames()[0]){var e=c,c=function(c){return function(){return d[c].apply(this,arguments)}}(l).wrap(e);c.valueOf=function(c){return function(){return c.valueOf.call(c)}}(e);
c.toString=function(c){return function(){return c.toString.call(c)}}(e)}this.prototype[l]=c}return this}}}}();
(function(){function a(c){switch(c){case null:return e;case void 0:return q}switch(typeof c){case "boolean":return s;case "number":return y;case "string":return z}return L}function b(c,a){for(var k in a)c[k]=a[k];return c}function d(c){return f("",{"":c},[])}function f(c,e,k){e=e[c];a(e)===L&&"function"===typeof e.toJSON&&(e=e.toJSON(c));c=l.call(e);switch(c){case G:case H:case F:e=e.valueOf()}switch(e){case null:return"null";case !0:return"true";case !1:return"false"}switch(typeof e){case "string":return e.inspect(!0);
case "number":return isFinite(e)?String(e):"null";case "object":for(var b=0,d=k.length;b<d;b++)if(k[b]===e)throw new TypeError("Cyclic reference to '"+e+"' in object");k.push(e);var q=[];if(c===J){b=0;for(d=e.length;b<d;b++){var m=f(b,e,k);q.push("undefined"===typeof m?"null":m)}q="["+q.join(",")+"]"}else{for(var j=Object.keys(e),b=0,d=j.length;b<d;b++)c=j[b],m=f(c,e,k),"undefined"!==typeof m&&q.push(c.inspect(!0)+":"+m);q="{"+q.join(",")+"}"}k.pop();return q}}function h(c){return JSON.stringify(c)}
function g(e){if(a(e)!==L)throw new TypeError;var b=[],k;for(k in e)c.call(e,k)&&b.push(k);if(t)for(var d=0;k=E[d];d++)c.call(e,k)&&b.push(k);return b}function n(c){return l.call(c)===J}function m(c){return"undefined"===typeof c}var l=Object.prototype.toString,c=Object.prototype.hasOwnProperty,e="Null",q="Undefined",s="Boolean",y="Number",z="String",L="Object",H="[object Boolean]",G="[object Number]",F="[object String]",J="[object Array]",u=window.JSON&&"function"===typeof JSON.stringify&&"0"===JSON.stringify(0)&&
"undefined"===typeof JSON.stringify(Prototype.K),E="toString toLocaleString valueOf hasOwnProperty isPrototypeOf propertyIsEnumerable constructor".split(" "),t;a:{for(var M in{toString:1})if("toString"===M){t=!1;break a}t=!0}"function"==typeof Array.isArray&&(Array.isArray([])&&!Array.isArray({}))&&(n=Array.isArray);b(Object,{extend:b,inspect:function(c){try{return m(c)?"undefined":null===c?"null":c.inspect?c.inspect():String(c)}catch(a){if(a instanceof RangeError)return"...";throw a;}},toJSON:u?
h:d,toQueryString:function(c){return $H(c).toQueryString()},toHTML:function(c){return c&&c.toHTML?c.toHTML():String.interpret(c)},keys:Object.keys||g,values:function(c){var a=[],k;for(k in c)a.push(c[k]);return a},clone:function(c){return b({},c)},isElement:function(c){return!!(c&&1==c.nodeType)},isArray:n,isHash:function(c){return c instanceof Hash},isFunction:function(c){return"[object Function]"===l.call(c)},isString:function(c){return l.call(c)===F},isNumber:function(c){return l.call(c)===G},
isDate:function(c){return"[object Date]"===l.call(c)},isUndefined:m})})();
Object.extend(Function.prototype,function(){function a(a,b){for(var d=a.length,l=b.length;l--;)a[d+l]=b[l];return a}function b(b,d){b=f.call(b,0);return a(b,d)}function d(a){if(2>arguments.length&&Object.isUndefined(arguments[0]))return this;if(!Object.isFunction(this))throw new TypeError("The object is not callable.");var d=function(){},m=this,l=f.call(arguments,1),c=function(){var e=b(l,arguments),d=a,d=this instanceof c?this:a;return m.apply(d,e)};d.prototype=this.prototype;c.prototype=new d;return c}
var f=Array.prototype.slice,h={argumentNames:function(){var a=this.toString().match(/^[\s\(]*function[^(]*\(([^)]*)\)/)[1].replace(/\/\/.*?[\r\n]|\/\*(?:.|[\r\n])*?\*\//g,"").replace(/\s+/g,"").split(",");return 1==a.length&&!a[0]?[]:a},bindAsEventListener:function(b){var d=this,m=f.call(arguments,1);return function(l){l=a([l||window.event],m);return d.apply(b,l)}},curry:function(){if(!arguments.length)return this;var a=this,d=f.call(arguments,0);return function(){var m=b(d,arguments);return a.apply(this,
m)}},delay:function(a){var b=this,d=f.call(arguments,1);return window.setTimeout(function(){return b.apply(b,d)},1E3*a)},defer:function(){var b=a([0.01],arguments);return this.delay.apply(this,b)},wrap:function(b){var d=this;return function(){var m=a([d.bind(this)],arguments);return b.apply(this,m)}},methodize:function(){if(this._methodized)return this._methodized;var b=this;return this._methodized=function(){var d=a([this],arguments);return b.apply(null,d)}}};Function.prototype.bind||(h.bind=d);
return h}());(function(a){function b(){return this.getUTCFullYear()+"-"+(this.getUTCMonth()+1).toPaddedString(2)+"-"+this.getUTCDate().toPaddedString(2)+"T"+this.getUTCHours().toPaddedString(2)+":"+this.getUTCMinutes().toPaddedString(2)+":"+this.getUTCSeconds().toPaddedString(2)+"Z"}function d(){return this.toISOString()}a.toISOString||(a.toISOString=b);a.toJSON||(a.toJSON=d)})(Date.prototype);RegExp.prototype.match=RegExp.prototype.test;
RegExp.escape=function(a){return String(a).replace(/([.*+?^=!:${}()|[\]\/\\])/g,"\\$1")};
var PeriodicalExecuter=Class.create({initialize:function(a,b){this.callback=a;this.frequency=b;this.currentlyExecuting=!1;this.registerCallback()},registerCallback:function(){this.timer=setInterval(this.onTimerEvent.bind(this),1E3*this.frequency)},execute:function(){this.callback(this)},stop:function(){this.timer&&(clearInterval(this.timer),this.timer=null)},onTimerEvent:function(){if(!this.currentlyExecuting)try{this.currentlyExecuting=!0,this.execute(),this.currentlyExecuting=!1}catch(a){throw this.currentlyExecuting=
!1,a;}}});Object.extend(String,{interpret:function(a){return null==a?"":String(a)},specialChar:{"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r","\\":"\\\\"}});
Object.extend(String.prototype,function(){function a(a){if(Object.isFunction(a))return a;var b=new Template(a);return function(a){return b.evaluate(a)}}function b(){return this.replace(/^\s+/,"").replace(/\s+$/,"")}function d(a){var b=this.strip().match(/([^?#]*)(#.*)?$/);return!b?{}:b[1].split(a||"&").inject({},function(a,c){if((c=c.split("="))[0]){var e=decodeURIComponent(c.shift()),b=1<c.length?c.join("="):c[0];void 0!=b&&(b=decodeURIComponent(b));e in a?(Object.isArray(a[e])||(a[e]=[a[e]]),a[e].push(b)):
a[e]=b}return a})}function f(a){var b=this.unfilterJSON(),d=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;d.test(b)&&(b=b.replace(d,function(c){return"\\u"+("0000"+c.charCodeAt(0).toString(16)).slice(-4)}));try{if(!a||b.isJSON())return eval("("+b+")")}catch(c){}throw new SyntaxError("Badly formed JSON string: "+this.inspect());}function h(){var a=this.unfilterJSON();return JSON.parse(a)}var g=window.JSON&&"function"===typeof JSON.parse&&
JSON.parse('{"test": true}').test;return{gsub:function(b,d){var f="",c=this,e;d=a(d);Object.isString(b)&&(b=RegExp.escape(b));if(!b.length&&!b.source)return d=d(""),d+c.split("").join(d)+d;for(;0<c.length;)(e=c.match(b))?(f+=c.slice(0,e.index),f+=String.interpret(d(e)),c=c.slice(e.index+e[0].length)):(f+=c,c="");return f},sub:function(b,d,f){d=a(d);f=Object.isUndefined(f)?1:f;return this.gsub(b,function(c){return 0>--f?c[0]:d(c)})},scan:function(a,b){this.gsub(a,b);return String(this)},truncate:function(a,
b){a=a||30;b=Object.isUndefined(b)?"...":b;return this.length>a?this.slice(0,a-b.length)+b:String(this)},strip:String.prototype.trim||b,stripTags:function(){return this.replace(/<\w+(\s+("[^"]*"|'[^']*'|[^>])+)?>|<\/\w+>/gi,"")},stripScripts:function(){return this.replace(RegExp(Prototype.ScriptFragment,"img"),"")},extractScripts:function(){var a=RegExp(Prototype.ScriptFragment,"im");return(this.match(RegExp(Prototype.ScriptFragment,"img"))||[]).map(function(b){return(b.match(a)||["",""])[1]})},evalScripts:function(){return this.extractScripts().map(function(a){return eval(a)})},
escapeHTML:function(){return this.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;")},unescapeHTML:function(){return this.stripTags().replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&amp;/g,"&")},toQueryParams:d,parseQuery:d,toArray:function(){return this.split("")},succ:function(){return this.slice(0,this.length-1)+String.fromCharCode(this.charCodeAt(this.length-1)+1)},times:function(a){return 1>a?"":Array(a+1).join(this)},camelize:function(){return this.replace(/-+(.)?/g,function(a,
b){return b?b.toUpperCase():""})},capitalize:function(){return this.charAt(0).toUpperCase()+this.substring(1).toLowerCase()},underscore:function(){return this.replace(/::/g,"/").replace(/([A-Z]+)([A-Z][a-z])/g,"$1_$2").replace(/([a-z\d])([A-Z])/g,"$1_$2").replace(/-/g,"_").toLowerCase()},dasherize:function(){return this.replace(/_/g,"-")},inspect:function(a){var b=this.replace(/[\x00-\x1f\\]/g,function(a){return a in String.specialChar?String.specialChar[a]:"\\u00"+a.charCodeAt().toPaddedString(2,
16)});return a?'"'+b.replace(/"/g,'\\"')+'"':"'"+b.replace(/'/g,"\\'")+"'"},unfilterJSON:function(a){return this.replace(a||Prototype.JSONFilter,"$1")},isJSON:function(){var a=this;if(a.blank())return!1;a=a.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@");a=a.replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]");a=a.replace(/(?:^|:|,)(?:\s*\[)+/g,"");return/^[\],:{}\s]*$/.test(a)},evalJSON:g?h:f,include:function(a){return-1<this.indexOf(a)},startsWith:function(a){return 0===
this.lastIndexOf(a,0)},endsWith:function(a){var b=this.length-a.length;return 0<=b&&this.indexOf(a,b)===b},empty:function(){return""==this},blank:function(){return/^\s*$/.test(this)},interpolate:function(a,b){return(new Template(this,b)).evaluate(a)}}}());
var Template=Class.create({initialize:function(a,b){this.template=a.toString();this.pattern=b||Template.Pattern},evaluate:function(a){a&&Object.isFunction(a.toTemplateReplacements)&&(a=a.toTemplateReplacements());return this.template.gsub(this.pattern,function(b){if(null==a)return b[1]+"";var d=b[1]||"";if("\\"==d)return b[2];var f=a,h=b[3],g=/^([^.[]+|\[((?:.*?[^\\])?)\])(\.|\[|$)/;b=g.exec(h);if(null==b)return d;for(;null!=b;){var n=b[1].startsWith("[")?b[2].replace(/\\\\]/g,"]"):b[1],f=f[n];if(null==
f||""==b[3])break;h=h.substring("["==b[3]?b[1].length:b[0].length);b=g.exec(h)}return d+String.interpret(f)})}});Template.Pattern=/(^|.|\r|\n)(#\{(.*?)\})/;
var $break={},Enumerable=function(){function a(a,b){a=a||Prototype.K;var c=!0;this.each(function(e,d){c=c&&!!a.call(b,e,d,this);if(!c)throw $break;},this);return c}function b(a,b){a=a||Prototype.K;var c=!1;this.each(function(e,d){if(c=!!a.call(b,e,d,this))throw $break;},this);return c}function d(a,b){a=a||Prototype.K;var c=[];this.each(function(e,d){c.push(a.call(b,e,d,this))},this);return c}function f(a,b){var c;this.each(function(e,d){if(a.call(b,e,d,this))throw c=e,$break;},this);return c}function h(a,
b){var c=[];this.each(function(e,d){a.call(b,e,d,this)&&c.push(e)},this);return c}function g(a){if(Object.isFunction(this.indexOf)&&-1!=this.indexOf(a))return!0;var b=!1;this.each(function(c){if(c==a)throw b=!0,$break;});return b}function n(){return this.map()}return{each:function(a,b){try{this._each(a,b)}catch(c){if(c!=$break)throw c;}return this},eachSlice:function(a,b,c){var e=-a,d=[],f=this.toArray();if(1>a)return f;for(;(e+=a)<f.length;)d.push(f.slice(e,e+a));return d.collect(b,c)},all:a,every:a,
any:b,some:b,collect:d,map:d,detect:f,findAll:h,select:h,filter:h,grep:function(a,b,c){b=b||Prototype.K;var e=[];Object.isString(a)&&(a=RegExp(RegExp.escape(a)));this.each(function(d,f){a.match(d)&&e.push(b.call(c,d,f,this))},this);return e},include:g,member:g,inGroupsOf:function(a,b){b=Object.isUndefined(b)?null:b;return this.eachSlice(a,function(c){for(;c.length<a;)c.push(b);return c})},inject:function(a,b,c){this.each(function(e,d){a=b.call(c,a,e,d,this)},this);return a},invoke:function(a){var b=
$A(arguments).slice(1);return this.map(function(c){return c[a].apply(c,b)})},max:function(a,b){a=a||Prototype.K;var c;this.each(function(e,d){e=a.call(b,e,d,this);if(null==c||e>=c)c=e},this);return c},min:function(a,b){a=a||Prototype.K;var c;this.each(function(e,d){e=a.call(b,e,d,this);if(null==c||e<c)c=e},this);return c},partition:function(a,b){a=a||Prototype.K;var c=[],e=[];this.each(function(d,f){(a.call(b,d,f,this)?c:e).push(d)},this);return[c,e]},pluck:function(a){var b=[];this.each(function(c){b.push(c[a])});
return b},reject:function(a,b){var c=[];this.each(function(e,d){a.call(b,e,d,this)||c.push(e)},this);return c},sortBy:function(a,b){return this.map(function(c,d){return{value:c,criteria:a.call(b,c,d,this)}},this).sort(function(a,b){var d=a.criteria,f=b.criteria;return d<f?-1:d>f?1:0}).pluck("value")},toArray:n,entries:n,zip:function(){var a=Prototype.K,b=$A(arguments);Object.isFunction(b.last())&&(a=b.pop());var c=[this].concat(b).map($A);return this.map(function(b,d){return a(c.pluck(d))})},size:function(){return this.toArray().length},
inspect:function(){return"#<Enumerable:"+this.toArray().inspect()+">"},find:f}}();function $A(a){if(!a)return[];if("toArray"in Object(a))return a.toArray();for(var b=a.length||0,d=Array(b);b--;)d[b]=a[b];return d}function $w(a){return!Object.isString(a)?[]:(a=a.strip())?a.split(/\s+/):[]}Array.from=$A;
(function(){function a(a,c){for(var b=0,d=this.length>>>0;b<d;b++)b in this&&a.call(c,this[b],b,this)}function b(){return s.call(this,0)}function d(a,c){if(null==this)throw new TypeError;var b=Object(this),d=b.length>>>0;if(0===d)return-1;c=Number(c);isNaN(c)?c=0:0!==c&&isFinite(c)&&(c=(0<c?1:-1)*Math.floor(Math.abs(c)));if(c>d)return-1;for(var e=0<=c?c:Math.max(d-Math.abs(c),0);e<d;e++)if(e in b&&b[e]===a)return e;return-1}function f(c,a){if(null==this)throw new TypeError;var b=Object(this),d=b.length>>>
0;if(0===d)return-1;Object.isUndefined(a)?a=d:(a=Number(a),isNaN(a)?a=0:0!==a&&isFinite(a)&&(a=(0<a?1:-1)*Math.floor(Math.abs(a))));for(d=0<=a?Math.min(a,d-1):d-Math.abs(a);0<=d;d--)if(d in b&&b[d]===c)return d;return-1}function h(a){var c=[],b=s.call(arguments,0),d,e=0;b.unshift(this);for(var f=0,q=b.length;f<q;f++)if(d=b[f],Object.isArray(d)&&!("callee"in d))for(var g=0,h=d.length;g<h;g++)g in d&&(c[e]=d[g]),e++;else c[e++]=d;c.length=e;return c}function g(a){return function(){if(0===arguments.length)return a.call(this,
Prototype.K);if(void 0===arguments[0]){var c=s.call(arguments,1);c.unshift(Prototype.K);return a.apply(this,c)}return a.apply(this,arguments)}}function n(a,c){if(null==this)throw new TypeError;a=a||Prototype.K;for(var b=Object(this),d=[],e=0,f=0,q=b.length>>>0;f<q;f++)f in b&&(d[e]=a.call(c,b[f],f,b)),e++;d.length=e;return d}function m(a,c){if(null==this||!Object.isFunction(a))throw new TypeError;for(var b=Object(this),d=[],e,f=0,q=b.length>>>0;f<q;f++)f in b&&(e=b[f],a.call(c,e,f,b)&&d.push(e));
return d}function l(a,c){if(null==this)throw new TypeError;a=a||Prototype.K;for(var b=Object(this),d=0,e=b.length>>>0;d<e;d++)if(d in b&&a.call(c,b[d],d,b))return!0;return!1}function c(a,c){if(null==this)throw new TypeError;a=a||Prototype.K;for(var b=Object(this),d=0,e=b.length>>>0;d<e;d++)if(d in b&&!a.call(c,b[d],d,b))return!1;return!0}function e(a,c,b){c=c||Prototype.K;return z.call(this,c.bind(b),a)}var q=Array.prototype,s=q.slice,y=q.forEach;y||(y=a);q.map&&(n=g(Array.prototype.map));q.filter&&
(m=Array.prototype.filter);q.some&&(l=g(Array.prototype.some));q.every&&(c=g(Array.prototype.every));var z=q.reduce;q.reduce||(e=Enumerable.inject);Object.extend(q,Enumerable);q._reverse||(q._reverse=q.reverse);Object.extend(q,{_each:y,map:n,collect:n,select:m,filter:m,findAll:m,some:l,any:l,every:c,all:c,inject:e,clear:function(){this.length=0;return this},first:function(){return this[0]},last:function(){return this[this.length-1]},compact:function(){return this.select(function(a){return null!=a})},
flatten:function(){return this.inject([],function(a,c){if(Object.isArray(c))return a.concat(c.flatten());a.push(c);return a})},without:function(){var a=s.call(arguments,0);return this.select(function(c){return!a.include(c)})},reverse:function(a){return(!1===a?this.toArray():this)._reverse()},uniq:function(a){return this.inject([],function(c,b,d){(0==d||(a?c.last()!=b:!c.include(b)))&&c.push(b);return c})},intersect:function(a){return this.uniq().findAll(function(c){return-1!==a.indexOf(c)})},clone:b,
toArray:b,size:function(){return this.length},inspect:function(){return"["+this.map(Object.inspect).join(", ")+"]"}});(function(){return 1!==[].concat(arguments)[0][0]})(1,2)&&(q.concat=h);q.indexOf||(q.indexOf=d);q.lastIndexOf||(q.lastIndexOf=f)})();function $H(a){return new Hash(a)}
var Hash=Class.create(Enumerable,function(){function a(){return Object.clone(this._object)}function b(a,b){if(Object.isUndefined(b))return a;b=String.interpret(b);b=b.gsub(/(\r)?\n/,"\r\n");b=encodeURIComponent(b);b=b.gsub(/%20/,"+");return a+"="+b}return{initialize:function(a){this._object=Object.isHash(a)?a.toObject():Object.clone(a)},_each:function(a,b){for(var h in this._object){var g=this._object[h],n=[h,g];n.key=h;n.value=g;a.call(b,n)}},set:function(a,b){return this._object[a]=b},get:function(a){if(this._object[a]!==
Object.prototype[a])return this._object[a]},unset:function(a){var b=this._object[a];delete this._object[a];return b},toObject:a,toTemplateReplacements:a,keys:function(){return this.pluck("key")},values:function(){return this.pluck("value")},index:function(a){var b=this.detect(function(b){return b.value===a});return b&&b.key},merge:function(a){return this.clone().update(a)},update:function(a){return(new Hash(a)).inject(this,function(a,b){a.set(b.key,b.value);return a})},toQueryString:function(){return this.inject([],
function(a,f){var h=encodeURIComponent(f.key),g=f.value;if(g&&"object"==typeof g){if(Object.isArray(g)){for(var n=[],m=0,l=g.length,c;m<l;m++)c=g[m],n.push(b(h,c));return a.concat(n)}}else a.push(b(h,g));return a}).join("&")},inspect:function(){return"#<Hash:{"+this.map(function(a){return a.map(Object.inspect).join(": ")}).join(", ")+"}>"},toJSON:a,clone:function(){return new Hash(this)}}}());Hash.from=$H;
Object.extend(Number.prototype,function(){return{toColorPart:function(){return this.toPaddedString(2,16)},succ:function(){return this+1},times:function(a,b){$R(0,this,!0).each(a,b);return this},toPaddedString:function(a,b){var d=this.toString(b||10);return"0".times(a-d.length)+d},abs:function(){return Math.abs(this)},round:function(){return Math.round(this)},ceil:function(){return Math.ceil(this)},floor:function(){return Math.floor(this)}}}());function $R(a,b,d){return new ObjectRange(a,b,d)}
var ObjectRange=Class.create(Enumerable,function(){return{initialize:function(a,b,d){this.start=a;this.end=b;this.exclusive=d},_each:function(a,b){for(var d=this.start;this.include(d);)a.call(b,d),d=d.succ()},include:function(a){return a<this.start?!1:this.exclusive?a<this.end:a<=this.end}}}()),Abstract={},Try={these:function(){for(var a,b=0,d=arguments.length;b<d;b++){var f=arguments[b];try{a=f();break}catch(h){}}return a}},Ajax={getTransport:function(){return Try.these(function(){return new XMLHttpRequest},
function(){return new ActiveXObject("Msxml2.XMLHTTP")},function(){return new ActiveXObject("Microsoft.XMLHTTP")})||!1},activeRequestCount:0,Responders:{responders:[],_each:function(a,b){this.responders._each(a,b)},register:function(a){this.include(a)||this.responders.push(a)},unregister:function(a){this.responders=this.responders.without(a)},dispatch:function(a,b,d,f){this.each(function(h){if(Object.isFunction(h[a]))try{h[a].apply(h,[b,d,f])}catch(g){}})}}};Object.extend(Ajax.Responders,Enumerable);
Ajax.Responders.register({onCreate:function(){Ajax.activeRequestCount++},onComplete:function(){Ajax.activeRequestCount--}});Ajax.Base=Class.create({initialize:function(a){this.options={method:"post",asynchronous:!0,contentType:"application/x-www-form-urlencoded",encoding:"UTF-8",parameters:"",evalJSON:!0,evalJS:!0};Object.extend(this.options,a||{});this.options.method=this.options.method.toLowerCase();Object.isHash(this.options.parameters)&&(this.options.parameters=this.options.parameters.toObject())}});
Ajax.Request=Class.create(Ajax.Base,{_complete:!1,initialize:function($super,b,d){$super(d);this.transport=Ajax.getTransport();this.request(b)},request:function(a){this.url=a;this.method=this.options.method;a=Object.isString(this.options.parameters)?this.options.parameters:Object.toQueryString(this.options.parameters);["get","post"].include(this.method)||(a+=(a?"&":"")+"_method="+this.method,this.method="post");a&&"get"===this.method&&(this.url+=(this.url.include("?")?"&":"?")+a);this.parameters=
a.toQueryParams();try{var b=new Ajax.Response(this);if(this.options.onCreate)this.options.onCreate(b);Ajax.Responders.dispatch("onCreate",this,b);this.transport.open(this.method.toUpperCase(),this.url,this.options.asynchronous);this.options.asynchronous&&this.respondToReadyState.bind(this).defer(1);this.transport.onreadystatechange=this.onStateChange.bind(this);this.setRequestHeaders();this.body="post"==this.method?this.options.postBody||a:null;this.transport.send(this.body);if(!this.options.asynchronous&&
this.transport.overrideMimeType)this.onStateChange()}catch(d){this.dispatchException(d)}},onStateChange:function(){var a=this.transport.readyState;1<a&&!(4==a&&this._complete)&&this.respondToReadyState(this.transport.readyState)},setRequestHeaders:function(){var a={"X-Requested-With":"XMLHttpRequest","X-Prototype-Version":Prototype.Version,Accept:"text/javascript, text/html, application/xml, text/xml, */*"};if("post"==this.method&&(a["Content-type"]=this.options.contentType+(this.options.encoding?
"; charset="+this.options.encoding:""),this.transport.overrideMimeType&&2005>(navigator.userAgent.match(/Gecko\/(\d{4})/)||[0,2005])[1]))a.Connection="close";if("object"==typeof this.options.requestHeaders){var b=this.options.requestHeaders;if(Object.isFunction(b.push))for(var d=0,f=b.length;d<f;d+=2)a[b[d]]=b[d+1];else $H(b).each(function(b){a[b.key]=b.value})}for(var h in a)this.transport.setRequestHeader(h,a[h])},success:function(){var a=this.getStatus();return!a||200<=a&&300>a||304==a},getStatus:function(){try{return 1223===
this.transport.status?204:this.transport.status||0}catch(a){return 0}},respondToReadyState:function(a){a=Ajax.Request.Events[a];var b=new Ajax.Response(this);if("Complete"==a){try{this._complete=!0,(this.options["on"+b.status]||this.options["on"+(this.success()?"Success":"Failure")]||Prototype.emptyFunction)(b,b.headerJSON)}catch(d){this.dispatchException(d)}var f=b.getHeader("Content-type");("force"==this.options.evalJS||this.options.evalJS&&this.isSameOrigin()&&f&&f.match(/^\s*(text|application)\/(x-)?(java|ecma)script(;.*)?\s*$/i))&&
this.evalResponse()}try{(this.options["on"+a]||Prototype.emptyFunction)(b,b.headerJSON),Ajax.Responders.dispatch("on"+a,this,b,b.headerJSON)}catch(h){this.dispatchException(h)}"Complete"==a&&(this.transport.onreadystatechange=Prototype.emptyFunction)},isSameOrigin:function(){var a=this.url.match(/^\s*https?:\/\/[^\/]*/);return!a||a[0]=="#{protocol}//#{domain}#{port}".interpolate({protocol:location.protocol,domain:document.domain,port:location.port?":"+location.port:""})},getHeader:function(a){try{return this.transport.getResponseHeader(a)||
null}catch(b){return null}},evalResponse:function(){try{return eval((this.transport.responseText||"").unfilterJSON())}catch(a){this.dispatchException(a)}},dispatchException:function(a){(this.options.onException||Prototype.emptyFunction)(this,a);Ajax.Responders.dispatch("onException",this,a)}});Ajax.Request.Events=["Uninitialized","Loading","Loaded","Interactive","Complete"];
Ajax.Response=Class.create({initialize:function(a){this.request=a;a=this.transport=a.transport;var b=this.readyState=a.readyState;if(2<b&&!Prototype.Browser.IE||4==b)this.status=this.getStatus(),this.statusText=this.getStatusText(),this.responseText=String.interpret(a.responseText),this.headerJSON=this._getHeaderJSON();4==b&&(a=a.responseXML,this.responseXML=Object.isUndefined(a)?null:a,this.responseJSON=this._getResponseJSON())},status:0,statusText:"",getStatus:Ajax.Request.prototype.getStatus,getStatusText:function(){try{return this.transport.statusText||
""}catch(a){return""}},getHeader:Ajax.Request.prototype.getHeader,getAllHeaders:function(){try{return this.getAllResponseHeaders()}catch(a){return null}},getResponseHeader:function(a){return this.transport.getResponseHeader(a)},getAllResponseHeaders:function(){return this.transport.getAllResponseHeaders()},_getHeaderJSON:function(){var a=this.getHeader("X-JSON");if(!a)return null;try{a=decodeURIComponent(escape(a))}catch(b){}try{return a.evalJSON(this.request.options.sanitizeJSON||!this.request.isSameOrigin())}catch(d){this.request.dispatchException(d)}},
_getResponseJSON:function(){var a=this.request.options;if(!a.evalJSON||"force"!=a.evalJSON&&!(this.getHeader("Content-type")||"").include("application/json")||this.responseText.blank())return null;try{return this.responseText.evalJSON(a.sanitizeJSON||!this.request.isSameOrigin())}catch(b){this.request.dispatchException(b)}}});
Ajax.Updater=Class.create(Ajax.Request,{initialize:function($super,b,d,f){this.container={success:b.success||b,failure:b.failure||(b.success?null:b)};f=Object.clone(f);var h=f.onComplete;f.onComplete=function(b,d){this.updateContent(b.responseText);Object.isFunction(h)&&h(b,d)}.bind(this);$super(d,f)},updateContent:function(a){var b=this.container[this.success()?"success":"failure"],d=this.options;d.evalScripts||(a=a.stripScripts());if(b=$(b))if(d.insertion)if(Object.isString(d.insertion)){var f=
{};f[d.insertion]=a;b.insert(f)}else d.insertion(b,a);else b.update(a)}});
Ajax.PeriodicalUpdater=Class.create(Ajax.Base,{initialize:function($super,b,d,f){$super(f);this.onComplete=this.options.onComplete;this.frequency=this.options.frequency||2;this.decay=this.options.decay||1;this.updater={};this.container=b;this.url=d;this.start()},start:function(){this.options.onComplete=this.updateComplete.bind(this);this.onTimerEvent()},stop:function(){this.updater.options.onComplete=void 0;clearTimeout(this.timer);(this.onComplete||Prototype.emptyFunction).apply(this,arguments)},
updateComplete:function(a){this.options.decay&&(this.decay=a.responseText==this.lastText?this.decay*this.options.decay:1,this.lastText=a.responseText);this.timer=this.onTimerEvent.bind(this).delay(this.decay*this.frequency)},onTimerEvent:function(){this.updater=new Ajax.Updater(this.container,this.url,this.options)}});
(function(a){function b(a){if(1<arguments.length){for(var c=0,e=[],k=arguments.length;c<k;c++)e.push(b(arguments[c]));return e}Object.isString(a)&&(a=document.getElementById(a));return d.extend(a)}function d(a,c){c=c||{};a=a.toLowerCase();if(aa&&c.name)return a="<"+a+' name="'+c.name+'">',delete c.name,d.writeAttribute(document.createElement(a),c);V[a]||(V[a]=d.extend(document.createElement(a)));var b=("select"===a?0:!("type"in c))?V[a].cloneNode(!1):document.createElement(a);return d.writeAttribute(b,
c)}function f(a,c){a=b(a);if(c&&c.toElement)c=c.toElement();else if(!Object.isElement(c)){c=Object.toHTML(c);var d=a.ownerDocument.createRange();d.selectNode(a);c.evalScripts.bind(c).defer();c=d.createContextualFragment(c.stripScripts())}a.parentNode.replaceChild(c,a);return a}function h(a,c){a=b(a);c&&c.toElement&&(c=c.toElement());if(Object.isElement(c))return a.parentNode.replaceChild(c,a),a;c=Object.toHTML(c);var e=a.parentNode,k=e.tagName.toUpperCase();if(k in T.tags){var j=d.next(a),k=g(k,c.stripScripts());
e.removeChild(a);k.each(j?function(a){e.insertBefore(a,j)}:function(a){e.appendChild(a)})}else a.outerHTML=c.stripScripts();c.evalScripts.bind(c).defer();return a}function g(a,c,b){var d=T.tags[a];a=B;var e=!!d;!e&&b&&(e=!0,d=["","",0]);if(e){a.innerHTML="&#160;"+d[0]+c+d[1];a.removeChild(a.firstChild);for(c=d[2];c--;)a=a.firstChild}else a.innerHTML=c;return $A(a.childNodes)}function n(a){var c=O(a);c&&(d.stopObserving(a),ba||(a._prototypeUID=ca),delete d.Storage[c])}function m(a,c,e){a=b(a);e=e||
-1;for(var k=[];(a=a[c])&&!(a.nodeType===Node.ELEMENT_NODE&&k.push(d.extend(a)),k.length===e););return k}function l(a){var c=[];for(a=b(a).firstChild;a;)a.nodeType===Node.ELEMENT_NODE&&c.push(d.extend(a)),a=a.nextSibling;return c}function c(a){return m(a,"previousSibling")}function e(a){return m(a,"nextSibling")}function q(a,c,e,k){a=b(a);e=e||0;k=k||0;Object.isNumber(e)&&(k=e,e=null);for(;a=a[c];)if(1===a.nodeType&&(!e||Prototype.Selector.match(a,e))&&!(0<=--k))return d.extend(a)}function s(a){a=
b(a);var c=v.call(arguments,1).join(", ");return Prototype.Selector.select(c,a)}function y(a,c){a=b(a);for(c=b(c);a=a.parentNode;)if(a===c)return!0;return!1}function z(a,c){a=b(a);c=b(c);return!c.contains?y(a,c):c.contains(a)&&c!==a}function L(a,c){a=b(a);c=b(c);return 8===(a.compareDocumentPosition(c)&8)}function H(a,c){return b(a).getAttribute(c)}function G(a,c){a=b(a);var e=K.read;if(e.values[c])return e.values[c](a,c);e.names[c]&&(c=e.names[c]);return c.include(":")?!a.attributes||!a.attributes[c]?
null:a.attributes[c].value:a.getAttribute(c)}function F(a,c){return"title"===c?a.title:a.getAttribute(c)}function J(a){if(da[a])return da[a];var c=RegExp("(^|\\s+)"+a+"(\\s+|$)");return da[a]=c}function u(a,c){if(a=b(a)){var e=a.className;return 0===e.length?!1:e===c?!0:J(c).test(e)}}function E(a,c){return a.getAttribute(c,2)}function t(a,c){return b(a).hasAttribute(c)?c:null}function M(a,c){a=b(a);c="float"===c||"cssFloat"===c?"styleFloat":c.camelize();var e=a.style[c];!e&&a.currentStyle&&(e=a.currentStyle[c]);
return"opacity"===c&&!W?I(a):"auto"===e?("width"===c||"height"===c)&&d.visible(a)?d.measure(a,c)+"px":null:e}function N(a,c){a=b(a);1==c||""===c?c="":1E-5>c&&(c=0);a.style.opacity=c;return a}function Q(a,c){if(W)return N(a,c);var e=b(a);e.currentStyle.hasLayout||(e.style.zoom=1);a=e;var e=d.getStyle(a,"filter"),k=a.style;if(1==c||""===c)return(e=(e||"").replace(/alpha\([^\)]*\)/gi,""))?k.filter=e:k.removeAttribute("filter"),a;1E-5>c&&(c=0);k.filter=(e||"").replace(/alpha\([^\)]*\)/gi,"")+"alpha(opacity="+
100*c+")";return a}function k(a){return d.getStyle(a,"opacity")}function I(a){if(W)return k(a);a=d.getStyle(a,"filter");if(0===a.length)return 1;a=(a||"").match(/alpha\(opacity=(.*)\)/);return a[1]?parseFloat(a[1])/100:1}function O(a){if(a===window)return 0;"undefined"===typeof a._prototypeUID&&(a._prototypeUID=d.Storage.UID++);return a._prototypeUID}function Z(a){return a===window?0:a==document?1:a.uniqueID}function S(a){if(a=b(a))return a=O(a),d.Storage[a]||(d.Storage[a]=$H()),d.Storage[a]}function j(a,
c){for(var b in c){var e=c[b];Object.isFunction(e)&&!(b in a)&&(a[b]=e.methodize())}}function r(a){if(!a||O(a)in X||a.nodeType!==Node.ELEMENT_NODE||a==window)return a;var c=Object.clone(ea),b=a.tagName.toUpperCase();R[b]&&Object.extend(c,R[b]);j(a,c);X[O(a)]=!0;return a}function p(a){if(!a||O(a)in X)return a;var c=a.tagName;c&&/^(?:object|applet|embed)$/i.test(c)&&(j(a,d.Methods),j(a,d.Methods.Simulated),j(a,d.Methods.ByTag[c.toUpperCase()]));return a}function ga(a,c){a=a.toUpperCase();R[a]||(R[a]=
{});Object.extend(R[a],c)}function fa(a,c,b){Object.isUndefined(b)&&(b=!1);for(var e in c){var d=c[e];if(Object.isFunction(d)&&(!b||!(e in a)))a[e]=d.methodize()}}function ka(a){var c,b={OPTGROUP:"OptGroup",TEXTAREA:"TextArea",P:"Paragraph",FIELDSET:"FieldSet",UL:"UList",OL:"OList",DL:"DList",DIR:"Directory",H1:"Heading",H2:"Heading",H3:"Heading",H4:"Heading",H5:"Heading",H6:"Heading",Q:"Quote",INS:"Mod",DEL:"Mod",A:"Anchor",IMG:"Image",CAPTION:"TableCaption",COL:"TableCol",COLGROUP:"TableCol",THEAD:"TableSection",
TFOOT:"TableSection",TBODY:"TableSection",TR:"TableRow",TH:"TableCell",TD:"TableCell",FRAMESET:"FrameSet",IFRAME:"IFrame"};b[a]&&(c="HTML"+b[a]+"Element");if(window[c])return window[c];c="HTML"+a+"Element";if(window[c])return window[c];c="HTML"+a.capitalize()+"Element";if(window[c])return window[c];a=document.createElement(a);return a.__proto__||a.constructor.prototype}var ca,v=Array.prototype.slice,B=document.createElement("div");a.$=b;a.Node||(a.Node={});a.Node.ELEMENT_NODE||Object.extend(a.Node,
{ELEMENT_NODE:1,ATTRIBUTE_NODE:2,TEXT_NODE:3,CDATA_SECTION_NODE:4,ENTITY_REFERENCE_NODE:5,ENTITY_NODE:6,PROCESSING_INSTRUCTION_NODE:7,COMMENT_NODE:8,DOCUMENT_NODE:9,DOCUMENT_TYPE_NODE:10,DOCUMENT_FRAGMENT_NODE:11,NOTATION_NODE:12});var V={},aa;try{var C=document.createElement('<input name="x">');aa="input"===C.tagName.toLowerCase()&&"x"===C.name}catch(na){aa=!1}C=a.Element;a.Element=d;Object.extend(a.Element,C||{});C&&(a.Element.prototype=C.prototype);d.Methods={ByTag:{},Simulated:{}};var C={},ha=
{id:"id",className:"class"};C.inspect=function(a){a=b(a);var c="<"+a.tagName.toLowerCase(),e,d,k;for(k in ha)e=ha[k],(d=(a[k]||"").toString())&&(c+=" "+e+"="+d.inspect(!0));return c+">"};Object.extend(C,{visible:function(a){return"none"!==b(a).style.display},toggle:function(a,c){a=b(a);Object.isUndefined(c)&&(c=!d.visible(a));d[c?"show":"hide"](a);return a},hide:function(a){a=b(a);a.style.display="none";return a},show:function(a){a=b(a);a.style.display="";return a}});var P;P=document.createElement("select");
var ia=!0;P.innerHTML='<option value="test">test</option>';P.options&&P.options[0]&&(ia="OPTION"!==P.options[0].nodeName.toUpperCase());P=ia;var w;a:{try{var A=document.createElement("table");if(A&&A.tBodies){A.innerHTML="<tbody><tr><td>test</td></tr></tbody>";w="undefined"==typeof A.tBodies[0];break a}}catch(oa){w=!0;break a}w=void 0}var Y;try{var D=document.createElement("div");D.innerHTML="<link />";Y=0===D.childNodes.length}catch(pa){Y=!0}var la=P||w||Y,ja;w=document.createElement("script");A=
!1;try{w.appendChild(document.createTextNode("")),A=!w.firstChild||w.firstChild&&3!==w.firstChild.nodeType}catch(qa){A=!0}ja=A;var T={before:function(a,c){a.parentNode.insertBefore(c,a)},top:function(a,c){a.insertBefore(c,a.firstChild)},bottom:function(a,c){a.appendChild(c)},after:function(a,c){a.parentNode.insertBefore(c,a.nextSibling)},tags:{TABLE:["<table>","</table>",1],TBODY:["<table><tbody>","</tbody></table>",2],TR:["<table><tbody><tr>","</tr></tbody></table>",3],TD:["<table><tbody><tr><td>",
"</td></tr></tbody></table>",4],SELECT:["<select>","</select>",1]}};w=T.tags;Object.extend(w,{THEAD:w.TBODY,TFOOT:w.TBODY,TH:w.TD});"outerHTML"in document.documentElement&&(f=h);Object.extend(C,{remove:function(a){a=b(a);a.parentNode.removeChild(a);return a},update:function(a,c){a=b(a);for(var e=a.getElementsByTagName("*"),d=e.length;d--;)n(e[d]);c&&c.toElement&&(c=c.toElement());if(Object.isElement(c))return a.update().insert(c);c=Object.toHTML(c);d=a.tagName.toUpperCase();if("SCRIPT"===d&&ja)return a.text=
c,a;if(la)if(d in T.tags){for(;a.firstChild;)a.removeChild(a.firstChild);for(var e=g(d,c.stripScripts()),d=0,k;k=e[d];d++)a.appendChild(k)}else if(Y&&Object.isString(c)&&-1<c.indexOf("<link")){for(;a.firstChild;)a.removeChild(a.firstChild);e=g(d,c.stripScripts(),!0);for(d=0;k=e[d];d++)a.appendChild(k)}else a.innerHTML=c.stripScripts();else a.innerHTML=c.stripScripts();c.evalScripts.bind(c).defer();return a},replace:f,insert:function(a,c){a=b(a);(Object.isUndefined(c)||null===c?0:Object.isString(c)||
Object.isNumber(c)||Object.isElement(c)||c.toElement||c.toHTML)&&(c={bottom:c});for(var e in c){var d=a,k=c[e],j=e,j=j.toLowerCase(),I=T[j];k&&k.toElement&&(k=k.toElement());if(Object.isElement(k))I(d,k);else{var k=Object.toHTML(k),q=("before"===j||"after"===j?d.parentNode:d).tagName.toUpperCase(),q=g(q,k.stripScripts());("top"===j||"after"===j)&&q.reverse();for(var j=0,f=void 0;f=q[j];j++)I(d,f);k.evalScripts.bind(k).defer()}}return a},wrap:function(a,c,e){a=b(a);Object.isElement(c)?b(c).writeAttribute(e||
{}):c=Object.isString(c)?new d(c,e):new d("div",c);a.parentNode&&a.parentNode.replaceChild(c,a);c.appendChild(a);return c},cleanWhitespace:function(a){a=b(a);for(var c=a.firstChild;c;){var e=c.nextSibling;c.nodeType===Node.TEXT_NODE&&!/\S/.test(c.nodeValue)&&a.removeChild(c);c=e}return a},empty:function(a){return b(a).innerHTML.blank()},clone:function(a,c){if(a=b(a)){var e=a.cloneNode(c);if(!ba&&(e._prototypeUID=ca,c))for(var k=d.select(e,"*"),j=k.length;j--;)k[j]._prototypeUID=ca;return d.extend(e)}},
purge:function(a){if(a=b(a)){n(a);a=a.getElementsByTagName("*");for(var c=a.length;c--;)n(a[c]);return null}}});Object.extend(C,{recursivelyCollect:m,ancestors:function(a){return m(a,"parentNode")},descendants:function(a){return d.select(a,"*")},firstDescendant:function(a){for(a=b(a).firstChild;a&&a.nodeType!==Node.ELEMENT_NODE;)a=a.nextSibling;return b(a)},immediateDescendants:l,previousSiblings:c,nextSiblings:e,siblings:function(a){a=b(a);var d=c(a);a=e(a);return d.reverse().concat(a)},match:function(a,
c){a=b(a);return Object.isString(c)?Prototype.Selector.match(a,c):c.match(a)},up:function(a,c,e){a=b(a);return 1===arguments.length?b(a.parentNode):q(a,"parentNode",c,e)},down:function(a,c,e){a=b(a);c=c||0;e=e||0;Object.isNumber(c)&&(e=c,c="*");a=Prototype.Selector.select(c,a)[e];return d.extend(a)},previous:function(a,c,b){return q(a,"previousSibling",c,b)},next:function(a,c,b){return q(a,"nextSibling",c,b)},select:s,adjacent:function(a){a=b(a);for(var c=v.call(arguments,1).join(", "),e=d.siblings(a),
k=[],j=0,I;I=e[j];j++)Prototype.Selector.match(I,c)&&k.push(I);return k},descendantOf:B.compareDocumentPosition?L:B.contains?z:y,getElementsBySelector:s,childElements:l});var ma=1;B.setAttribute("onclick",Prototype.emptyFunction);w="function"===typeof B.getAttribute("onclick");B.removeAttribute("onclick");w?H=G:Prototype.Browser.Opera&&(H=F);a.Element.Methods.Simulated.hasAttribute=function(a,c){c=K.has[c]||c;var e=b(a).getAttributeNode(c);return!(!e||!e.specified)};var da={},K={};w="className";A=
"for";B.setAttribute(w,"x");"x"!==B.className&&(B.setAttribute("class","x"),"x"===B.className&&(w="class"));D=document.createElement("label");D.setAttribute(A,"x");"x"!==D.htmlFor&&(D.setAttribute("htmlFor","x"),"x"===D.htmlFor&&(A="htmlFor"));D=null;B.onclick=Prototype.emptyFunction;var D=B.getAttribute("onclick"),x;-1<String(D).indexOf("{")?x=function(a,c){var b=a.getAttribute(c);if(!b)return null;b=b.toString();b=b.split("{")[1];b=b.split("}")[0];return b.strip()}:""===D&&(x=function(a,c){var b=
a.getAttribute(c);return!b?null:b.strip()});K.read={names:{"class":w,className:w,"for":A,htmlFor:A},values:{style:function(a){return a.style.cssText.toLowerCase()},title:function(a){return a.title}}};K.write={names:{className:"class",htmlFor:"for",cellpadding:"cellPadding",cellspacing:"cellSpacing"},values:{checked:function(a,c){a.checked=!!c},style:function(a,c){a.style.cssText=c?c:""}}};K.has={names:{}};Object.extend(K.write.names,K.read.names);w=$w("colSpan rowSpan vAlign dateTime accessKey tabIndex encType maxLength readOnly longDesc frameBorder");
for(A=0;D=w[A];A++)K.write.names[D.toLowerCase()]=D,K.has.names[D.toLowerCase()]=D;Object.extend(K.read.values,{href:E,src:E,type:function(a,c){return a.getAttribute(c)},action:function(a,c){var b=a.getAttributeNode(c);return b?b.value:""},disabled:t,checked:t,readonly:t,multiple:t,onload:x,onunload:x,onclick:x,ondblclick:x,onmousedown:x,onmouseup:x,onmouseover:x,onmousemove:x,onmouseout:x,onfocus:x,onblur:x,onkeypress:x,onkeydown:x,onkeyup:x,onsubmit:x,onreset:x,onselect:x,onchange:x});Object.extend(C,
{identify:function(a){a=b(a);var c=d.readAttribute(a,"id");if(c)return c;do c="anonymous_element_"+ma++;while(b(c));d.writeAttribute(a,"id",c);return c},readAttribute:H,writeAttribute:function(a,c,e){a=b(a);var d={},k=K.write;"object"===typeof c?d=c:d[c]=Object.isUndefined(e)?!0:e;for(var j in d)c=k.names[j]||j,e=d[j],k.values[j]&&(c=k.values[j](a,e)),!1===e||null===e?a.removeAttribute(c):!0===e?a.setAttribute(c,c):a.setAttribute(c,e);return a},classNames:function(a){return new d.ClassNames(a)},hasClassName:u,
addClassName:function(a,c){if(a=b(a))return u(a,c)||(a.className+=(a.className?" ":"")+c),a},removeClassName:function(a,c){if(a=b(a))return a.className=a.className.replace(J(c)," ").strip(),a},toggleClassName:function(a,c,e){if(a=b(a))return Object.isUndefined(e)&&(e=!u(a,c)),(0,d[e?"addClassName":"removeClassName"])(a,c)}});var W;B.style.cssText="opacity:.55";W=/^0.55/.test(B.style.opacity);Object.extend(C,{setStyle:function(a,c){a=b(a);var e=a.style;if(Object.isString(c))return e.cssText+=";"+c,
c.include("opacity")&&(e=c.match(/opacity:\s*(\d?\.?\d*)/)[1],d.setOpacity(a,e)),a;for(var k in c)if("opacity"===k)d.setOpacity(a,c[k]);else{var j=c[k];if("float"===k||"cssFloat"===k)k=Object.isUndefined(e.styleFloat)?"cssFloat":"styleFloat";e[k]=j}return a},getStyle:function(a,c){a=b(a);c="float"===c||"styleFloat"===c?"cssFloat":c.camelize();var e=a.style[c];if(!e||"auto"===e)e=(e=document.defaultView.getComputedStyle(a,null))?e[c]:null;return"opacity"===c?e?parseFloat(e):1:"auto"===e?null:e},setOpacity:N,
getOpacity:k});"styleFloat"in B.style&&(C.getStyle=M,C.setOpacity=Q,C.getOpacity=I);a.Element.Storage={UID:1};var ba="uniqueID"in B;ba&&(O=Z);Object.extend(C,{getStorage:S,store:function(a,c,e){if(a=b(a)){var d=S(a);2===arguments.length?d.update(c):d.set(c,e);return a}},retrieve:function(a,c,e){if(a=b(a)){a=S(a);var d=a.get(c);Object.isUndefined(d)&&(a.set(c,e),d=e);return d}}});var ea={},R=d.Methods.ByTag,U=Prototype.BrowserFeatures;!U.ElementExtensions&&"__proto__"in B&&(a.HTMLElement={},a.HTMLElement.prototype=
B.__proto__,U.ElementExtensions=!0);"undefined"===typeof window.Element?x=!1:(x=window.Element.prototype)?(w="_"+(Math.random()+"").slice(2),A=document.createElement("object"),x[w]="x",A="x"!==A[w],delete x[w],x=A):x=!1;var X={};U.SpecificElementExtensions&&(r=x?p:Prototype.K);Object.extend(a.Element,{extend:r,addMethods:function(a){0===arguments.length&&(Object.extend(Form,Form.Methods),Object.extend(Form.Element,Form.Element.Methods),Object.extend(d.Methods.ByTag,{FORM:Object.clone(Form.Methods),
INPUT:Object.clone(Form.Element.Methods),SELECT:Object.clone(Form.Element.Methods),TEXTAREA:Object.clone(Form.Element.Methods),BUTTON:Object.clone(Form.Element.Methods)}));if(2===arguments.length){var c=a;a=arguments[1]}if(c)if(Object.isArray(c))for(var b=0,e;e=c[b];b++)ga(e,a);else ga(c,a);else Object.extend(d.Methods,a||{});c=window.HTMLElement?HTMLElement.prototype:d.prototype;U.ElementExtensions&&(fa(c,d.Methods),fa(c,d.Methods.Simulated,!0));if(U.SpecificElementExtensions)for(e in d.Methods.ByTag)c=
ka(e),Object.isUndefined(c)||fa(c.prototype,R[e]);Object.extend(d,d.Methods);Object.extend(d,d.Methods.Simulated);delete d.ByTag;delete d.Simulated;d.extend.refresh();V={}}});a.Element.extend.refresh=r===Prototype.K?Prototype.emptyFunction:function(){Prototype.BrowserFeatures.ElementExtensions||(Object.extend(ea,d.Methods),Object.extend(ea,d.Methods.Simulated),X={})};d.addMethods(C)})(this);
(function(){function a(a,b){a=$(a);var d=a.style[b];if(!d||"auto"===d)d=(d=document.defaultView.getComputedStyle(a,null))?d[b]:null;return"opacity"===b?d?parseFloat(d):1:"auto"===d?null:d}function b(a,b){var d=a.style[b];!d&&a.currentStyle&&(d=a.currentStyle[b]);return d}function d(a,b){var d=a.offsetWidth,g=f(a,"borderLeftWidth",b)||0,h=f(a,"borderRightWidth",b)||0,n=f(a,"paddingLeft",b)||0,l=f(a,"paddingRight",b)||0;return d-g-h-n-l}function f(c,b,d){var f=null;Object.isElement(c)&&(f=c,c=a(f,b));
if(null===c||Object.isUndefined(c))return null;if(/^(?:-)?\d+(\.\d+)?(px)?$/i.test(c))return window.parseFloat(c);var g=c.include("%"),h=d===document.viewport;return/\d/.test(c)&&f&&f.runtimeStyle&&(!g||!h)?(d=f.style.left,b=f.runtimeStyle.left,f.runtimeStyle.left=f.currentStyle.left,f.style.left=c||0,c=f.style.pixelLeft,f.style.left=d,f.runtimeStyle.left=b,c):f&&g?(d=d||f.parentNode,c=(c=c.match(/^(\d+)%?$/i))?Number(c[1])/100:null,f=null,g=b.include("left")||b.include("right")||b.include("width"),
b=b.include("top")||b.include("bottom")||b.include("height"),d===document.viewport?g?f=document.viewport.getWidth():b&&(f=document.viewport.getHeight()):g?f=$(d).measure("width"):b&&(f=$(d).measure("height")),null===f?0:f*c):0}function h(a){a=$(a);if(a.nodeType===Node.DOCUMENT_NODE||m(a)||"BODY"===a.nodeName.toUpperCase()||"HTML"===a.nodeName.toUpperCase())return $(document.body);if("inline"!==Element.getStyle(a,"display")&&a.offsetParent)return $(a.offsetParent);for(;(a=a.parentNode)&&a!==document.body;)if("static"!==
Element.getStyle(a,"position"))return"HTML"===a.nodeName.toUpperCase()?$(document.body):$(a);return $(document.body)}function g(a){a=$(a);var b=0,d=0;if(a.parentNode){do b+=a.offsetTop||0,d+=a.offsetLeft||0,a=a.offsetParent;while(a)}return new Element.Offset(d,b)}function n(a){a=$(a);var b=a.getLayout(),d=0,f=0;do if(d+=a.offsetTop||0,f+=a.offsetLeft||0,a=a.offsetParent){if("BODY"===a.nodeName.toUpperCase())break;if("static"!==Element.getStyle(a,"position"))break}while(a);f-=b.get("margin-top");d-=
b.get("margin-left");return new Element.Offset(f,d)}function m(a){return a!==document.body&&!Element.descendantOf(a,document.body)}"currentStyle"in document.documentElement&&(a=b);var l=Prototype.K;"currentStyle"in document.documentElement&&(l=function(a){a.currentStyle.hasLayout||(a.style.zoom=1);return a});Element.Layout=Class.create(Hash,{initialize:function($super,a,b){$super();this.element=$(a);Element.Layout.PROPERTIES.each(function(a){this._set(a,null)},this);b&&(this._preComputing=!0,this._begin(),
Element.Layout.PROPERTIES.each(this._compute,this),this._end(),this._preComputing=!1)},_set:function(a,b){return Hash.prototype.set.call(this,a,b)},set:function(){throw"Properties of Element.Layout are read-only.";},get:function($super,a){var b=$super(a);return null===b?this._compute(a):b},_begin:function(){if(!this._isPrepared()){var c=this.element,b;a:{for(b=c;b&&b.parentNode;){if("none"===b.getStyle("display")){b=!1;break a}b=$(b.parentNode)}b=!0}if(!b){c.store("prototype_original_styles",{position:c.style.position||
"",width:c.style.width||"",visibility:c.style.visibility||"",display:c.style.display||""});b=a(c,"position");var f=c.offsetWidth;if(0===f||null===f)c.style.display="block",f=c.offsetWidth;var g="fixed"===b?document.viewport:c.parentNode,h={visibility:"hidden",display:"block"};"fixed"!==b&&(h.position="absolute");c.setStyle(h);h=c.offsetWidth;b=f&&h===f?d(c,g):"absolute"===b||"fixed"===b?d(c,g):$(c.parentNode).getLayout().get("width")-this.get("margin-left")-this.get("border-left")-this.get("padding-left")-
this.get("padding-right")-this.get("border-right")-this.get("margin-right");c.setStyle({width:b+"px"})}this._setPrepared(!0)}},_end:function(){var a=this.element,b=a.retrieve("prototype_original_styles");a.store("prototype_original_styles",null);a.setStyle(b);this._setPrepared(!1)},_compute:function(a){var b=Element.Layout.COMPUTATIONS;if(!(a in b))throw"Property not found.";return this._set(a,b[a].call(this,this.element))},_isPrepared:function(){return this.element.retrieve("prototype_element_layout_prepared",
!1)},_setPrepared:function(a){return this.element.store("prototype_element_layout_prepared",a)},toObject:function(){var a=$A(arguments),b={};(0===a.length?Element.Layout.PROPERTIES:a.join(" ").split(" ")).each(function(a){if(Element.Layout.PROPERTIES.include(a)){var c=this.get(a);null!=c&&(b[a]=c)}},this);return b},toHash:function(){var a=this.toObject.apply(this,arguments);return new Hash(a)},toCSS:function(){var a=$A(arguments),b={};(0===a.length?Element.Layout.PROPERTIES:a.join(" ").split(" ")).each(function(a){if(Element.Layout.PROPERTIES.include(a)&&
!Element.Layout.COMPOSITE_PROPERTIES.include(a)){var c=this.get(a);if(null!=c){var d=b;a.include("border")&&(a+="-width");a=a.camelize();d[a]=c+"px"}}},this);return b},inspect:function(){return"#<Element.Layout>"}});Object.extend(Element.Layout,{PROPERTIES:$w("height width top left right bottom border-left border-right border-top border-bottom padding-left padding-right padding-top padding-bottom margin-top margin-bottom margin-left margin-right padding-box-width padding-box-height border-box-width border-box-height margin-box-width margin-box-height"),
COMPOSITE_PROPERTIES:$w("padding-box-width padding-box-height margin-box-width margin-box-height border-box-width border-box-height"),COMPUTATIONS:{height:function(){this._preComputing||this._begin();var a=this.get("border-box-height");if(0>=a)return this._preComputing||this._end(),0;var b=this.get("border-top"),d=this.get("border-bottom"),f=this.get("padding-top"),g=this.get("padding-bottom");this._preComputing||this._end();return a-b-d-f-g},width:function(){this._preComputing||this._begin();var a=
this.get("border-box-width");if(0>=a)return this._preComputing||this._end(),0;var b=this.get("border-left"),d=this.get("border-right"),f=this.get("padding-left"),g=this.get("padding-right");this._preComputing||this._end();return a-b-d-f-g},"padding-box-height":function(){var a=this.get("height"),b=this.get("padding-top"),d=this.get("padding-bottom");return a+b+d},"padding-box-width":function(){var a=this.get("width"),b=this.get("padding-left"),d=this.get("padding-right");return a+b+d},"border-box-height":function(a){this._preComputing||
this._begin();a=a.offsetHeight;this._preComputing||this._end();return a},"border-box-width":function(a){this._preComputing||this._begin();a=a.offsetWidth;this._preComputing||this._end();return a},"margin-box-height":function(){var a=this.get("border-box-height"),b=this.get("margin-top"),d=this.get("margin-bottom");return 0>=a?0:a+b+d},"margin-box-width":function(){var a=this.get("border-box-width"),b=this.get("margin-left"),d=this.get("margin-right");return 0>=a?0:a+b+d},top:function(a){return a.positionedOffset().top},
bottom:function(a){var b=a.positionedOffset();a=a.getOffsetParent().measure("height");var d=this.get("border-box-height");return a-d-b.top},left:function(a){return a.positionedOffset().left},right:function(a){var b=a.positionedOffset();a=a.getOffsetParent().measure("width");var d=this.get("border-box-width");return a-d-b.left},"padding-top":function(a){return f(a,"paddingTop")},"padding-bottom":function(a){return f(a,"paddingBottom")},"padding-left":function(a){return f(a,"paddingLeft")},"padding-right":function(a){return f(a,
"paddingRight")},"border-top":function(a){return f(a,"borderTopWidth")},"border-bottom":function(a){return f(a,"borderBottomWidth")},"border-left":function(a){return f(a,"borderLeftWidth")},"border-right":function(a){return f(a,"borderRightWidth")},"margin-top":function(a){return f(a,"marginTop")},"margin-bottom":function(a){return f(a,"marginBottom")},"margin-left":function(a){return f(a,"marginLeft")},"margin-right":function(a){return f(a,"marginRight")}}});"getBoundingClientRect"in document.documentElement&&
Object.extend(Element.Layout.COMPUTATIONS,{right:function(a){var b=l(a.getOffsetParent());a=a.getBoundingClientRect();return(b.getBoundingClientRect().right-a.right).round()},bottom:function(a){var b=l(a.getOffsetParent());a=a.getBoundingClientRect();return(b.getBoundingClientRect().bottom-a.bottom).round()}});Element.Offset=Class.create({initialize:function(a,b){this.left=a.round();this.top=b.round();this[0]=this.left;this[1]=this.top},relativeTo:function(a){return new Element.Offset(this.left-a.left,
this.top-a.top)},inspect:function(){return"#<Element.Offset left: #{left} top: #{top}>".interpolate(this)},toString:function(){return"[#{left}, #{top}]".interpolate(this)},toArray:function(){return[this.left,this.top]}});Prototype.Browser.IE?(h=h.wrap(function(a,b){b=$(b);if(b.nodeType===Node.DOCUMENT_NODE||m(b)||"BODY"===b.nodeName.toUpperCase()||"HTML"===b.nodeName.toUpperCase())return $(document.body);var d=b.getStyle("position");if("static"!==d)return a(b);b.setStyle({position:"relative"});var f=
a(b);b.setStyle({position:d});return f}),n=n.wrap(function(a,b){b=$(b);if(!b.parentNode)return new Element.Offset(0,0);var d=b.getStyle("position");if("static"!==d)return a(b);var f=b.getOffsetParent();f&&"fixed"===f.getStyle("position")&&l(f);b.setStyle({position:"relative"});f=a(b);b.setStyle({position:d});return f})):Prototype.Browser.Webkit&&(g=function(a){a=$(a);var b=0,d=0;do{b+=a.offsetTop||0;d+=a.offsetLeft||0;if(a.offsetParent==document.body&&"absolute"==Element.getStyle(a,"position"))break;
a=a.offsetParent}while(a);return new Element.Offset(d,b)});Element.addMethods({getLayout:function(a,b){return new Element.Layout(a,b)},measure:function(a,b){return $(a).getLayout().get(b)},getWidth:function(a){return Element.getDimensions(a).width},getHeight:function(a){return Element.getDimensions(a).height},getDimensions:function(a){a=$(a);var b=Element.getStyle(a,"display");if(b&&"none"!==b)return{width:a.offsetWidth,height:a.offsetHeight};var b=a.style,b={visibility:b.visibility,position:b.position,
display:b.display},d={visibility:"hidden",display:"block"};"fixed"!==b.position&&(d.position="absolute");Element.setStyle(a,d);d={width:a.offsetWidth,height:a.offsetHeight};Element.setStyle(a,b);return d},getOffsetParent:h,cumulativeOffset:g,positionedOffset:n,cumulativeScrollOffset:function(a){var b=0,d=0;do b+=a.scrollTop||0,d+=a.scrollLeft||0,a=a.parentNode;while(a);return new Element.Offset(d,b)},viewportOffset:function(a){var b=0,d=0,f=document.body,g=$(a);do if(b+=g.offsetTop||0,d+=g.offsetLeft||
0,g.offsetParent==f&&"absolute"==Element.getStyle(g,"position"))break;while(g=g.offsetParent);g=a;do g!=f&&(b-=g.scrollTop||0,d-=g.scrollLeft||0);while(g=g.parentNode);return new Element.Offset(d,b)},absolutize:function(a){a=$(a);if("absolute"===Element.getStyle(a,"position"))return a;var b=h(a),d=a.viewportOffset(),b=b.viewportOffset(),d=d.relativeTo(b),b=a.getLayout();a.store("prototype_absolutize_original_styles",{left:a.getStyle("left"),top:a.getStyle("top"),width:a.getStyle("width"),height:a.getStyle("height")});
a.setStyle({position:"absolute",top:d.top+"px",left:d.left+"px",width:b.get("width")+"px",height:b.get("height")+"px"});return a},relativize:function(a){a=$(a);if("relative"===Element.getStyle(a,"position"))return a;var b=a.retrieve("prototype_absolutize_original_styles");b&&a.setStyle(b);return a},scrollTo:function(a){a=$(a);var b=Element.cumulativeOffset(a);window.scrollTo(b.left,b.top);return a},makePositioned:function(a){a=$(a);var b=Element.getStyle(a,"position"),d={};if("static"===b||!b)d.position=
"relative",Prototype.Browser.Opera&&(d.top=0,d.left=0),Element.setStyle(a,d),Element.store(a,"prototype_made_positioned",!0);return a},undoPositioned:function(a){a=$(a);var b=Element.getStorage(a);b.get("prototype_made_positioned")&&(b.unset("prototype_made_positioned"),Element.setStyle(a,{position:"",top:"",bottom:"",left:"",right:""}));return a},makeClipping:function(a){a=$(a);var b=Element.getStorage(a),d=b.get("prototype_made_clipping");Object.isUndefined(d)&&(d=Element.getStyle(a,"overflow"),
b.set("prototype_made_clipping",d),"hidden"!==d&&(a.style.overflow="hidden"));return a},undoClipping:function(a){a=$(a);var b=Element.getStorage(a),d=b.get("prototype_made_clipping");Object.isUndefined(d)||(b.unset("prototype_made_clipping"),a.style.overflow=d||"");return a},clonePosition:function(a,b,d){d=Object.extend({setLeft:!0,setTop:!0,setWidth:!0,setHeight:!0,offsetTop:0,offsetLeft:0},d||{});b=$(b);a=$(a);var f,g,h,n={};if(d.setLeft||d.setTop)if(f=Element.viewportOffset(b),g=[0,0],"absolute"===
Element.getStyle(a,"position")){var l=Element.getOffsetParent(a);l!==document.body&&(g=Element.viewportOffset(l))}if(d.setWidth||d.setHeight)h=Element.getLayout(b);d.setLeft&&(n.left=f[0]-g[0]+d.offsetLeft+"px");d.setTop&&(n.top=f[1]-g[1]+d.offsetTop+"px");d.setWidth&&(n.width=h.get("border-box-width")+"px");d.setHeight&&(n.height=h.get("border-box-height")+"px");return Element.setStyle(a,n)}});"getBoundingClientRect"in document.documentElement&&Element.addMethods({viewportOffset:function(a){a=$(a);
if(m(a))return new Element.Offset(0,0);a=a.getBoundingClientRect();var b=document.documentElement;return new Element.Offset(a.left-b.clientLeft,a.top-b.clientTop)}})})();
(function(){function a(){return d?d:d=b?document.body:document.documentElement}var b=Prototype.Browser.Opera&&9.5>window.parseFloat(window.opera.version()),d=null;document.viewport={getDimensions:function(){return{width:this.getWidth(),height:this.getHeight()}},getWidth:function(){return a().clientWidth},getHeight:function(){return a().clientHeight},getScrollOffsets:function(){return new Element.Offset(window.pageXOffset||document.documentElement.scrollLeft||document.body.scrollLeft,window.pageYOffset||
document.documentElement.scrollTop||document.body.scrollTop)}}})();window.$$=function(){var a=$A(arguments).join(", ");return Prototype.Selector.select(a,document)};
Prototype.Selector=function(){function a(a){for(var b=0,h=a.length;b<h;b++)Element.extend(a[b]);return a}var b=Prototype.K;return{select:function(){throw Error('Method "Prototype.Selector.select" must be defined.');},match:function(){throw Error('Method "Prototype.Selector.match" must be defined.');},find:function(a,b,h){h=h||0;var g=Prototype.Selector.match,n=a.length,m=0,l;for(l=0;l<n;l++)if(g(a[l],b)&&h==m++)return Element.extend(a[l])},extendElements:Element.extend===b?b:a,extendElement:Element.extend}}();
(function(){function a(a,b,c,d,e,j){e=0;for(var f=d.length;e<f;e++){var p=d[e];if(p){for(var g=!1,p=p[a];p;){if(p.sizcache===c){g=d[p.sizset];break}1===p.nodeType&&!j&&(p.sizcache=c,p.sizset=e);if(p.nodeName.toLowerCase()===b){g=p;break}p=p[a]}d[e]=g}}}function b(a,b,d,e,f,j){f=0;for(var r=e.length;f<r;f++){var p=e[f];if(p){for(var g=!1,p=p[a];p;){if(p.sizcache===d){g=e[p.sizset];break}if(1===p.nodeType)if(j||(p.sizcache=d,p.sizset=f),"string"!==typeof b){if(p===b){g=!0;break}}else if(0<c.filter(b,
[p]).length){g=p;break}p=p[a]}e[f]=g}}}var d=/((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g,f=0,h=Object.prototype.toString,g=!1,n=!0,m=/\\/g,l=/\W/;[0,0].sort(function(){n=!1;return 0});var c=function(a,b,f,g){f=f||[];var n=b=b||document;if(1!==b.nodeType&&9!==b.nodeType)return[];if(!a||"string"!==typeof a)return f;var j,r,p,l,m,s=!0,t=c.isXML(b),v=[],u=a;do if(d.exec(""),j=d.exec(u))if(u=j[3],v.push(j[1]),j[2]){l=
j[3];break}while(j);if(1<v.length&&q.exec(a))if(2===v.length&&e.relative[v[0]])r=Q(v[0]+v[1],b);else for(r=e.relative[v[0]]?[b]:c(v.shift(),b);v.length;)a=v.shift(),e.relative[a]&&(a+=v.shift()),r=Q(a,r);else if(!g&&(1<v.length&&9===b.nodeType&&!t&&e.match.ID.test(v[0])&&!e.match.ID.test(v[v.length-1]))&&(j=c.find(v.shift(),b,t),b=j.expr?c.filter(j.expr,j.set)[0]:j.set[0]),b){j=g?{expr:v.pop(),set:z(g)}:c.find(v.pop(),1===v.length&&("~"===v[0]||"+"===v[0])&&b.parentNode?b.parentNode:b,t);r=j.expr?
c.filter(j.expr,j.set):j.set;for(0<v.length?p=z(r):s=!1;v.length;)j=m=v.pop(),e.relative[m]?j=v.pop():m="",null==j&&(j=b),e.relative[m](p,j,t)}else p=[];p||(p=r);p||c.error(m||a);if("[object Array]"===h.call(p))if(s)if(b&&1===b.nodeType)for(a=0;null!=p[a];a++)p[a]&&(!0===p[a]||1===p[a].nodeType&&c.contains(b,p[a]))&&f.push(r[a]);else for(a=0;null!=p[a];a++)p[a]&&1===p[a].nodeType&&f.push(r[a]);else f.push.apply(f,p);else z(p,f);l&&(c(l,n,f,g),c.uniqueSort(f));return f};c.uniqueSort=function(a){if(H&&
(g=n,a.sort(H),g))for(var b=1;b<a.length;b++)a[b]===a[b-1]&&a.splice(b--,1);return a};c.matches=function(a,b){return c(a,null,null,b)};c.matchesSelector=function(a,b){return 0<c(b,null,null,[a]).length};c.find=function(a,b,c){var d;if(!a)return[];for(var f=0,j=e.order.length;f<j;f++){var g,p=e.order[f];if(g=e.leftMatch[p].exec(a)){var h=g[1];g.splice(1,1);if("\\"!==h.substr(h.length-1)&&(g[1]=(g[1]||"").replace(m,""),d=e.find[p](g,b,c),null!=d)){a=a.replace(e.match[p],"");break}}}d||(d="undefined"!==
typeof b.getElementsByTagName?b.getElementsByTagName("*"):[]);return{set:d,expr:a}};c.filter=function(a,b,d,f){for(var g,j,r=a,p=[],h=b,n=b&&b[0]&&c.isXML(b[0]);a&&b.length;){for(var l in e.filter)if(null!=(g=e.leftMatch[l].exec(a))&&g[2]){var m,q,t=e.filter[l];q=g[1];j=!1;g.splice(1,1);if("\\"!==q.substr(q.length-1)){h===p&&(p=[]);if(e.preFilter[l])if(g=e.preFilter[l](g,h,d,p,f,n)){if(!0===g)continue}else j=m=!0;if(g)for(var s=0;null!=(q=h[s]);s++)if(q){m=t(q,g,s,h);var u=f^!!m;d&&null!=m?u?j=!0:
h[s]=!1:u&&(p.push(q),j=!0)}if(void 0!==m){d||(h=p);a=a.replace(e.match[l],"");if(!j)return[];break}}}if(a===r)if(null==j)c.error(a);else break;r=a}return h};c.error=function(a){throw"Syntax error, unrecognized expression: "+a;};var e=c.selectors={order:["ID","NAME","TAG"],match:{ID:/#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,CLASS:/\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,NAME:/\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/,ATTR:/\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(?:(['"])(.*?)\3|(#?(?:[\w\u00c0-\uFFFF\-]|\\.)*)|)|)\s*\]/,
TAG:/^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/,CHILD:/:(only|nth|last|first)-child(?:\(\s*(even|odd|(?:[+\-]?\d+|(?:[+\-]?\d*)?n\s*(?:[+\-]\s*\d+)?))\s*\))?/,POS:/:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/,PSEUDO:/:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/},leftMatch:{},attrMap:{"class":"className","for":"htmlFor"},attrHandle:{href:function(a){return a.getAttribute("href")},type:function(a){return a.getAttribute("type")}},relative:{"+":function(a,b){var d=
"string"===typeof b,e=d&&!l.test(b),d=d&&!e;e&&(b=b.toLowerCase());for(var e=0,f=a.length,j;e<f;e++)if(j=a[e]){for(;(j=j.previousSibling)&&1!==j.nodeType;);a[e]=d||j&&j.nodeName.toLowerCase()===b?j||!1:j===b}d&&c.filter(b,a,!0)},">":function(a,b){var d,e="string"===typeof b,f=0,j=a.length;if(e&&!l.test(b))for(b=b.toLowerCase();f<j;f++){if(d=a[f])d=d.parentNode,a[f]=d.nodeName.toLowerCase()===b?d:!1}else{for(;f<j;f++)(d=a[f])&&(a[f]=e?d.parentNode:d.parentNode===b);e&&c.filter(b,a,!0)}},"":function(c,
d,e){var g,h=f++,j=b;"string"===typeof d&&!l.test(d)&&(g=d=d.toLowerCase(),j=a);j("parentNode",d,h,c,g,e)},"~":function(c,d,e){var g,h=f++,j=b;"string"===typeof d&&!l.test(d)&&(g=d=d.toLowerCase(),j=a);j("previousSibling",d,h,c,g,e)}},find:{ID:function(a,b,c){if("undefined"!==typeof b.getElementById&&!c)return(a=b.getElementById(a[1]))&&a.parentNode?[a]:[]},NAME:function(a,b){if("undefined"!==typeof b.getElementsByName){for(var c=[],d=b.getElementsByName(a[1]),e=0,j=d.length;e<j;e++)d[e].getAttribute("name")===
a[1]&&c.push(d[e]);return 0===c.length?null:c}},TAG:function(a,b){if("undefined"!==typeof b.getElementsByTagName)return b.getElementsByTagName(a[1])}},preFilter:{CLASS:function(a,b,c,d,e,j){a=" "+a[1].replace(m,"")+" ";if(j)return a;j=0;for(var f;null!=(f=b[j]);j++)f&&(e^(f.className&&0<=(" "+f.className+" ").replace(/[\t\n\r]/g," ").indexOf(a))?c||d.push(f):c&&(b[j]=!1));return!1},ID:function(a){return a[1].replace(m,"")},TAG:function(a){return a[1].replace(m,"").toLowerCase()},CHILD:function(a){if("nth"===
a[1]){a[2]||c.error(a[0]);a[2]=a[2].replace(/^\+|\s*/g,"");var b=/(-?)(\d*)(?:n([+\-]?\d*))?/.exec("even"===a[2]&&"2n"||"odd"===a[2]&&"2n+1"||!/\D/.test(a[2])&&"0n+"+a[2]||a[2]);a[2]=b[1]+(b[2]||1)-0;a[3]=b[3]-0}else a[2]&&c.error(a[0]);a[0]=f++;return a},ATTR:function(a,b,c,d,f,j){b=a[1]=a[1].replace(m,"");!j&&e.attrMap[b]&&(a[1]=e.attrMap[b]);a[4]=(a[4]||a[5]||"").replace(m,"");"~="===a[2]&&(a[4]=" "+a[4]+" ");return a},PSEUDO:function(a,b,f,g,h){if("not"===a[1])if(1<(d.exec(a[3])||"").length||
/^\w/.test(a[3]))a[3]=c(a[3],null,null,b);else return a=c.filter(a[3],b,f,1^h),f||g.push.apply(g,a),!1;else if(e.match.POS.test(a[0])||e.match.CHILD.test(a[0]))return!0;return a},POS:function(a){a.unshift(!0);return a}},filters:{enabled:function(a){return!1===a.disabled&&"hidden"!==a.type},disabled:function(a){return!0===a.disabled},checked:function(a){return!0===a.checked},selected:function(a){a.parentNode&&a.parentNode.selectedIndex;return!0===a.selected},parent:function(a){return!!a.firstChild},
empty:function(a){return!a.firstChild},has:function(a,b,d){return!!c(d[3],a).length},header:function(a){return/h\d/i.test(a.nodeName)},text:function(a){var b=a.getAttribute("type"),c=a.type;return"input"===a.nodeName.toLowerCase()&&"text"===c&&(b===c||null===b)},radio:function(a){return"input"===a.nodeName.toLowerCase()&&"radio"===a.type},checkbox:function(a){return"input"===a.nodeName.toLowerCase()&&"checkbox"===a.type},file:function(a){return"input"===a.nodeName.toLowerCase()&&"file"===a.type},
password:function(a){return"input"===a.nodeName.toLowerCase()&&"password"===a.type},submit:function(a){var b=a.nodeName.toLowerCase();return("input"===b||"button"===b)&&"submit"===a.type},image:function(a){return"input"===a.nodeName.toLowerCase()&&"image"===a.type},reset:function(a){var b=a.nodeName.toLowerCase();return("input"===b||"button"===b)&&"reset"===a.type},button:function(a){var b=a.nodeName.toLowerCase();return"input"===b&&"button"===a.type||"button"===b},input:function(a){return/input|select|textarea|button/i.test(a.nodeName)},
focus:function(a){return a===a.ownerDocument.activeElement}},setFilters:{first:function(a,b){return 0===b},last:function(a,b,c,d){return b===d.length-1},even:function(a,b){return 0===b%2},odd:function(a,b){return 1===b%2},lt:function(a,b,c){return b<c[3]-0},gt:function(a,b,c){return b>c[3]-0},nth:function(a,b,c){return c[3]-0===b},eq:function(a,b,c){return c[3]-0===b}},filter:{PSEUDO:function(a,b,d,f){var g=b[1],j=e.filters[g];if(j)return j(a,d,b,f);if("contains"===g)return 0<=(a.textContent||a.innerText||
c.getText([a])||"").indexOf(b[3]);if("not"===g){b=b[3];d=0;for(f=b.length;d<f;d++)if(b[d]===a)return!1;return!0}c.error(g)},CHILD:function(a,b){var c=b[1],d=a;switch(c){case "only":case "first":for(;d=d.previousSibling;)if(1===d.nodeType)return!1;if("first"===c)return!0;d=a;case "last":for(;d=d.nextSibling;)if(1===d.nodeType)return!1;return!0;case "nth":var c=b[2],e=b[3];if(1===c&&0===e)return!0;var f=b[0],g=a.parentNode;if(g&&(g.sizcache!==f||!a.nodeIndex)){for(var p=0,d=g.firstChild;d;d=d.nextSibling)1===
d.nodeType&&(d.nodeIndex=++p);g.sizcache=f}d=a.nodeIndex-e;return 0===c?0===d:0===d%c&&0<=d/c}},ID:function(a,b){return 1===a.nodeType&&a.getAttribute("id")===b},TAG:function(a,b){return"*"===b&&1===a.nodeType||a.nodeName.toLowerCase()===b},CLASS:function(a,b){return-1<(" "+(a.className||a.getAttribute("class"))+" ").indexOf(b)},ATTR:function(a,b){var c=b[1],c=e.attrHandle[c]?e.attrHandle[c](a):null!=a[c]?a[c]:a.getAttribute(c),d=c+"",f=b[2],j=b[4];return null==c?"!="===f:"="===f?d===j:"*="===f?0<=
d.indexOf(j):"~="===f?0<=(" "+d+" ").indexOf(j):!j?d&&!1!==c:"!="===f?d!==j:"^="===f?0===d.indexOf(j):"$="===f?d.substr(d.length-j.length)===j:"|="===f?d===j||d.substr(0,j.length+1)===j+"-":!1},POS:function(a,b,c,d){var f=e.setFilters[b[2]];if(f)return f(a,c,b,d)}}},q=e.match.POS,s=function(a,b){return"\\"+(b-0+1)},y;for(y in e.match)e.match[y]=RegExp(e.match[y].source+/(?![^\[]*\])(?![^\(]*\))/.source),e.leftMatch[y]=RegExp(/(^(?:.|\r|\n)*?)/.source+e.match[y].source.replace(/\\(\d+)/g,s));var z=
function(a,b){a=Array.prototype.slice.call(a,0);return b?(b.push.apply(b,a),b):a};try{Array.prototype.slice.call(document.documentElement.childNodes,0)[0].nodeType}catch(L){z=function(a,b){var c=0,d=b||[];if("[object Array]"===h.call(a))Array.prototype.push.apply(d,a);else if("number"===typeof a.length)for(var e=a.length;c<e;c++)d.push(a[c]);else for(;a[c];c++)d.push(a[c]);return d}}var H,G;document.documentElement.compareDocumentPosition?H=function(a,b){return a===b?(g=!0,0):!a.compareDocumentPosition||
!b.compareDocumentPosition?a.compareDocumentPosition?-1:1:a.compareDocumentPosition(b)&4?-1:1}:(H=function(a,b){if(a===b)return g=!0,0;if(a.sourceIndex&&b.sourceIndex)return a.sourceIndex-b.sourceIndex;var c,d,e=[],f=[];c=a.parentNode;d=b.parentNode;var r=c;if(c===d)return G(a,b);if(c){if(!d)return 1}else return-1;for(;r;)e.unshift(r),r=r.parentNode;for(r=d;r;)f.unshift(r),r=r.parentNode;c=e.length;d=f.length;for(r=0;r<c&&r<d;r++)if(e[r]!==f[r])return G(e[r],f[r]);return r===c?G(a,f[r],-1):G(e[r],
b,1)},G=function(a,b,c){if(a===b)return c;for(a=a.nextSibling;a;){if(a===b)return-1;a=a.nextSibling}return 1});c.getText=function(a){for(var b="",d,e=0;a[e];e++)d=a[e],3===d.nodeType||4===d.nodeType?b+=d.nodeValue:8!==d.nodeType&&(b+=c.getText(d.childNodes));return b};s=document.createElement("div");y="script"+(new Date).getTime();var F=document.documentElement;s.innerHTML="<a name='"+y+"'/>";F.insertBefore(s,F.firstChild);document.getElementById(y)&&(e.find.ID=function(a,b,c){if("undefined"!==typeof b.getElementById&&
!c)return(b=b.getElementById(a[1]))?b.id===a[1]||"undefined"!==typeof b.getAttributeNode&&b.getAttributeNode("id").nodeValue===a[1]?[b]:void 0:[]},e.filter.ID=function(a,b){var c="undefined"!==typeof a.getAttributeNode&&a.getAttributeNode("id");return 1===a.nodeType&&c&&c.nodeValue===b});F.removeChild(s);F=s=null;s=document.createElement("div");s.appendChild(document.createComment(""));0<s.getElementsByTagName("*").length&&(e.find.TAG=function(a,b){var c=b.getElementsByTagName(a[1]);if("*"===a[1]){for(var d=
[],e=0;c[e];e++)1===c[e].nodeType&&d.push(c[e]);c=d}return c});s.innerHTML="<a href='#'></a>";s.firstChild&&("undefined"!==typeof s.firstChild.getAttribute&&"#"!==s.firstChild.getAttribute("href"))&&(e.attrHandle.href=function(a){return a.getAttribute("href",2)});s=null;if(document.querySelectorAll){var J=c,s=document.createElement("div");s.innerHTML="<p class='TEST'></p>";if(!(s.querySelectorAll&&0===s.querySelectorAll(".TEST").length)){var c=function(a,b,d,f){b=b||document;if(!f&&!c.isXML(b)){var g=
/^(\w+$)|^\.([\w\-]+$)|^#([\w\-]+$)/.exec(a);if(g&&(1===b.nodeType||9===b.nodeType)){if(g[1])return z(b.getElementsByTagName(a),d);if(g[2]&&e.find.CLASS&&b.getElementsByClassName)return z(b.getElementsByClassName(g[2]),d)}if(9===b.nodeType){if("body"===a&&b.body)return z([b.body],d);if(g&&g[3]){var j=b.getElementById(g[3]);if(j&&j.parentNode){if(j.id===g[3])return z([j],d)}else return z([],d)}try{return z(b.querySelectorAll(a),d)}catch(r){}}else if(1===b.nodeType&&"object"!==b.nodeName.toLowerCase()){var g=
b,p=(j=b.getAttribute("id"))||"__sizzle__",h=b.parentNode,l=/^\s*[+~]/.test(a);j?p=p.replace(/'/g,"\\$&"):b.setAttribute("id",p);l&&h&&(b=b.parentNode);try{if(!l||h)return z(b.querySelectorAll("[id='"+p+"'] "+a),d)}catch(n){}finally{j||g.removeAttribute("id")}}}return J(a,b,d,f)},u;for(u in J)c[u]=J[u];s=null}}u=document.documentElement;var E=u.matchesSelector||u.mozMatchesSelector||u.webkitMatchesSelector||u.msMatchesSelector;if(E){var t=!E.call(document.createElement("div"),"div"),M=!1;try{E.call(document.documentElement,
"[test!='']:sizzle")}catch(N){M=!0}c.matchesSelector=function(a,b){b=b.replace(/\=\s*([^'"\]]*)\s*\]/g,"='$1']");if(!c.isXML(a))try{if(M||!e.match.PSEUDO.test(b)&&!/!=/.test(b)){var d=E.call(a,b);if(d||!t||a.document&&11!==a.document.nodeType)return d}}catch(f){}return 0<c(b,null,null,[a]).length}}u=document.createElement("div");u.innerHTML="<div class='test e'></div><div class='test'></div>";u.getElementsByClassName&&0!==u.getElementsByClassName("e").length&&(u.lastChild.className="e",1!==u.getElementsByClassName("e").length&&
(e.order.splice(1,0,"CLASS"),e.find.CLASS=function(a,b,c){if("undefined"!==typeof b.getElementsByClassName&&!c)return b.getElementsByClassName(a[1])},u=null));c.contains=document.documentElement.contains?function(a,b){return a!==b&&(a.contains?a.contains(b):!0)}:document.documentElement.compareDocumentPosition?function(a,b){return!!(a.compareDocumentPosition(b)&16)}:function(){return!1};c.isXML=function(a){return(a=(a?a.ownerDocument||a:0).documentElement)?"HTML"!==a.nodeName:!1};var Q=function(a,
b){for(var d,f=[],g="",j=b.nodeType?[b]:b;d=e.match.PSEUDO.exec(a);)g+=d[0],a=a.replace(e.match.PSEUDO,"");a=e.relative[a]?a+"*":a;d=0;for(var r=j.length;d<r;d++)c(a,j[d],f);return c.filter(g,f)};window.Sizzle=c})();Prototype._original_property=window.Sizzle;(function(a){var b=Prototype.Selector.extendElements;Prototype.Selector.engine=a;Prototype.Selector.select=function(d,f){return b(a(d,f||document))};Prototype.Selector.match=function(b,f){return 1==a.matches(f,[b]).length}})(Sizzle);
window.Sizzle=Prototype._original_property;delete Prototype._original_property;
var Form={reset:function(a){a=$(a);a.reset();return a},serializeElements:function(a,b){"object"!=typeof b?b={hash:!!b}:Object.isUndefined(b.hash)&&(b.hash=!0);var d,f,h=!1,g=b.submit,n,m;b.hash?(m={},n=function(a,b,d){b in a?(Object.isArray(a[b])||(a[b]=[a[b]]),a[b].push(d)):a[b]=d;return a}):(m="",n=function(a,b,d){d=d.gsub(/(\r)?\n/,"\r\n");d=encodeURIComponent(d);d=d.gsub(/%20/,"+");return a+(a?"&":"")+encodeURIComponent(b)+"="+d});return a.inject(m,function(a,b){if(!b.disabled&&b.name&&(d=b.name,
f=$(b).getValue(),null!=f&&"file"!=b.type&&("submit"!=b.type||!h&&!1!==g&&(!g||d==g)&&(h=!0))))a=n(a,d,f);return a})},Methods:{serialize:function(a,b){return Form.serializeElements(Form.getElements(a),b)},getElements:function(a){a=$(a).getElementsByTagName("*");for(var b,d=[],f=Form.Element.Serializers,h=0;b=a[h];h++)f[b.tagName.toLowerCase()]&&d.push(Element.extend(b));return d},getInputs:function(a,b,d){a=$(a);a=a.getElementsByTagName("input");if(!b&&!d)return $A(a).map(Element.extend);for(var f=
0,h=[],g=a.length;f<g;f++){var n=a[f];b&&n.type!=b||d&&n.name!=d||h.push(Element.extend(n))}return h},disable:function(a){a=$(a);Form.getElements(a).invoke("disable");return a},enable:function(a){a=$(a);Form.getElements(a).invoke("enable");return a},findFirstElement:function(a){a=$(a).getElements().findAll(function(a){return"hidden"!=a.type&&!a.disabled});var b=a.findAll(function(a){return a.hasAttribute("tabIndex")&&0<=a.tabIndex}).sortBy(function(a){return a.tabIndex}).first();return b?b:a.find(function(a){return/^(?:input|select|textarea)$/i.test(a.tagName)})},
focusFirstElement:function(a){a=$(a);var b=a.findFirstElement();b&&b.activate();return a},request:function(a,b){a=$(a);b=Object.clone(b||{});var d=b.parameters,f=a.readAttribute("action")||"";f.blank()&&(f=window.location.href);b.parameters=a.serialize(!0);d&&(Object.isString(d)&&(d=d.toQueryParams()),Object.extend(b.parameters,d));a.hasAttribute("method")&&!b.method&&(b.method=a.method);return new Ajax.Request(f,b)}},Element:{focus:function(a){$(a).focus();return a},select:function(a){$(a).select();
return a}}};
Form.Element.Methods={serialize:function(a){a=$(a);if(!a.disabled&&a.name){var b=a.getValue();if(void 0!=b){var d={};d[a.name]=b;return Object.toQueryString(d)}}return""},getValue:function(a){a=$(a);var b=a.tagName.toLowerCase();return Form.Element.Serializers[b](a)},setValue:function(a,b){a=$(a);var d=a.tagName.toLowerCase();Form.Element.Serializers[d](a,b);return a},clear:function(a){$(a).value="";return a},present:function(a){return""!=$(a).value},activate:function(a){a=$(a);try{a.focus(),a.select&&
("input"!=a.tagName.toLowerCase()||!/^(?:button|reset|submit)$/i.test(a.type))&&a.select()}catch(b){}return a},disable:function(a){a=$(a);a.disabled=!0;return a},enable:function(a){a=$(a);a.disabled=!1;return a}};var Field=Form.Element,$F=Form.Element.Methods.getValue;
Form.Element.Serializers=function(){function a(a,b){if(Object.isUndefined(b))return a.checked?a.value:null;a.checked=!!b}function b(a,b){if(Object.isUndefined(b))return a.value;a.value=b}function d(a){var b=a.selectedIndex;return 0<=b?h(a.options[b]):null}function f(a){var b,d=a.length;if(!d)return null;var f=0;for(b=[];f<d;f++){var c=a.options[f];c.selected&&b.push(h(c))}return b}function h(a){return Element.hasAttribute(a,"value")?a.value:a.text}return{input:function(d,f){switch(d.type.toLowerCase()){case "checkbox":case "radio":return a(d,
f);default:return b(d,f)}},inputSelector:a,textarea:b,select:function(a,b){if(Object.isUndefined(b))return("select-one"===a.type?d:f)(a);for(var h,l,c=!Object.isArray(b),e=0,q=a.length;e<q;e++)if(h=a.options[e],l=this.optionValue(h),c){if(l==b){h.selected=!0;break}}else h.selected=b.include(l)},selectOne:d,selectMany:f,optionValue:h,button:b}}();
Abstract.TimedObserver=Class.create(PeriodicalExecuter,{initialize:function($super,b,d,f){$super(f,d);this.element=$(b);this.lastValue=this.getValue()},execute:function(){var a=this.getValue();if(Object.isString(this.lastValue)&&Object.isString(a)?this.lastValue!=a:String(this.lastValue)!=String(a))this.callback(this.element,a),this.lastValue=a}});Form.Element.Observer=Class.create(Abstract.TimedObserver,{getValue:function(){return Form.Element.getValue(this.element)}});
Form.Observer=Class.create(Abstract.TimedObserver,{getValue:function(){return Form.serialize(this.element)}});
Abstract.EventObserver=Class.create({initialize:function(a,b){this.element=$(a);this.callback=b;this.lastValue=this.getValue();"form"==this.element.tagName.toLowerCase()?this.registerFormCallbacks():this.registerCallback(this.element)},onElementEvent:function(){var a=this.getValue();this.lastValue!=a&&(this.callback(this.element,a),this.lastValue=a)},registerFormCallbacks:function(){Form.getElements(this.element).each(this.registerCallback,this)},registerCallback:function(a){if(a.type)switch(a.type.toLowerCase()){case "checkbox":case "radio":Event.observe(a,
"click",this.onElementEvent.bind(this));break;default:Event.observe(a,"change",this.onElementEvent.bind(this))}}});Form.Element.EventObserver=Class.create(Abstract.EventObserver,{getValue:function(){return Form.Element.getValue(this.element)}});Form.EventObserver=Class.create(Abstract.EventObserver,{getValue:function(){return Form.serialize(this.element)}});
(function(a){function b(a,b){return a.which?a.which===b+1:a.button===b}function d(a,b){return a.button===Q[b]}function f(a,b){switch(b){case 0:return 1==a.which&&!a.metaKey;case 1:return 2==a.which||1==a.which&&a.metaKey;case 2:return 3==a.which;default:return!1}}function h(a){a=t.extend(a);var b=a.target,c=a.type;if((a=a.currentTarget)&&a.tagName&&("load"===c||"error"===c||"click"===c&&"input"===a.tagName.toLowerCase()&&"radio"===a.type))b=a;b.nodeType==Node.TEXT_NODE&&(b=b.parentNode);return Element.extend(b)}
function g(a){var b=document.documentElement,c=document.body||{scrollLeft:0};return a.pageX||a.clientX+(b.scrollLeft||c.scrollLeft)-(b.clientLeft||0)}function n(a){var b=document.documentElement,c=document.body||{scrollTop:0};return a.pageY||a.clientY+(b.scrollTop||c.scrollTop)-(b.clientTop||0)}function m(a){return Z[a]||a}function l(a){if(a===window)return 0;"undefined"===typeof a._prototypeUID&&(a._prototypeUID=Element.Storage.UID++);return a._prototypeUID}function c(a){return a===window?0:a==document?
1:a.uniqueID}function e(a){return a.include(":")}function q(b,c){var d=a.Event.cache;Object.isUndefined(c)&&(c=l(b));d[c]||(d[c]={element:b});return d[c]}function s(b,c,d){b=$(b);a:{var f=b,g=q(f);g[c]||(g[c]=[]);for(var g=g[c],h=g.length;h--;)if(g[h].handler===d){d=null;break a}f=l(f);d={responder:a.Event._createResponder(f,c,d),handler:d};g.push(d)}if(null===d)return b;d=d.responder;e(c)?(c=b,c.addEventListener?c.addEventListener("dataavailable",d,!1):(c.attachEvent("ondataavailable",d),c.attachEvent("onlosecapture",
d))):(g=b,c=m(c),g.addEventListener?g.addEventListener(c,d,!1):g.attachEvent("on"+c,d));return b}function y(b,c,d){b=$(b);var e=!Object.isUndefined(d);if(Object.isUndefined(c)&&!e){c=b;d=l(c);var f=q(c,d);Object.isUndefined(d)&&(d=l(c));delete a.Event.cache[d];for(var g in f)if("element"!==g){d=f[g];for(e=d.length;e--;)z(c,g,d[e].responder)}return b}if(!e){g=b;d=q(g);if(f=d[c]){delete d[c];for(d=f.length;d--;)z(g,c,f[d].responder)}return b}if(g=q(b)[c]){for(e=g.length;e--;)if(g[e].handler===d){f=
g[e];break}f?(d=g.indexOf(f),g.splice(d,1),g=f):g=void 0}else g=void 0;if(!g)return b;z(b,c,g.responder);return b}function z(a,b,c){e(b)?a.removeEventListener?a.removeEventListener("dataavailable",c,!1):(a.detachEvent("ondataavailable",c),a.detachEvent("onlosecapture",c)):(b=m(b),a.removeEventListener?a.removeEventListener(b,c,!1):a.detachEvent("on"+b,c))}function L(a,b,c,d){a=$(a);a=a!==document?a:document.createEvent&&!a.dispatchEvent?document.documentElement:a;Object.isUndefined(d)&&(d=!0);c=c||
{};b=S(a,b,c,d);return t.extend(b)}function H(a,b,c,d){var e=document.createEvent("HTMLEvents");e.initEvent("dataavailable",d,!0);e.eventName=b;e.memo=c;a.dispatchEvent(e);return e}function G(a,b,c,d){var e=document.createEventObject();e.eventType=d?"ondataavailable":"onlosecapture";e.eventName=b;e.memo=c;a.fireEvent(e.eventType,e);return e}function F(a,b,c,d){a=$(a);Object.isFunction(c)&&Object.isUndefined(d)&&(d=c,c=null);return(new t.Handler(a,b,c,d)).start()}function J(){a.Event.cache=null}var u=
document.createElement("div"),E=document.documentElement,E="onmouseenter"in E&&"onmouseleave"in E,t={KEY_BACKSPACE:8,KEY_TAB:9,KEY_RETURN:13,KEY_ESC:27,KEY_LEFT:37,KEY_UP:38,KEY_RIGHT:39,KEY_DOWN:40,KEY_DELETE:46,KEY_HOME:36,KEY_END:35,KEY_PAGEUP:33,KEY_PAGEDOWN:34,KEY_INSERT:45},M=function(){return!1};window.attachEvent&&(M=window.addEventListener?function(a){return!(a instanceof window.Event)}:function(){return!0});var N,Q={"0":1,1:4,2:2};N=window.attachEvent?window.addEventListener?function(a,
c){return M(a)?d(a,c):b(a,c)}:d:Prototype.Browser.WebKit?f:b;t.Methods={isLeftClick:function(a){return N(a,0)},isMiddleClick:function(a){return N(a,1)},isRightClick:function(a){return N(a,2)},element:function(a){return Element.extend(h(a))},findElement:function(a,b){var c=h(a),d=Prototype.Selector.match;if(!b)return Element.extend(c);for(;c;){if(Object.isElement(c)&&d(c,b))return Element.extend(c);c=c.parentNode}},pointer:function(a){return{x:g(a),y:n(a)}},pointerX:g,pointerY:n,stop:function(a){t.extend(a);
a.preventDefault();a.stopPropagation();a.stopped=!0}};var k=Object.keys(t.Methods).inject({},function(a,b){a[b]=t.Methods[b].methodize();return a});if(window.attachEvent){var I=function(a){switch(a.type){case "mouseover":case "mouseenter":a=a.fromElement;break;case "mouseout":case "mouseleave":a=a.toElement;break;default:return null}return Element.extend(a)},O={stopPropagation:function(){this.cancelBubble=!0},preventDefault:function(){this.returnValue=!1},inspect:function(){return"[object Event]"}};
t.extend=function(a,b){if(!a)return!1;if(!M(a)||a._extendedByPrototype)return a;a._extendedByPrototype=Prototype.emptyFunction;var c=t.pointer(a);Object.extend(a,{target:a.srcElement||b,relatedTarget:I(a),pageX:c.x,pageY:c.y});Object.extend(a,k);Object.extend(a,O);return a}}else t.extend=Prototype.K;window.addEventListener&&(t.prototype=window.Event.prototype||document.createEvent("HTMLEvents").__proto__,Object.extend(t.prototype,k));var Z={mouseenter:"mouseover",mouseleave:"mouseout"};E&&(m=Prototype.K);
"uniqueID"in u&&(l=c);t._isCustomEvent=e;var S=document.createEvent?H:G;t.Handler=Class.create({initialize:function(a,b,c,d){this.element=$(a);this.eventName=b;this.selector=c;this.callback=d;this.handler=this.handleEvent.bind(this)},start:function(){t.observe(this.element,this.eventName,this.handler);return this},stop:function(){t.stopObserving(this.element,this.eventName,this.handler);return this},handleEvent:function(a){var b=t.findElement(a,this.selector);b&&this.callback.call(this.element,a,
b)}});Object.extend(t,t.Methods);Object.extend(t,{fire:L,observe:s,stopObserving:y,on:F});Element.addMethods({fire:L,observe:s,stopObserving:y,on:F});Object.extend(document,{fire:L.methodize(),observe:s.methodize(),stopObserving:y.methodize(),on:F.methodize(),loaded:!1});a.Event?Object.extend(window.Event,t):a.Event=t;a.Event.cache={};window.attachEvent&&window.attachEvent("onunload",J);E=u=null})(this);
(function(a){var b=document.documentElement,d="onmouseenter"in b&&"onmouseleave"in b;a.Event._createResponder=function(a,b,g){return Event._isCustomEvent(b)?function(d){var m=Event.cache[a].element;if(Object.isUndefined(d.eventName)||d.eventName!==b)return!1;Event.extend(d,m);g.call(m,d)}:!d&&("mouseenter"===b||"mouseleave"===b)?function(b){var d=Event.cache[a].element;Event.extend(b,d);for(var h=b.relatedTarget;h&&h!==d;)try{h=h.parentNode}catch(c){h=d}h!==d&&g.call(d,b)}:function(b){var d=Event.cache[a].element;
Event.extend(b,d);g.call(d,b)}};b=null})(this);
(function(){function a(){document.loaded||(f&&window.clearTimeout(f),document.loaded=!0,document.fire("dom:loaded"))}function b(){"complete"===document.readyState&&(document.detachEvent("onreadystatechange",b),a())}function d(){try{document.documentElement.doScroll("left")}catch(b){f=d.defer();return}a()}var f;document.addEventListener?document.addEventListener("DOMContentLoaded",a,!1):(document.attachEvent("onreadystatechange",b),window==top&&(f=d.defer()));Event.observe(window,"load",a)})(this);
Element.addMethods();Hash.toQueryString=Object.toQueryString;var Toggle={display:Element.toggle};Element.Methods.childOf=Element.Methods.descendantOf;
var Insertion={Before:function(a,b){return Element.insert(a,{before:b})},Top:function(a,b){return Element.insert(a,{top:b})},Bottom:function(a,b){return Element.insert(a,{bottom:b})},After:function(a,b){return Element.insert(a,{after:b})}},$continue=Error('"throw $continue" is deprecated, use "return" instead'),Position={includeScrollOffsets:!1,prepare:function(){this.deltaX=window.pageXOffset||document.documentElement.scrollLeft||document.body.scrollLeft||0;this.deltaY=window.pageYOffset||document.documentElement.scrollTop||
document.body.scrollTop||0},within:function(a,b,d){if(this.includeScrollOffsets)return this.withinIncludingScrolloffsets(a,b,d);this.xcomp=b;this.ycomp=d;this.offset=Element.cumulativeOffset(a);return d>=this.offset[1]&&d<this.offset[1]+a.offsetHeight&&b>=this.offset[0]&&b<this.offset[0]+a.offsetWidth},withinIncludingScrolloffsets:function(a,b,d){var f=Element.cumulativeScrollOffset(a);this.xcomp=b+f[0]-this.deltaX;this.ycomp=d+f[1]-this.deltaY;this.offset=Element.cumulativeOffset(a);return this.ycomp>=
this.offset[1]&&this.ycomp<this.offset[1]+a.offsetHeight&&this.xcomp>=this.offset[0]&&this.xcomp<this.offset[0]+a.offsetWidth},overlap:function(a,b){if(!a)return 0;if("vertical"==a)return(this.offset[1]+b.offsetHeight-this.ycomp)/b.offsetHeight;if("horizontal"==a)return(this.offset[0]+b.offsetWidth-this.xcomp)/b.offsetWidth},cumulativeOffset:Element.Methods.cumulativeOffset,positionedOffset:Element.Methods.positionedOffset,absolutize:function(a){Position.prepare();return Element.absolutize(a)},relativize:function(a){Position.prepare();
return Element.relativize(a)},realOffset:Element.Methods.cumulativeScrollOffset,offsetParent:Element.Methods.getOffsetParent,page:Element.Methods.viewportOffset,clone:function(a,b,d){d=d||{};return Element.clonePosition(b,a,d)}};
document.getElementsByClassName||(document.getElementsByClassName=function(a){function b(a){return a.blank()?null:"[contains(concat(' ', @class, ' '), ' "+a+" ')]"}a.getElementsByClassName=Prototype.BrowserFeatures.XPath?function(a,f){f=f.toString().strip();var h=/\s/.test(f)?$w(f).map(b).join(""):b(f);return h?document._getElementsByXPath(".//*"+h,a):[]}:function(a,b){b=b.toString().strip();var h=[],g=/\s/.test(b)?$w(b):null;if(!g&&!b)return h;var n=$(a).getElementsByTagName("*");b=" "+b+" ";for(var m=
0,l,c;l=n[m];m++)l.className&&((c=" "+l.className+" ")&&(c.include(b)||g&&g.all(function(a){return!a.toString().blank()&&c.include(" "+a+" ")})))&&h.push(Element.extend(l));return h};return function(a,b){return $(b||document.body).getElementsByClassName(a)}}(Element.Methods));Element.ClassNames=Class.create();
Element.ClassNames.prototype={initialize:function(a){this.element=$(a)},_each:function(a,b){this.element.className.split(/\s+/).select(function(a){return 0<a.length})._each(a,b)},set:function(a){this.element.className=a},add:function(a){this.include(a)||this.set($A(this).concat(a).join(" "))},remove:function(a){this.include(a)&&this.set($A(this).without(a).join(" "))},toString:function(){return $A(this).join(" ")}};Object.extend(Element.ClassNames.prototype,Enumerable);
(function(){window.Selector=Class.create({initialize:function(a){this.expression=a.strip()},findElements:function(a){return Prototype.Selector.select(this.expression,a)},match:function(a){return Prototype.Selector.match(a,this.expression)},toString:function(){return this.expression},inspect:function(){return"#<Selector: "+this.expression+">"}});Object.extend(Selector,{matchElements:function(a,b){for(var d=Prototype.Selector.match,f=[],h=0,g=a.length;h<g;h++){var n=a[h];d(n,b)&&f.push(Element.extend(n))}return f},
findElement:function(a,b,d){d=d||0;for(var f=0,h,g=0,n=a.length;g<n;g++)if(h=a[g],Prototype.Selector.match(h,b)&&d===f++)return Element.extend(h)},findChildElements:function(a,b){var d=b.toArray().join(", ");return Prototype.Selector.select(d,a||document)}})})();

/*##################################################
 *                                global.js
 *                            -------------------
 *   begin                : Februar 06 2007
 *   copyright            : (C) 2007 R�gis Viarre, Lo�c Rouchon
 *   email                : crowkait@phpboost.com, horn@phpboost.com
 *
 *
 ###################################################
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 ###################################################*/

//Javascript frame breaker necessary to the CSRF attack protection
if (top != self)
{
	top.location = self.location;
}

//R�p�tition d'un caract�re.
function str_repeat(charrepeat, nbr)
{
	var string = '';
	for(var i = 0; i < nbr; i++)
		string += charrepeat;
	return string;
}

//Recherche d'une cha�ne dans une autre.
function strpos(haystack, needle)
{
    var i = haystack.indexOf(needle, 0); // returns -1
    return i >= 0 ? i : false;
}

//Supprime les espaces en d�but et fin de cha�ne.
function trim(myString)
{
	return myString.replace(/^\s+/g,'').replace(/\s+$/g,'');
} 

//Affichage/Masquage de la balise hide.
function bb_hide(div2)
{
	var divs = div2.getElementsByTagName('div');
	var div3 = divs[0];
	if (div3.style.visibility == 'visible')
	{
		div3.style.visibility = 'hidden';
		div2.style.height = '10px';
		div2.style.overflow = 'hidden';
	}
	else
	{	
		div3.style.visibility = 'visible';
		div2.style.height = 'auto';
		div2.style.overflow = 'auto';
	}
	
	return true;
}

//Masque un bloc.
function hide_div(divID, useEffects)
{
    var use_effects = false
    if (arguments.length > 1)
        use_effects = useEffects;
    
    if ($(divID))
    {
        if (useEffects) Effect.SwitchOff(divID);
        $(divID).style.display = 'none';
    }
}

//Affiche un bloc
function show_div(divID, useEffects)
{
    var use_effects = false
    if (arguments.length > 1)
    {
        use_effects = useEffects;
    }
    
    if ($(divID))
    {
        if (useEffects)
    	{
			$(divID).appear({duration: 0.5});
    	}
        else
        {
        	$(divID).style.display = 'block';
        }
    }
}

//Masque un bloc.
function hide_inline(divID)
{
	if ($(divID))
	{
		Effect.SwitchOff(divID);
		$(divID).style.visibility = 'hidden';
	}
}

//Affiche un bloc
function show_inline(divID)
{
	if ($(divID))
	{	
		$(divID).appear({duration: 0.5});
		$(divID).style.visibility = 'visible';
	}
}

//Switch entre deux classes CSS.
function switch_className(id, class1, class2)
{
	if ($(id))
	{	
		if ($(id).className == class1)
			$(id).className = class2;
		else
			$(id).className = class1;
	}
}

//Afffiche/masque automatiquement un bloc.
function display_div_auto(divID, type)
{
	if ($(divID))
	{	
		if ($(divID).style.display == 'none')
			$(divID).appear();
		else
			$(divID).fade({duration: 0.5});
	}
}

//Popup
function popup(page,name)
{
   var screen_height = screen.height;
   var screen_width = screen.width;

	if (screen_height == 600 && screen_width == 800)
		window.open(page, name, "width=680, height=540,location=no,status=no,toolbar=no,scrollbars=yes");
	else if (screen_height == 768 && screen_width == 1024)
		window.open(page, name, "width=672, height=620,location=no,status=no,toolbar=no,scrollbars=yes");
	else if (screen_height == 864 && screen_width == 1152)
		window.open(page, name, "width=672, height=620,location=no,status=no,toolbar=no,scrollbars=yes");
	else
		window.open(page, name, "width=672, height=620,location=no,status=no,toolbar=no,scrollbars=yes");
}

//Teste la pr�sence d'une valeur dans un tableau
function inArray(aValue, anArray)
{
    for( var i = 0; i < anArray.length; i++)
    {
        if (anArray[i] == aValue)
            return true;
    }
    return false;
}

//Barre de progression, 
function change_progressbar(id_element, value, informations) {
	var progress_bar_el = $(id_element).select('.progressbar').first();
	progress_bar_el.setStyle({width: value + '%'});

	if (informations) {
		var progress_bar_infos_el = $(id_element).select('.progressbar-infos').first();
		progress_bar_infos_el.update(informations);
	}
	else {
		var progress_bar_infos_el = $(id_element).select('.progressbar-infos').first();
		progress_bar_infos_el.update(value + '%');
	}
}

//Fonction de pr�paration de l'ajax.
function xmlhttprequest_init(filename)
{
	var xhr_object = null;
	if (window.XMLHttpRequest) //Firefox
	   xhr_object = new XMLHttpRequest();
	else if (window.ActiveXObject) //Internet Explorer
	   xhr_object = new ActiveXObject("Microsoft.XMLHTTP");

	xhr_object.open('POST', filename, true);

	return xhr_object;
}

//Fonction ajax d'envoi.
function xmlhttprequest_sender(xhr_object, data)
{
	xhr_object.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	xhr_object.send(data);
}

//Echape les variables de type cha�nes dans les requ�tes xmlhttprequest.
function escape_xmlhttprequest(contents)
{
	contents = contents.replace(/\+/g, '%2B');
	contents = contents.replace(/&/g, '%26');
	
	return contents;
}

//Informe sur la capacit� du navigateur � supporter AJAX
function browserAJAXFriendly()
{
    if ( window.XMLHttpRequest || window.ActiveXObject)
        return true;
    else
        return false;
}

//Fonction de recherche des membres.
function XMLHttpRequest_search_members(searchid, theme, insert_mode, alert_empty_login)
{
	var login = $('login' + searchid).value;
	if (login != '')
	{
		if ($('search_img' + searchid))
			$('search_img' + searchid).innerHTML = '<i class="fa fa-spinner fa-spin"></i>';
		var xhr_object = xmlhttprequest_init(PATH_TO_ROOT + '/kernel/framework/ajax/member_xmlhttprequest.php?token=' + TOKEN + '&' + insert_mode + '=1');
		data = 'login=' + login + '&divid=' + searchid;
		xhr_object.onreadystatechange = function() 
		{
			if (xhr_object.readyState == 4 && xhr_object.status == 200) 
			{
				if ($('search_img' + searchid))
					$('search_img' + searchid).innerHTML = '';
				if ($("xmlhttprequest-result-search" + searchid))
					$("xmlhttprequest-result-search" + searchid).innerHTML = xhr_object.responseText;
				Effect.BlindDown('xmlhttprequest-result-search' + searchid, { duration: 0.5 });
			}
			else if (xhr_object.readyState == 4) 
			{
				if ($('search_img' + searchid))
					$('search_img' + searchid).innerHTML = '';
			}
		}
		xmlhttprequest_sender(xhr_object, data);
	}	
	else
		alert(alert_empty_login);
}

//Fonction d'ajout de membre dans les autorisations.
function XMLHttpRequest_add_member_auth(searchid, user_id, login, alert_already_auth)
{
    var selectid = $('members_auth' + searchid);
    for(var i = 0; i < selectid.length; i++) //V�rifie que le membre n'est pas d�j� dans la liste.
    {
        if (selectid[i].value == user_id)
        {
            alert(alert_already_auth);
            return;
        }
    }
    var oOption = new Option(login, user_id);
    oOption.id = searchid + 'm' + (selectid.length - 1);
        oOption.selected = true;

    if ($('members_auth' + searchid)) //Ajout du membre.
        $('members_auth' + searchid).options[selectid.length] = oOption;
}

//S�lection des formulaires.
function check_select_multiple(id, status)
{
	var i;	

	//S�lection des groupes.
	var selectidgroups = $('groups_auth' + id);
	for(i = 0; i < selectidgroups.length; i++)
	{	
		if (selectidgroups[i])
			selectidgroups[i].selected = status;
	}
	
	//S�lection des membres.
	var selectidmember = $('members_auth' + id);
	for(i = 0; i < selectidmember.length; i++)
	{	
		if (selectidmember[i])
			selectidmember[i].selected = status;
	}	
}

//S�lection auto des rangs sup�rieur � celui cliqu�.
function check_select_multiple_ranks(id, start)
{
	var i;			
	for(i = start; i <= 2; i++)
	{	
		if ($(id + i))
			$(id + i).selected = true;
	}
}

// Cr�e un lien de pagination javascript
function writePagin(fctName, fctArgs, isCurrentPage, textPagin, i)
{
    pagin = '<span class="pagination';
    if ( isCurrentPage)
        pagin += ' pagination_current_page text-strong';
    pagin += '">';
    pagin += '<a href="javascript:' + fctName + '(' + i + fctArgs + ')">' + textPagin + '</a>';
    pagin += '</span>&nbsp;';
    
    return pagin;
}

// Cr�e la pagination � partir du nom du bloc de page, du bloc de pagination, du nombre de r�sultats
// du nombre de r�sultats par page ...
function ChangePagination(page, nbPages, blocPagin, blocName, nbPagesBefore, nbPagesAfter)
{
    var pagin = '';
    if ( nbPages > 1)
    {
        if (arguments.length < 5)
        {
            nbPagesBefore = 3;
            nbPagesAfter = 3;
        }
        
        var before = Math.max(0, page - nbPagesBefore);
        var after = Math.min(nbPages, page + nbPagesAfter + 1);
        
        var fctName = 'ChangePagination';
        var fctArgs = ', '  + nbPages + ', \'' + blocPagin + '\', \'' + blocName + '\', ' + nbPagesBefore + ', ' + nbPagesAfter;
        
        // D�but
        if (page != 0)
            pagin += writePagin(fctName, fctArgs, false, '&laquo;', 0);
        
        // Before
        for ( var i = before; i < page; i++)
            pagin += writePagin(fctName, fctArgs, false, i + 1, i);
        
        // Page courante
        pagin += writePagin(fctName, fctArgs, true, page + 1, page);
        
        // After
        for ( var i = page + 1; i < after; i++)
            pagin += writePagin(fctName, fctArgs, false, i + 1, i);
        
        // Fin
        if (page != nbPages - 1)
            pagin += writePagin(fctName, fctArgs, false, '&raquo;', nbPages - 1);
    }
    
    // On cache tous les autre r�sultats du module
    for ( var i = 0; i < nbPages; i++)
        hide_div(blocName + '_' + i);
        
    // On montre la page demand�e
    show_div(blocName + '_' + page);
    
    // Mise � jour de la pagination
    $(blocPagin).innerHTML = pagin;
}

// Teste si une chaine est un entier
function isInteger(number)
{
    var numbers = "0123456789";
    for ( var i = 0; i < number.length && numbers.indexOf(number[i]) != -1; i++);
    return i == number.length ;
}


/*#######Feeds menu gestion######*/
var feed_menu_timeout_in = null;
var feed_menu_timeout_out = null;
var feed_menu_elt = null;
var feed_menu_delay = 800; //Dur�e apr�s laquelle le menu est cach� lors du d�part de la souris.

// Print the syndication's choice menu
function ShowSyndication(element)
{
    if (feed_menu_elt)
        feed_menu_elt.style.visibility = 'hidden';
    feed_menu_elt = null;
    var elts = null;
    elts = element.parentNode.getElementsByTagName('div');
    for( var i = 0; i < elts.length; i++) {
        if (elts[i].title == 'L_SYNDICATION_CHOICES') {
            feed_menu_elt = elts[i];
            break;
        }
    }
	feed_menu_elt.style.visibility = 'visible';
    clearTimeout(feed_menu_timeout_out);
}
function ShowSyndicationMenu(element)
{
	element.style.visibility = 'visible';
    clearTimeout(feed_menu_timeout_out);
}
function HideSyndication(element)
{
    feed_menu_elt = element;
    feed_menu_timeout_out = setTimeout('feed_menu_elt.style.visibility = \'hidden\'', feed_menu_delay);
    clearTimeout(feed_menu_timeout_in);
}

//Pour savoir si une fonction existe
function functionExists(function_name)
{
    // http://kevin.vanzonneveld.net
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Steve Clay
    // +   improved by: Legaev Andrey
    // *     example 1: function_exists('isFinite');
    // *     returns 1: true 
    if (typeof function_name == 'string')
    {
        return (typeof window[function_name] == 'function');
    }
    else
    {
        return (function_name instanceof Function);
    }
}

//Includes synchronously a js file
function include(file)
{
	if (window.document.getElementsByTagName)
	{
		script = window.document.createElement("script");
		script.type = "text/javascript";
		script.src = file;
		document.documentElement.firstChild.appendChild(script);
	}
}

//Affiche le lecteur vid�o avec la bonne URL, largeur et hauteur
playerflowPlayerRequired = false;
function insertMoviePlayer(id)
{
	if (!playerflowPlayerRequired)
	{
		include(PATH_TO_ROOT + '/kernel/lib/flash/flowplayer/flowplayer.js');
		playerflowPlayerRequired = true;
	}
	flowPlayerDisplay(id);
}

//Construit le lecteur � partir du moment o� son code a �t� interpr�t� par l'interpr�teur javascript
function flowPlayerDisplay(id)
{
	//Construit et affiche un lecteur vid�o de type flowplayer
	//Si la fonction n'existe pas, on attend qu'elle soit interpr�t�e
	if (!functionExists('flowplayer'))
	{
		setTimeout('flowPlayerDisplay(\'' + id + '\')', 100);
		return;
	}
	//On lance le flowplayer
	flowplayer(id, PATH_TO_ROOT + '/kernel/lib/flash/flowplayer/flowplayer.swf', { 
		    clip: { 
		        url: $(id).href,
		        autoPlay: false 
		    }
	    }
	);
}

var delay = 1000; //D�lai apr�s lequel le bloc est automatiquement masqu�, apr�s le d�part de la souris.
var timeout;
var displayed = false;
var previous_bblock;

//Affiche le bloc.
function bb_display_block(divID, field)
{
	var i;
	
	if( timeout )
		clearTimeout(timeout);
	
	var block = document.getElementById('bb-block' + divID + field);
	if( block.style.display == 'none' )
	{
		if( document.getElementById(previous_bblock) )
			document.getElementById(previous_bblock).style.display = 'none';
		block.style.display = 'block';
		displayed = true;
		previous_bblock = 'bb-block' + divID + field;
	}
	else
	{
		block.style.display = 'none';
		displayed = false;
	}
}

//Cache le bloc.
function bb_hide_block(bbfield, field, stop)
{
	var nav = navigator.appName; //Recup�re le nom du navigateur
	if( nav == 'Microsoft Internet Explorer' ) // Internet Explorer
	{
		if (window.event.toElement == null) //Hack pour ie... encore une fois!
			return;
	}
	
	if( stop && timeout )
	{	
		clearTimeout(timeout);
	}
	else if( displayed )
	{
		clearTimeout(timeout);
		timeout = setTimeout('bb_display_block(\'' + bbfield + '\',  \'' + field + '\')', delay);
	}	
}