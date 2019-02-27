{if count($boxNs->$box_id->list)}
        <div class="box{if 1 == $boxNs->$box_id->format} slider loading{if 1 == $boxNs->$box_id->automove} slider_automove{/if}{/if}" id="box_recent">
            <div class="boxhead">
                <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
            </div>
            <div class="innerbox">
                {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}

                {if $boxNs->$box_id->format < 3}
                {foreach from=$boxNs->$box_id->list item=special_product name=list}
                <div data-product-id="{$special_product->product->product_id}" data-category="{$special_product->defaultCategory->translation->name|escape}" {if $special_product->product->producer_id}data-producer="{$special_product->producer->manufacturer->name|escape}"{/if} class="product row center">
                    <a href="{route function='product' key=$special_product->getIdentifier() productName=$special_product->translation->name productId=$special_product->getIdentifier()
                        }" title="{$special_product->translation->name|escape}" class="row">
                        <span class="boximgsize row lazy-load">
                            <img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs%3D" data-src="{imageUrl type='productGfx' width=$skin_settings->img->medium height=$skin_settings->img->medium image=$special_product->mainImageName() overlay=1}" alt="{$special_product->translation->name|escape}">

                            <noscript>
                                <img src="{imageUrl type='productGfx' width=$skin_settings->img->medium height=$skin_settings->img->medium image=$special_product->mainImageName() overlay=1}" alt="{$special_product->translation->name|escape}">
                            </noscript>
                        </span>
                        <div class="productnamewrap row">
                            <span class="productname">{$special_product->translation->name|escape}</span>
                        </div>
                    </a>

                    <div class="price row">
                        {if $showprices}
                            {if $price_mode == '1' || $price_mode == '3'}
                                {if $special_product->specialOffer}
                                    <del>{currency value=$special_product->defaultStock->getPrice()}</del>
                                    <em class="color">{currency value=$special_product->defaultStock->getSpecialOfferPrice()}</em>
                                    {if $special_product->currency and $currency->getIdentifier() != $special_product->currency->getIdentifier()}
                                        <em>({currency id=$special_product->product->currency_id rate=1 value=$special_product->defaultStock->getCurrencySpecialOfferPrice()})</em>
                                    {/if}
                                {else}
                                    <em>{currency value=$special_product->defaultStock->getPrice()}</em>
                                    {if $special_product->currency and $currency->getIdentifier() != $special_product->currency->getIdentifier()}
                                        <em>({currency id=$special_product->product->currency_id rate=1 value=$special_product->defaultStock->getCurrencyPrice()})</em>
                                    {/if}
                                {/if}
                            {/if}

                            {if $price_mode != '3'}
                                {if $price_mode != '2'}
                                    <span class="hide price-netto">
                                {/if}
                                    {if $special_product->specialOffer}
                                        <del>{currency value=$special_product->defaultStock->getPrice(true)}</del>
                                        <em class="color">{currency value=$special_product->defaultStock->getSpecialOfferPrice(true)}</em>
                                        {if $special_product->currency and $currency->getIdentifier() != $special_product->currency->getIdentifier()}
                                            <em>({currency id=$special_product->product->currency_id rate=1 value=$special_product->defaultStock->getCurrencySpecialOfferPrice(true)})</em>
                                        {/if}
                                    {else}
                                        <em>{currency value=$special_product->defaultStock->getPrice(true)}</em>
                                        {if $special_product->currency and $currency->getIdentifier() != $special_product->currency->getIdentifier()}
                                            <em>({currency id=$special_product->product->currency_id rate=1 value=$special_product->defaultStock->getCurrencyPrice(true)})</em>
                                        {/if}
                                    {/if}
                                {if $price_mode != '2'}
                                    </span>
                                {/if}
                            {/if}
                        {/if}
                    </div>

                    {if ($enable_availability_notifier && $special_product->isEnabledNotifier()) || $enablebasket && $special_product->canBuyStock()}
                        {if true == $special_product->defaultStockOnly()}
                            <form class="basket basket-box {if $loyalty_exchange}loyaltyexchange{/if}" action="{route key=$basketAddRoute stockId='post'}" method="post">
                        {else}
                            <form class="basket basket-box {if $loyalty_exchange}loyaltyexchange{/if}" action="{route key=$basketAddRoute stockId=$special_product->defaultStock->getIdentifier()}" method="get">
                        {/if}

                            {if $enablebasket && $special_product->canBuyStock()}
                                <fieldset>
                                    {if true == $special_product->defaultStockOnly()}
                                        <div class="shaded_inputwrap"><input name="quantity" value="{float precision=$QUANTITY_PRECISION value=1 trim=true}" type="text" class="short center"></div>
                                        <span class="unit">{$special_product->unit->translation->name|escape}</span>
                                        <input type="hidden" value="{$special_product->defaultStock->getIdentifier()|escape}" name="stock_id">
                                    {/if}
                                    
                                    {if !$special_product->isBundle()}
                                        <button class="addtobasket btn btn-red" type="submit">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                            <span>{if $loyalty_exchange}{translate key="Exchange"}{else}{translate key="Add to cart"}{/if}</span>
                                        </button>
                                    {else}
                                        <a class="btn btn-red" href="{route function='product' key=$special_product->getIdentifier() productName=$special_product->translation->name productId=$special_product->getIdentifier()
                        }">{translate key="check more"}</a>
                                    {/if}
                                </fieldset>
                            {elseif $enable_availability_notifier && $special_product->isEnabledNotifier()}
                                {dynamic}
                                    {assign var="availabilityNotifyUser" value=$special_product->defaultStock->getAvailabilityNotifyByUser()}
                                    <fieldset class="availability-notifier-container{if $availabilityNotifyUser != null} none{/if}">
                                        <button class="availability-notifier-btn btn btn-red" type="submit" data-is-logged="{if true == $user_logged}true{else}false{/if}" data-stock-id="{$special_product->defaultStock->getIdentifier()}" data-product-id="{$special_product->product->product_id}" data-product-name="{$special_product->translation->name|escape}">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                            <span>{translate key="Notify of product availability"}</span>
                                        </button>
                                    </fieldset>
                                    {if true == $user_logged}
                                        <fieldset class="availability-notifier-unsubscribe-container{if $availabilityNotifyUser == null} none{/if}">
                                            <button type="submit" class="availability-notifier-unsubscribe-btn btn btn-red" data-stock-id="{$special_product->defaultStock->stock->stock_id}">
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
                {foreach from=$boxNs->$box_id->list item=special_product name=list}
                    <li data-product-id="{$special_product->product->product_id}"><a href="{route function='product' key=$special_product->getIdentifier() productName=$special_product->translation->name productId=$special_product->getIdentifier()
                        }" title="{$special_product->translation->name|escape}">{$special_product->translation->name|escape}</a></li>
                {/foreach}
                </ol>
                {/if}
            </div>
        </div>
{/if}
