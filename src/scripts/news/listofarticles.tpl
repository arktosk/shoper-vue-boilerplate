<div class="box" id="box_articlelist">
    <div class="innerbox">
        {foreach from=$articles item=article name=list}
            <article>
                <div class="row article-header">
                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    {if $enable_comments || ($enable_download && $article->files|count > 0) || ($article->article->content|strlen > 0 && $article->article->short_content != $article->article->content)}
                        <a class="article-name" href="{route function='news' key=$article->getIdentifier() newsId=$article->getIdentifier() newsName=$article->article->name newsYear="Y"|date:$article->articleTimestamp newsMonth="m"|date:$article->articleTimestamp newsDay="d"|date:$article->articleTimestamp}">{$article->article->name|escape}</a>
                    {else}
                        <a class="article-name article-name-inactive">{$article->article->name|escape}</a>
                    {/if}

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
                    {$article->article->short_content}
                </div>
                {if $article->article->content|strlen > 0 && $article->article->short_content != $article->article->content}
                    <a class="readmore" href="{route function='news' key=$article->getIdentifier() newsId=$article->getIdentifier() newsName=$article->article->name newsYear="Y"|date:$article->articleTimestamp newsMonth="m"|date:$article->articleTimestamp newsDay="d"|date:$article->articleTimestamp}">{translate key="read more"} &raquo;</a>
                {/if}                                
            </article>
        {/foreach}
        {if $articles instanceof Zend_Paginator && $articles->getTotalItemCount() > $articles->getItemCountPerPage()}
            <div class="floatcenterwrap row">
                {include file='paginator.tpl'}
            </div>
        {/if}
    </div>
</div>
