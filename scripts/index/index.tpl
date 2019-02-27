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

                    {if $articles && count($articles) > 0}
                        {include file='news/listofarticles.tpl'}
                    {/if}

                    {if 'products' == $skin_settings->main->mode && count($products)}
                        <div class="box" id="box_mainproducts">
                            <div class="boxhead">
                                <h1 class="category-name row"><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{translate key="Recommended products"}</h1>

                                <div class="sort-and-view">
                                    {if 1 == $skin_settings->productlist->allowviewchange}
                                        <ul class="prodview inline text-right">
                                            <li class="photo{if 'phot' == $view} selected{/if}">
                                                <a class="fa fa-th" href="{route function='indexpage' key=0 page=1 sort=1 view='phot'}{if $google}?{$google|escape}{/if}" title="{translate key='Picture view'}"></a>
                                            </li>
                                            <li class="full{if 'full' == $view} selected{/if}">
                                                <a class="fa fa-th-list" href="{route function='indexpage' key=0 page=1 sort=1 view='full'}{if $google}?{$google|escape}{/if}" title="{translate key='Full view'}"></a>
                                            </li>
                                        </ul>
                                    {/if}
                                </div>

                                <div class="row search-info">                
                                    {if 'search' == $list_type}
                                        <b class="count">{translate key='Products found'}: {$products->getTotalItemCount()}</b>
                                    {/if}
                                </div>
                            </div>
                            
                            <div class="innerbox">
                                    {include file='product/tableofproducts.tpl'}
                                    {if $products->getTotalItemCount() > $products->getItemCountPerPage()}
                                        <div class="floatcenterwrap row">
                                            {include file='paginator.tpl'}
                                        </div>
                                    {/if}
                            </div>
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
