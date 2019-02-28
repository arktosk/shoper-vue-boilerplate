{if $boxNs->$box_id->list|@count}
    <div class="box" id="box_articlelistsmall">
        <div class="boxhead">
            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >{$boxNs->$box_id->title|escape}</span>
        </div>
        <div class="innerbox">
            {if $boxNs->$box_id->text}
                <h5 class="boxintro">{$boxNs->$box_id->text}</h5>
            {/if}
            {foreach from=$boxNs->$box_id->list item=box_article name=list}
                <article class="article-small row">
                    <h5 class="article_name row">
                        {if $box_article->article->content|strlen > 0}
                            <a href="{route function='news' key=$box_article->getIdentifier() newsId=$box_article->getIdentifier() newsName=$box_article->article->name newsYear="Y"|date:$box_article->articleTimestamp newsMonth="m"|date:$box_article->articleTimestamp newsDay="d"|date:$box_article->articleTimestamp}">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1"><span class="article_name_span">{$box_article->article->name|escape}</span>
                            </a>
                        {else}
                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1"><span class="article_name_span">{$box_article->article->name|escape}</span>
                        {/if}
                    </h5>
                    <div class="article-info">
                        {date value=$box_article->article->date format='Zend_Date::DATE_MEDIUM'}
                        {if $box_article->article->author}, {$box_article->article->author|escape}{/if}
                    </div>
                    {if 2 == $boxNs->$box_id->format}
                        <div class="resetcss">{$box_article->article->short_content}</div>
                    {/if}
                    {if $box_article->article->content|strlen > 0 && $box_article->article->short_content != $box_article->article->content}
                        <div class="row">
                            <a class="readmore" href="{route function='news' key=$box_article->getIdentifier() newsId=$box_article->getIdentifier() newsName=$box_article->article->name newsYear="Y"|date:$box_article->articleTimestamp newsMonth="m"|date:$box_article->articleTimestamp newsDay="d"|date:$box_article->articleTimestamp}">{translate key="read more"} &raquo;</a>
                        </div>
                    {/if}
                </article>
            {/foreach}
        </div>
    </div>
{/if}