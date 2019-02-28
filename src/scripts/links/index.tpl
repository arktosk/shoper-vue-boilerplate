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

                    {if count($links) > 0}
                        <div class="box" id="box_links">
                            <div class="boxhead">
                                <h3><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{translate key="Links"}</h3>
                            </div>

                            <div class="innerbox">
                                <ul class="links">
                                    <li class="row">
                                        {foreach from=$links item=link name=list}
                                            {if $link->link->photo}
                                                <img src="{imageUrl type='links' image=$link->link->photo}" alt="{$link->link->name|escape}">
                                            {/if}

                                            <a href="{route key='linksRedirect' linkId=$link->getIdentifier()}" title="{$link->link->name|escape}">{$link->link->name|escape}</a>

                                            {if $link->link->short_description}
                                                <p class="description">{$link->link->short_description|escape}</p>
                                            {/if}
                                        {/foreach}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    {else}
                        <div class="alert-info alert">
                            <p>{translate key="No links have been found."}</p>
                        </div>
                    {/if}

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
