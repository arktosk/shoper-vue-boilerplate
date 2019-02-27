{if $boxNs->$box_id->list|@count}
    <div class="box" id="box_article_categories">
        <div class="boxhead">
            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
        </div>
        <div class="innerbox">
            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
            <ul class="standard">
                {foreach from=$boxNs->$box_id->list item=category}
                    {assign var='id' value=$category->category->category_id}
                    <li id="news_category_{$category->category->category_id}">
                        <a href="{$boxNs->$box_id->cat_links->$id}">{$category->category->name|escape}</a>
                        {if $boxNs->$box_id->counter}
                            <em>({$category->countActivePosts()})</em>
                        {/if}
                    </li>
                {/foreach}
            </ul>                           
        </div>
    </div>
{/if}