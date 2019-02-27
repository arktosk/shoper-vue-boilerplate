{$snippet_pre_body}

<div class="wrap rwd">
    <header class="row checkout">
        <div class="logo-bar row container">
            <a href="{baseDir nonempty=1}" title="{translate key='Home page'}" class="link-logo {if $seo_has_blank_logo}link-logo-text{else}link-logo-img{/if}">
                {if $seo_has_blank_logo}
                    {$seo_logo_title|escape}
                {else}
                    <img src="{$path}images/logo.png" alt="{$seo_logo_title|escape}">
                {/if}
            </a>

             <div class="basket-steps{if $shipping_extra_step || $breadcrumbs->getBreadCrumbs()|@count > 5} extra-step{/if}">
                <ol>
                    {if $body_class == 'shop_basket_finished'}
                        <li class="mark-green">
                            <span>{translate key="Cart"}</span>
                        </li>
                   

                        <li class="mark-green">
                            <span>{translate key="Your details"}</span>
                        </li>
                    {/if}

                    {foreach from=$breadcrumbs->getBreadCrumbs() item=item name=bclist}
                        {if $smarty.foreach.bclist.index != 0}
                            <li class="{if $smarty.foreach.bclist.last}active-step{/if}{if $item.url || $breadcrumbs->getBreadCrumbs()|@count >= 4} mark-green{/if}">
                                {if $item.url}<a href="{$item.url|escape}">{/if}  
                                    <span>{$item.name}</span>
                                {if $item.url}</a>{/if}
                            </li>
                        {/if}
                    {/foreach}

                    {if $breadcrumbs->getBreadCrumbs()|@count <= 3 && $shipping_extra_step}
                        <li {if $body_class == 'shop_basket_finished'}class="mark-green"{/if}>
                            <span>{translate key="Payment & Shipping"}</span>
                        </li>
                    {/if}

                    {if $breadcrumbs->getBreadCrumbs()|@count <= 3 || $shipping_extra_step}
                        <li {if $body_class == 'shop_basket_finished'}class="mark-green"{/if}>
                            <span>{translate key="Summary"}</span>
                        </li>
                    {/if}

                    {if $breadcrumbs->getBreadCrumbs()|@count <= 4}
                        <li {if $body_class == 'shop_basket_finished'}class="mark-green"{/if}>
                            <span>{translate key="Confirmation"}</span>
                        </li>
                    {/if}
                </ol>
            </div>
        </div>
    </header>

    {dynamic}
        {include file='flash_messages.tpl'}
    {/dynamic}

    {if $boxes_header_side|@count > 0}
        <div class="top row">
            <div class="container">
                {dynamic}
                    {foreach from=$boxes_header_side item=v key=k}
                        {box file="../boxes/$v/box.tpl" box="$k"}
                    {/foreach}
                {/dynamic}
            </div>
        </div>
    {/if}