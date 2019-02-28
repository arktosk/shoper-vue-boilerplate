{include file='header.tpl'}
<body{if $body_id} id="{$body_id|escape}"{/if}{if $body_class} class="{$body_class|escape}"{/if}>
    {include file='body_head.tpl'}
    <div class="main row">
        <div class="innermain container">
            <div class="s-row">
                {if 0 < $boxes_left_side|@count}
                    <div class="leftcol large s-grid-3">
                        {dynamic}
                            {foreach from=$boxes_left_side item=v key=k}
                                {box file="../boxes/$v/box.tpl" box="$k"}
                            {/foreach}
                        {/dynamic}
                    </div>
                {/if}

                <div class="centercol {if ($boxes_left_side|@count == 0) and ($boxes_right_side|@count == 0)}s-grid-12{elseif 0 != $boxes_left_side|@count and $boxes_right_side|@count != 0}s-grid-6{else}s-grid-9{/if}">
                    {dynamic}
                        {foreach from=$boxes_top_side item=v key=k}
                            {box file="../boxes/$v/box.tpl" box="$k"}
                        {/foreach}
                    {/dynamic}

                    <article class="box" id="box_article">
                        <div class="row article-header">
                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                            <span class="article-name">{$article->article->name|escape}</span>
                            {if $enable_comments}
                                <a class="article-comments" href="{route function='news' key=$article->getIdentifier() newsId=$article->getIdentifier() newsName=$article->article->name newsYear="Y"|date:$article->articleTimestamp newsMonth="m"|date:$article->articleTimestamp newsDay="d"|date:$article->articleTimestamp}#commentform">
                                    {$article->getValidatedComments()|count}
                                </a>
                            {/if}
                        </div>

                        <div class="row article-info">{strip}
                            {capture assign="articleDate"}
                                {date value=$article->article->date format='Zend_Date::DATE_MEDIUM'}
                            {/capture}

                            {assign var="articleCategories" value="-"}
                            {foreach from=$article->getActiveCategories() item=category name=listCat}
                                {if $smarty.foreach.listCat.index == 0}
                                    {capture assign="articleCategories"}
                                        <a href="{route function='newsCategory' key=$category->getIdentifier() categoryId=$category->getIdentifier() categoryName=$category->category->name}">{$category->category->name|escape}</a>
                                    {/capture}
                                {else}
                                    {capture append="articleCategories"}
                                        <a href="{route function='newsCategory' key=$category->getIdentifier() categoryId=$category->getIdentifier() categoryName=$category->category->name}">{$category->category->name|escape}</a>
                                    {/capture}
                                {/if}
                            {/foreach}
                            {if $articleCategories|is_array}
                                {assign var="articleCategories" value=', '|implode:$articleCategories}
                            {/if}

                            {assign var="articleAuthor" value=$article->article->author|escape}
                            {if $articleAuthor}
                                {translate key="Added: %s in category: %s author: %s" s1='<span class="article-date">'|cat:$articleDate|cat:'</span>' s2='<span class="article-categories">'|cat:$articleCategories|cat:'</span>' s3='<span class="article-author">'|cat:$articleAuthor|cat:'</span>'}
                            {else}
                                {translate key="Added: %s in category: %s" s1='<span class="article-date">'|cat:$articleDate|cat:'</span>' s2='<span class="article-categories">'|cat:$articleCategories|cat:'</span>'}
                            {/if}
                        {/strip}</div>
                                
                        <div class="resetcss row article-content">
                            {if $article->image}
                                <img class="article-image" src="{baseDir}/{$article->image}" alt="{$article->article->image_name|escape}">
                            {/if}
                            {$article->article->content}
                        </div>
                    </article>
 
                    {if $article->tags|count > 0}
                        <ul class="article-tags">
                            {foreach from=$article->tags item=tag name=listTag}
                                <li><a href="{route key='newsTag' tagName=$tag->tag->name}">#{$tag->tag->name|escape}</a></li>
                            {/foreach}
                        </ul>
                    {/if}
                        
                    {include file="news/files.tpl"}
                    {include file="news/comments.tpl"}
                        
                    {dynamic}
                        {foreach from=$boxes_bottom_side item=v key=k}
                            {box file="../boxes/$v/box.tpl" box="$k"}
                        {/foreach}
                    {/dynamic}
                </div>

                {if 0 < $boxes_right_side|@count}
                    <div class="rightcol large s-grid-3">
                        {dynamic}
                            {foreach from=$boxes_right_side item=v key=k}
                                {box file="../boxes/$v/box.tpl" box="$k"}
                            {/foreach}
                        {/dynamic}
                    </div>
                {/if}
            </div>
        </div>
    </div>
{include file='footerbox.tpl'}
{include file='footer.tpl' force_include_cache='1' force_include_cache_tags='Logic_SkinFooterGroupList,Logic_SkinFooterLinkList,Logic_SkinFooterGroup,Logic_SkinFooterLink'}
{plugin module=shop template=footer}
{include file='switch.tpl'}
</body>
</html>
