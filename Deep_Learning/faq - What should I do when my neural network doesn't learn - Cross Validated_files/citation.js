!function(){var e={p:""};StackExchange=window.StackExchange=window.StackExchange||{},StackOverflow=window.StackOverflow=window.StackOverflow||{},e.p=document.getElementById("webpack-public-path").innerText,StackExchange=window.StackExchange=window.StackExchange||{},StackOverflow=window.StackOverflow=window.StackOverflow||{},window.citation={show:function(e){!function(e){var t=e.closest(".js-post-menu"),a=t.attr("data-post-id"),c=t.find(".js-menu-popup-container");if(!(c.find(".js-cite-popup").length>0)){var n=$('<div class="js-cite-popup popup popup d-block ws6 c-auto">    <div class="js-cite-example mb4"></div>    <form class="d-flex gs8">        <label class="flex--item"><input type="radio" class="s-radio js-cite-bibtex" name="reftype" checked="checked"/> BibTeX</label>        <label class="flex--item"><input type="radio" class="s-radio js-cite-amsrefs" name="reftype" /> amsrefs</label>    </form>    <textarea class="js-cite-text s-textarea w100 d-block mt4" rows="9"></textarea>    <button type="button" class="s-btn js-cite-close mt8 mbn4 p2">Close</button></div>');n.find(".js-cite-close").click((function(){n.fadeOutAndRemove()})),n.find("form").on("submit",(function(e){e.preventDefault()}));var i=n.find(".js-cite-example"),s=n.find(".js-cite-bibtex"),o=n.find(".js-cite-amsrefs"),l=n.find(".js-cite-text");c.append(n),StackExchange.helpers.addSpinner(i),$.ajax({type:"GET",url:"/posts/"+a+"/citation",dataType:"json",success:function(e){StackExchange.helpers.removeSpinner(),i.html(e.example),l.val(e.bibtex),s.click((function(){l.val(e.bibtex)})),o.click((function(){l.val(e.amsref)}))}})}}(e)}}}();