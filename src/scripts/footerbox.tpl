<div class="bottom-footer row">
	<div class="container">
	    {dynamic}
	        {if count($boxes_footer_side)}
	            {foreach from=$boxes_footer_side item=v key=k}
	                {box file="../boxes/$v/box.tpl" box="$k"}
	            {/foreach}
	        {/if}
	    {/dynamic}
    </div>
</div>