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

                    <div class="box" id="box_favourites">
                        <div class="boxhead">
                            <span>
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                {translate key="Products on wishlist"}
                            </span>
                        </div>

                        <div class="innerbox">
                            <table class="favourites classic table">
                                <thead>
                                    <tr>
                                        <td class="name">{translate key='Name'}</td>
                                        <td class="price">{translate key='Price'}</td>
                                        {if 1 == $skin_settings->productdetails->availability}
                                            <td class="sum">{translate key='Availability status'}</td>
                                        {/if}
                                        <td class="actions">{translate key='Actions'}</td>
                                    </tr>
                                </thead>

                                <tbody>
                                    {foreach from=$user->user->favourites item=product name=list}
                                        {assign var=id value=$product->getIdentifier()}

                                        <tr class="{if $smarty.foreach.list.index % 2}odd{else}even{/if}">
                                            <td class="name">
                                                <a class="name" href="{route function='product' key=$product->product->getIdentifier() productName=$product->product->translation->name
                                                    productId=$product->product->getIdentifier()}" title="{$product->translation->name|escape}">
                                                    {$product->product->translation->name|escape}
                                                </a>
                                                <span class="variant">{$product->getName()|escape}</span>
                                            </td>

                                            <td class="cell-center price">
                                                {if $product->product->specialOffer}
                                                    {currency value=$product->getSpecialOfferPrice()}
                                                    {if $product->product->currency and $currency->getIdentifier() != $product->product->currency->getIdentifier()}
                                                        <em class="default-currency">({currency id=$product->product->product->currency_id rate=1 value=$product->getCurrencySpecialOfferPrice()})</em>
                                                    {/if}
                                                {else}
                                                    {currency value=$product->getPrice()}
                                                    {if $product->product->currency and $currency->getIdentifier() != $product->product->currency->getIdentifier()}
                                                        <em class="default-currency">({currency id=$product->product->product->currency_id rate=1 value=$product->getCurrencyPrice()})</em>
                                                    {/if}
                                                {/if}
                                            </td>

                                            {if 1 == $skin_settings->productdetails->availability}
                                                <td class="sum">
                                                    {if $product->availability && $product->availability->translation}
                                                        {if $product->availability->availability->photo}
                                                        <img src="{baseDir}/{$product->availability->getUrl()}" alt="" /> {/if
                                                        }{$product->availability->translation->name|escape}
                                                    {else}
                                                        -
                                                    {/if}
                                                </td>
                                            {/if}

                                            <td class="actions">
                                                {if true == $enablebasket && 1 == (int) $product->availability->availability->can_buy}
                                                    <a href="
                                                        {if $product->product->isBundle()}
                                                            {route function='product' key=$product->product->getIdentifier() productName=$product->product->translation->name
                                                    productId=$product->product->getIdentifier()}
                                                        {else}
                                                            {route key=$basketAddRoute stockId=$id}" title="{translate key='add to cart'}
                                                        {/if}
                                                    " class="btn btn-red2 addtobasket spanhover">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                        <span>
                                                            {if $product->product->isBundle()}
                                                                {translate key='check more'}
                                                            {else}
                                                                {translate key='add to cart'}
                                                            {/if}
                                                        </span>
                                                    </a>
                                                {elseif $enable_availability_notifier && $product->product->isEnabledNotifier()}
                                                    {dynamic}
                                                        {assign var="availabilityNotifyUser" value=$product->getAvailabilityNotifyByUser()}
                                                        <div class="availability-notifier-unsubscribe-container{if $availabilityNotifyUser == null} none{/if}">
                                                            <a href="#" data-stock-id="{$product->stock->stock_id}" title="{translate key="cancel notify"}" class="btn btn-red2 availability-notifier-unsubscribe-btn spanhover">
                                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                                <span>{translate key='cancel notify'}</span>
                                                            </a>
                                                        </div>
                                                            
                                                        <div class="availability-notifier-container{if $availabilityNotifyUser} none{/if}">
                                                            <a href="#" data-is-logged="{if true == $user_logged}true{else}false{/if}" data-product-id="{$product->product->product->product_id}" data-stock-id="{$product->stock->stock_id}" data-product-name="{$product->product->translation->name|escape}" title="{translate key="notify of product availability"}" class="btn btn-red2 availability-notifier-btn spanhover">
                                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                                <span>{translate key='notify of product availability'}</span>
                                                            </a>
                                                        </div>
                                                    {/dynamic}
                                                {/if}
                                                
                                                <a href="{route key='panelRemoveFavourite' stockId=$id}" title="{translate key='remove'}" class="btn remove spanhover">
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                    <span>{translate key='remove'}</span>
                                                </a>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
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
