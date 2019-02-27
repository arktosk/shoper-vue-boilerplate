{if false != $article_comments}
    <div class="box row tab" id="box_articlecomments">
        <div class="boxhead tab-head">
            <h3>
                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                {translate key="Post comments"} ({$article_comments|count})
            </h3>
        </div>

        <div class="innerbox tab-content tab-comments">
            {foreach from=$article_comments item=comment name=list}
                <div class="articlecomment" id="comment{$comment->getIdentifier()}" itemprop="review" itemscope itemtype=" {$schema}://schema.org/Review">
                    <div class="floatfix row">
                        <h5 class="reviewer" itemprop="author">{$comment->comment->user_name|escape}</h5>
                        <div class="date">{date value=$comment->comment->date}</div>
                    </div>
                    <p class="description row" itemprop="description">{$comment->comment->content|escape}</p>
                </div>
            {/foreach}

            <div id="commentform">
                {if $can_comment}
                    <form action="{route key='newsComment' newsId=$article->getIdentifier()}" method="post" class="comment multirow">
                        <fieldset>
                            {include file='formantispam.tpl'}

                            <label for="commentuser">{translate key="First and last name"}:</label>
                            <div class="f-row">
                                <input name="user" type="text" id="commentuser" value="{if $user_logged}{$user->user->getName()|escape}{else}{$data.user|escape}{/if}" size="30"  class="f-grid-12" >
                            </div>
                            {if $data_error.user}
                                <ul class="input_error">
                                    {foreach from=$data_error.user item=err_text}
                                        <li>{$err_text|escape}</li>
                                    {/foreach}
                                </ul>
                            {/if}

                            <label for="comment">{translate key="Your comment"}:</label>
                            <div class="f-row">
                                <textarea name="comment" id="comment" rows="5" cols="30" class="f-grid-12">{$data.comment|escape}</textarea>
                            </div>
                            {if $data_error.comment}
                                <ul class="input_error">
                                    {foreach from=$data_error.comment item=err_text}
                                        <li>{$err_text|escape}</li>
                                    {/foreach}
                                </ul>
                            {/if}

                            {if !$user_logged}
                            {$recaptcha}
                            {/if}

                            <button type="submit" class="btn">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                <span>{translate key="Send"}</span>
                            </button>

                        </fieldset>
                    </form>
                {/if}
            </div>
        </div>
    </div>
{/if}