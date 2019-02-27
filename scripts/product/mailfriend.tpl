{include file='header.tpl'}
<body{if $body_id} id="{$body_id|escape}"{/if}{if $body_class} class="{$body_class|escape}"{/if}>
    {include file='body_head.tpl'}
    <div class="main row">
        <div class="innermain container">
            <div class="s-row">
                {if 0 < $boxes_left_side|@count}
                    <div class="leftcol s-grid-3">
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

                    <div class="box" id="box_mailfriend">
                        <div class="boxhead">
                            <h3><img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >{translate key="Recommend product to a friend"}</h3>
                        </div>

                        <div class="innerbox">
                            <form action="{route key='productMailFriend' productId=$prod_id}" method="post" class="multirow">
                                <fieldset>
                                    <label for="from">{translate key="Your e-mail address"}:</label>

                                    <div class="shaded_inputwrap">
                                        <input type="text" name="from" id="from" value="{$data.from|escape}" size="30" class="{if $data_error.from}error{/if}" >

                                        {if $data_error.from}
                                            <ul class="error row">
                                                {foreach from=$data_error.from item=err_text}
                                                    <li>{$err_text|escape}</li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    </div>

                                    <label for="email">{translate key="Friend's e-mail address"}:</label>

                                    <div class="shaded_inputwrap">
                                        <input type="text" name="email" id="email" value="{$data.email|escape}" size="30" class="{if $data_error.email}error{/if}">

                                        {if $data_error.email}
                                            <ul class="row error">
                                                {foreach from=$data_error.email item=err_text}
                                                    <li>{$err_text|escape}</li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    </div>

                                    {$recaptcha}
                                    
                                    <button type="submit" class="btn send">
                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                        <span>{translate key="Send"}</span>
                                    </button>
                                </fieldset>
                            </form>
                        </div>
                    </div>

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