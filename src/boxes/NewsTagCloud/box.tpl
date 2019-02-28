{if $boxNs->$box_id->tagCloud->getItemList()|count}
	<div class="box" id="box_article_tagcloud">
	    <div class="boxhead">
	        <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
	    </div>
	    <div class="innerbox">
	        {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
	        {$boxNs->$box_id->tagCloud}                           
	    </div>
	</div>
{/if}