!function(){var e={p:""};StackExchange=window.StackExchange=window.StackExchange||{},StackOverflow=window.StackOverflow=window.StackOverflow||{},e.p=document.getElementById("webpack-public-path").innerText,StackExchange=window.StackExchange=window.StackExchange||{},StackOverflow=window.StackOverflow=window.StackOverflow||{},StackExchange.postValidation=function(){var e=$("body").hasClass("js-ask-page-v2"),t="Title",n="Body",r="Tags",a="Mentions",i="EditComment",o="Excerpt",s="Email",c="General";function l(e,t,n){var r={Title:".js-post-title-field",Body:".js-post-body-field[data-post-type-id="+t+"]",Tags:".js-post-tags-field",Mentions:".js-post-mentions-field",EditComment:".js-post-edit-comment-field",Excerpt:".js-post-excerpt-field",Email:".js-post-email-field",ArticleType:".js-article-type-field"};return r[n]?e.find(r[n]):$()}function u(e,t,n){var i=l(e,t,n);return n===r||n===a?e.find(".js-tag-editor").filter((function(){return $(this).data("target-field")===i.get(0)})):i}var d=[];function f(a,c,l,u){var d=a.find('input[type="submit"]:visible, button[type="submit"]:visible'),f=d.length&&d.is(":enabled");f&&d.prop("disabled",!0),function(n,r,a){m(n,r,a,t,(function(t,n,r){var a=t.val(),i=$.trim(a).length,o=t.data("min-length"),s=t.data("max-length");0!==i||e?o&&i<o?n((function(n){return n.minLength==1?"Title must be at least "+n.minLength+" character.":"Title must be at least "+n.minLength+" characters."})({minLength:o})):s&&i>s?n((function(n){return n.maxLength==1?"Title cannot be longer than "+n.maxLength+" character.":"Title cannot be longer than "+n.maxLength+" characters."})({maxLength:s})):r({type:"POST",url:"/posts/validate-title",data:{title:a,fkey:StackExchange.options.user.fkey}}):n()}))}(a,c,l),function(t,r,a,i){m(t,r,a,n,(function(t,n,a){var o=t.val(),s=$.trim(o).length,c=t.data("min-length");0!==s||e?5!==r?1!==r&&2!==r||a({type:"POST",url:"/posts/validate-body",data:{body:o,oldBody:t.prop("defaultValue"),isQuestion:1===r,isSuggestedEdit:i,fkey:StackExchange.options.user.fkey}}):c&&s<c?n((function(n){return"Wiki Body must be at least "+n.minLength+" characters. You entered "+n.actual+"."})({minLength:c,actual:s})):n():n()}))}(a,c,l,u),function(e,t,n){m(e,t,n,i,(function(r,a,i){var o=r.val(),s=$.trim(o).length,c=r.data("min-length"),l=r.data("max-length");0!==s?c&&s<c?a((function(n){return n.minLength==1?"Your edit summary must be at least "+n.minLength+" character.":"Your edit summary must be at least "+n.minLength+" characters."})({minLength:c})):l&&s>l?a((function(n){return n.maxLength==1?"Your edit summary cannot be longer than "+n.maxLength+" character.":"Your edit summary cannot be longer than "+n.maxLength+" characters."})({maxLength:l})):v(e,t,n)||a():a()}))}(a,c,l),function(e,t,n){m(e,t,n,o,(function(e,t,n){var r=e.val(),a=$.trim(r).length,i=e.data("min-length"),o=e.data("max-length");0!==a?i&&a<i?t((function(n){return"Wiki Excerpt must be at least "+n.minLength+" characters; you entered "+n.actual+"."})({minLength:i,actual:a})):o&&a>o?t((function(n){return"Wiki Excerpt cannot be longer than "+n.maxLength+" characters; you entered "+n.actual+"."})({maxLength:o,actual:a})):t():t()}))}(a,c,l),function(e,t,n){m(e,t,n,s,(function(e,t,n){var r=e.val(),a=$.trim(r);0!==a.length?StackExchange.helpers.isEmailAddress(a)?t():t("This email does not appear to be valid."):t()}))}(a,c,l),y(a,c,(function(){!function(t,n,a){m(t,n,a,r,(function(t,n,r,a){var i=t.val();0!==$.trim(i).length||e?r({type:"POST",url:"/posts/validate-tags",data:{tags:i,oldTags:t.prop("defaultValue"),fkey:StackExchange.options.user.fkey,postTypeId:a},success:function(e){var n=t.closest(".js-post-form").find(".js-warned-tags-field");if(n.length){var r=n.val(),a=n.data("warned-tags")||[],i=((e.source||{}).Tags||[]).filter((function(e){return e&&-1===a.indexOf(e)}));i.length>0&&StackExchange.using("gps",(function(){i.forEach((function(e){StackExchange.gps.track("tag_warning.show",{tag:e},!0),r+=" "+e,a.push(e)})),n.val($.trim(r)).data("warned-tags",a),StackExchange.gps.sendPending()}))}}}):n()}))}(a,c,l),f&&d.prop("disabled",!1)}))}function p(e,t){e.find('input[type="submit"]:visible, button[type="submit"]').removeClass("is-loading"),t||StackExchange.helpers.enableSubmitButton(e)}function h(e,t,n,r,a){$.ajax({type:"POST",dataType:"json",data:e.serialize(),url:e.attr("action"),success:a,error:function(){var r=b(n,0);w(e,t,n,{General:[$("<span/>").text(r).html()]},0)},complete:function(){p(e,r)}})}function g(){for(var e=0;e<d.length;e++)clearTimeout(d[e]);d=[]}function m(t,n,r,a,i){l(t,n,a).blur((function(){var o=this,s=$(this),c=function(e){T(t,n,r,a,e)},l=function(e){return E(e,t,n,r,[a])};d.push(setTimeout((function(){var t=StackExchange.stacksValidation.handlerFor(s);t&&!e&&t.clear(),i.call(o,s,c,l,n)}),250))}))}function v(e,t,n){return"[Edit removed during grace period]"===$.trim(l(e,t,i).val())&&(T(e,t,n,i,"Comment reserved for system use. Please use an appropriate comment."),!0)}function b(e,t){if(t>0)switch(e){case"question":return (function(n){return n.specificErrorCount==1?"Your question couldn't be submitted. Please see the error above.":"Your question couldn't be submitted. Please see the errors above."})({specificErrorCount:t});case"answer":return (function(n){return n.specificErrorCount==1?"Your answer couldn't be submitted. Please see the error above.":"Your answer couldn't be submitted. Please see the errors above."})({specificErrorCount:t});case"edit":return (function(n){return n.specificErrorCount==1?"Your edit couldn't be submitted. Please see the error above.":"Your edit couldn't be submitted. Please see the errors above."})({specificErrorCount:t});case"tags":return (function(n){return n.specificErrorCount==1?"Your tags couldn't be submitted. Please see the error above.":"Your tags couldn't be submitted. Please see the errors above."})({specificErrorCount:t});case"article":return (function(n){return n.specificErrorCount==1,"Your article couldn't be submitted. Please see the errors above."})({specificErrorCount:t});default:return (function(n){return n.specificErrorCount==1?"Your post couldn't be submitted. Please see the error above.":"Your post couldn't be submitted. Please see the errors above."})({specificErrorCount:t})}else switch(e){case"question":return "An error occurred submitting the question.";case"answer":return "An error occurred submitting the answer.";case"edit":return "An error occurred submitting the edit.";case"tags":return "An error occurred submitting the tags.";case"article":return "An error occurred submitting the article.";default:return "An error occurred submitting the post."}}function w(e,t,n,r,a){var i=e.find(".js-general-error").text("").removeClass("d-none");j(e,i,r,null,c,t,n)||(a>0?i.text(b(n,a)):i.addClass("d-none"))}function k(e){var t=$(".js-post-review-summary").closest(".js-post-review-summary-container");if(t.length>0)t.filter(":visible").scrollIntoView();else{var n,r;O()&&($("#sidebar").animate({opacity:.4},500),n=setInterval((function(){O()||($("#sidebar").animate({opacity:1},500),clearInterval(n))}),500)),e.find(".validation-error, .js-stacks-validation.has-error").each((function(){var e=$(this).offset().top;(!r||e<r)&&(r=e)}));var a=function(){for(var t=0;t<3;t++)e.find(".message").animate({left:"+=5px"},100).animate({left:"-=5px"},100)};if(r){var i=$(".review-bar").length;r=Math.max(0,r-(i?125:30)),$("html, body").animate({scrollTop:r},a)}else a()}}function x(e,c,l,u,d){u&&y(e,c,(function(){var f=S(e,c,l,[t,n,r,a,i,o,s,"ArticleType"],u,d).length;w(e,c,l,u,f),k(e)}))}function y(e,t,n){var a=function(){1!==t||u(e,t,r).length?n():setTimeout(a,250)};a()}function E(e,t,n,r,a,i){return $.ajax(e).then((function(e){return i?$.when(i()).then((function(){return e})):e})).done((function(e){S(t,n,r,a,e.errors,e.warnings)})).fail((function(){S(t,n,r,a,{},{})}))}function S(e,t,n,r,a,i){for(var o=[],s=0;s<r.length;s++){var c=r[s];j(e,u(e,t,c),a,i,c,t,n)&&o.push(c)}return o}function T(e,t,n,r,a){C(e,u(e,t,r),a?[$("<span/>").text(a).html()]:[],[],r,t,n)}function j(e,t,n,r,a,i,o){return C(e,t,n[a]||[],(r||{})[a]||[],a,i,o)}function C(t,n,r,a,i,o,s){var l=StackExchange.stacksValidation.handlerFor(n);return l?function(t,n,r,a,i){t.clear("error"),a.forEach((function(e){t.add("error",e)})),"edit"===r||"question"===r&&e||(t.clear("warning"),i.forEach((function(e){t.add("warning",e)})))}(l,0,s,r,a):function(e,t,n){e&&e.length&&(0===n.length||1===n.length&&""===n[0]||!$("html").has(e).length?function(e){var t=e.data("error-popup");t&&t.is(":visible")&&t.fadeOutAndRemove(),e.removeClass("validation-error"),e.removeData("error-popup"),e.removeData("error-message")}(e):function(e,t,n){var r=1===t.length?t[0]:"<ul><li>"+t.join("</li><li>")+"</li></ul>",a=e.data("error-popup");if(a&&a.is(":visible")){if(e.data("error-message")===r)return void(a.animateOffsetTop&&a.animateOffsetTop(0));a.fadeOutAndRemove()}var i=StackExchange.helpers.showMessage(e,r,n);i.find("a").attr("target","_blank"),i.click(g),e.addClass("validation-error").data("error-popup",i).data("error-message",r)}(e,n,function(e,t){var n=$("#sidebar, .sidebar").first().width()||270,r="lg"===StackExchange.responsive.currentRange();return e===c?{position:"inline",css:{display:"inline-block","margin-bottom":"10px"},closeOthers:!1,dismissable:!1,type:t}:{position:{my:r?"left top":"top center",at:r?"right center":"bottom center"},css:{"max-width":n,"min-width":n},closeOthers:!1,type:t}}(t,"error")))}(n,i,r),t.find(".validation-error, .js-stacks-validation.has-error").length||t.find(".js-general-error").text(""),n.trigger("post:validated-field",[{errors:r,warnings:a,field:i,postTypeId:o,formType:s}]),r.length>0}function O(){var e=!1,t=$("#sidebar, .sidebar").first();if(!t.length)return!1;var n=t.offset().left;return $(".message").each((function(){var t=$(this);if(t.offset().left+t.outerWidth()>n)return e=!0,!1})),e}return{initOnBlur:f,initOnBlurAndSubmit:function(e,t,n,a,i){var o;f(e,t,n,a);var s=function(r){if(e.trigger("post:submit-completed",[{formType:n,postTypeId:t,response:r}]),r.success)if(i)i(r);else{var a=window.location.href.split("#")[0],c=r.redirectTo.split("#")[0];0===c.indexOf("/")&&(c=window.location.protocol+"//"+window.location.hostname+c),window.onbeforeunload=null,o=!0,window.location=r.redirectTo,a.toLowerCase()===c.toLowerCase()&&window.location.reload(!0)}else r.captchaHtml?StackExchange.nocaptcha.init(r.captchaHtml,s):r.errors?(e.find(".js-post-prior-attempt-count").val((function(e,t){return(+t+1||0).toString()})),x(e,t,n,r.errors,r.warnings)):w(e,t,n,{General:[$("<span/>").text(r.message).html()]},0)};e.submit((function(){if(e.find(".js-post-answer-while-asking-checkbox").is(":checked"))return!0;if(v(e,t,n))return StackExchange.helpers.enableSubmitButton(e),!1;if(g(),StackExchange.navPrevention&&StackExchange.navPrevention.stop(),e.find('input[type="submit"]:visible, button[type="submit"]').addClass("is-loading"),StackExchange.helpers.disableSubmitButton(e),StackExchange.options.site.enableNewTagCreationWarning){var a=l(e,t,r),i=a.prop("defaultValue");if(a.val()!==i)return $.ajax({type:"GET",url:"/posts/new-tags-warning",dataType:"json",data:{tags:a.val()},success:function(a){if(a.showWarning){var i={closeOthers:!0,shown:function(){$(".js-confirm-tag-creation").on("click",(function(r){return StackExchange.helpers.closePopups(),h(e,t,n,o,s),r.preventDefault(),!1}))},dismissing:function(){p(e,o)},returnElements:u(e,t,r).find("input:visible")};StackExchange.helpers.showModal($(a.html).elementNodesOnly(),i),StackExchange.helpers.bindMovablePopups()}else h(e,t,n,o,s)}}),!1}return setTimeout((function(){h(e,t,n,o,s)}),0),!1}))},showErrorsAfterSubmission:x,validatePostFields:function(e,a,i,o,s){if(1===a)return E({type:"POST",url:"/posts/validate-question",data:{title:l(e,a,t).val(),body:l(e,a,n).val(),tags:l(e,a,r).val(),fkey:StackExchange.options.user.fkey}},e,a,i,[t,n,r],s).promise();if(2===a)return E({type:"POST",url:"/posts/validate-body",data:{body:l(e,a,n).val(),oldBody:l(e,a,n).prop("defaultValue"),isQuestion:!1,isSuggestedEdit:o||!1,fkey:StackExchange.options.user.fkey}},e,a,i,[n],s).promise();var c=$.Deferred();return c.reject(),c.promise()},scrollToErrors:k}}()}();