{if count($boxNs->$box_id->list)}
                    <div class="box{if 1 == $boxNs->$box_id->format} slider loading{if 1 == $boxNs->$box_id->automove} slider_automove{/if}{/if}" id="box_productoftheday">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}

                            {if $boxNs->$box_id->format < 3}
                            {foreach from=$boxNs->$box_id->list item=potd name=list}
                            <div data-product-id="{$potd->product->product_id}" data-category="{$potd->defaultCategory->translation->name|escape}" {if $potd->product->producer_id}data-producer="{$potd->producer->manufacturer->name|escape}"{/if} class="product row center">
                                <a href="{route function='product' key=$potd->getIdentifier() productName=$potd->translation->name productId=$potd->getIdentifier()
                                    }" title="{$potd->translation->name|escape}" class="row">                                    
                                    <span class="boximgsize row lazy-load">
                                        <img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs%3D" data-src="{imageUrl type='productGfx' width=$skin_settings->img->medium height=$skin_settings->img->medium image=$potd->mainImageName() overlay=1}" alt="{$potd->translation->name|escape}">

                                        <noscript>
                                            <img src="{imageUrl type='productGfx' width=$skin_settings->img->medium height=$skin_settings->img->medium image=$potd->mainImageName() overlay=1}" alt="{$potd->translation->name|escape}">
                                        </noscript>
                                    </span>
                                    <div class="productnamewrap row">
                                        <span class="productname">{$potd->translation->name|escape}</span>
                                    </div>
                                </a>
                                <div class="price row">    
                                    {if $showprices}
                                        {if $price_mode == '1' || $price_mode == '3'}
                                            {if $potd->specialOffer}
                                                <del>{currency value=$potd->defaultStock->getPrice()}</del>
                                                <em class="color">{currency value=$potd->defaultStock->getSpecialOfferPrice()}</em>
                                                {if $potd->currency and $currency->getIdentifier() != $potd->currency->getIdentifier()}
                                                    <em>({currency id=$potd->product->currency_id rate=1 value=$potd->defaultStock->getCurrencySpecialOfferPrice()})</em>
                                                {/if}
                                            {else}
                                                <em>{currency value=$potd->defaultStock->getPrice()}</em>
                                                {if $potd->currency and $currency->getIdentifier() != $potd->currency->getIdentifier()}
                                                    <em>({currency id=$potd->product->currency_id rate=1 value=$potd->defaultStock->getCurrencyPrice()})</em>
                                                {/if}
                                            {/if}
                                        {/if}

                                        {if $price_mode != '3'}
                                            {if $price_mode != '2'}
                                                <span class="hide price-netto">
                                            {/if}
                                                {if $potd->specialOffer}
                                                    <del>{currency value=$potd->defaultStock->getPrice(true)}</del>
                                                    <em class="color">{currency value=$potd->defaultStock->getSpecialOfferPrice(true)}</em>
                                                    {if $potd->currency and $currency->getIdentifier() != $potd->currency->getIdentifier()}
                                                        <em>({currency id=$potd->product->currency_id rate=1 value=$potd->defaultStock->getCurrencySpecialOfferPrice(true)})</em>
                                                    {/if}
                                                {else}
                                                    <em>{currency value=$potd->defaultStock->getPrice(true)}</em>
                                                    {if $potd->currency and $currency->getIdentifier() != $potd->currency->getIdentifier()}
                                                        <em>({currency id=$potd->product->currency_id rate=1 value=$potd->defaultStock->getCurrencyPrice(true)})</em>
                                                    {/if}
                                                {/if}
                                            {if $price_mode != '2'}
                                                </span>
                                            {/if}
                                        {/if}
                                    {/if}
                                </div>
                                
                                {if ($enable_availability_notifier && $potd->isEnabledNotifier()) || $enablebasket && $potd->canBuyStock()}
                                    {if true == $potd->defaultStockOnly()}
                                        <form class="basket basket-box {if $loyalty_exchange}loyaltyexchange{/if}" action="{route key=$basketAddRoute stockId='post'}" method="post">
                                    {else}
                                        <form class="basket basket-box {if $loyalty_exchange}loyaltyexchange{/if}" action="{route key=$basketAddRoute stockId=$potd->defaultStock->getIdentifier()}" method="get">
                                    {/if}

                                        {if $enablebasket && $potd->canBuyStock()}
                                            <fieldset>
                                                {if true == $potd->defaultStockOnly()}
                                                <div class="shaded_inputwrap"><input name="quantity" value="{float precision=$QUANTITY_PRECISION value=1 trim=true}" type="text" class="short center"></div>
                                                <span class="unit">{$potd->unit->translation->name|escape}</span>
                                                <input type="hidden" value="{$potd->defaultStock->getIdentifier()|escape}" name="stock_id">
                                                {/if}
                                                {if !$potd->isBundle()}
                                                    <button class="addtobasket btn btn-red" type="submit">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                        <span>{if $loyalty_exchange}{translate key="Exchange"}{else}{translate key="Add to cart"}{/if}</span>
                                                    </button>
                                                {else}
                                                    <a class="btn btn-red" href="{route function='product' key=$potd->getIdentifier() productName=$potd->translation->name productId=$potd->getIdentifier()
                                    }">{translate key="check more"}</a>
                                                {/if}
                                            </fieldset>
                                        {elseif $enable_availability_notifier && $potd->isEnabledNotifier()}
                                            {dynamic}
                                                {assign var="availabilityNotifyUser" value=$potd->defaultStock->getAvailabilityNotifyByUser()}
                                                <fieldset class="availability-notifier-container{if $availabilityNotifyUser != null} none{/if}">
                                                    <button class="availability-notifier-btn btn btn-red" type="submit" data-is-logged="{if true == $user_logged}true{else}false{/if}" data-stock-id="{$potd->defaultStock->getIdentifier()}" data-product-id="{$potd->product->product_id}" data-product-name="{$potd->translation->name|escape}">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                        <span>{translate key="Notify of product availability"}</span>
                                                    </button>
                                                </fieldset>
                                                {if true == $user_logged}
                                                    <fieldset class="availability-notifier-unsubscribe-container{if $availabilityNotifyUser == null} none{/if}">
                                                        <button type="submit" class="availability-notifier-unsubscribe-btn btn btn-red" data-stock-id="{$potd->defaultStock->stock->stock_id}">
                                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                            <span>{translate key="Cancel notify"}</span>
                                                        </button>
                                                    </fieldset>
                                                {/if}
                                            {/dynamic}
                                        {/if}
                                    </form>
                                {/if}
                            </div>
                            {/foreach}
                            {else}
                            <ol class="productlist">
                            {foreach from=$boxNs->$box_id->list item=potd name=list}
                                <li data-product-id="{$potd->product->product_id}"><a href="{route function='product' key=$potd->getIdentifier() productName=$potd->translation->name productId=$potd->getIdentifier()
                                    }" title="{$potd->translation->name|escape}">{$potd->translation->name|escape}</a></li>
                            {/foreach}
                            </ol>
                            {/if}
                        </div>
                    </div>
{/if}
