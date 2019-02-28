{if count($boxNs->$box_id->list)}
                    <div class="box{if 3 == $boxNs->$box_id->format} slider loading{if 1 == $boxNs->$box_id->automove} slider_automove{/if}{/if}" id="box_lastadded">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if $boxNs->$box_id->format == 2}
                                <ol class="productlist">
                                    {foreach from=$boxNs->$box_id->list item=newproduct name=list}
                                    <li data-product-id="{$newproduct->product->product_id}"><a href="{route function='product' key=$newproduct->getIdentifier() productName=$newproduct->translation->name productId=$newproduct->getIdentifier()
                                        }" title="{$newproduct->translation->name|escape}">{$newproduct->translation->name|escape}</a></li>
                                    {/foreach}
                                </ol>
                            {else}
                                {foreach from=$boxNs->$box_id->list item=newproduct name=list}
                                    <div data-product-id="{$newproduct->product->product_id}" data-category="{$newproduct->defaultCategory->translation->name|escape}" {if $newproduct->product->producer_id}data-producer="{$newproduct->producer->manufacturer->name|escape}"{/if} class="product row center">
                                        <a href="{route function='product' key=$newproduct->getIdentifier() productName=$newproduct->translation->name productId=$newproduct->getIdentifier()
                                            }" title="{$newproduct->translation->name|escape}" class="row">
                                            <span class="boximgsize row lazy-load">
                                                <img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs%3D" data-src="{imageUrl type='productGfx' width=$skin_settings->img->medium height=$skin_settings->img->medium image=$newproduct->mainImageName() overlay=1}" alt="{$newproduct->translation->name|escape}">

                                                <noscript>
                                                    <img src="{imageUrl type='productGfx' width=$skin_settings->img->medium height=$skin_settings->img->medium image=$newproduct->mainImageName() overlay=1}" alt="{$newproduct->translation->name|escape}">
                                                </noscript>
                                            </span>
                                            <div class="productnamewrap row">
                                                <span class="productname">{$newproduct->translation->name|escape}</span>
                                            </div>
                                        </a>

                                        <div class="price row">
                                        {if $showprices}
                                            {if $price_mode == '1' || $price_mode == '3'}
                                                {if $newproduct->specialOffer}
                                                    <del>{currency value=$newproduct->defaultStock->getPrice()}</del>
                                                    <em class="color">{currency value=$newproduct->defaultStock->getSpecialOfferPrice()}</em>
                                                    {if $newproduct->currency and $currency->getIdentifier() != $newproduct->currency->getIdentifier()}
                                                        <em>({currency id=$newproduct->product->currency_id rate=1 value=$newproduct->defaultStock->getCurrencySpecialOfferPrice()})</em>
                                                    {/if}
                                                {else}
                                                    <em>{currency value=$newproduct->defaultStock->getPrice()}</em>
                                                    {if $newproduct->currency and $currency->getIdentifier() != $newproduct->currency->getIdentifier()}
                                                        <em>({currency id=$newproduct->product->currency_id rate=1 value=$newproduct->defaultStock->getCurrencyPrice()})</em>
                                                    {/if}
                                                {/if}
                                            {/if}

                                            {if $price_mode != '3'}
                                                {if $price_mode != '2'}
                                                    <span class="hide price-netto">
                                                {/if}
                                                    {if $newproduct->specialOffer}
                                                        <del>{currency value=$newproduct->defaultStock->getPrice(true)}</del>
                                                        <em class="color">{currency value=$newproduct->defaultStock->getSpecialOfferPrice(true)}</em>
                                                        {if $newproduct->currency and $currency->getIdentifier() != $newproduct->currency->getIdentifier()}
                                                            <em>({currency id=$newproduct->product->currency_id rate=1 value=$newproduct->defaultStock->getCurrencySpecialOfferPrice(true)})</em>
                                                        {/if}
                                                    {else}
                                                        <em>{currency value=$newproduct->defaultStock->getPrice(true)}</em>
                                                        {if $newproduct->currency and $currency->getIdentifier() != $newproduct->currency->getIdentifier()}
                                                            <em>({currency id=$newproduct->product->currency_id rate=1 value=$newproduct->defaultStock->getCurrencyPrice(true)})</em>
                                                        {/if}
                                                    {/if}
                                                {if $price_mode != '2'}
                                                    </span>
                                                {/if}
                                            {/if}
                                        {/if}
                                        </div>

                                        {if ($enable_availability_notifier && $newproduct->isEnabledNotifier()) || $enablebasket && $newproduct->canBuyStock()}
                                            {if true == $newproduct->defaultStockOnly()}
                                                <form class="basket basket-box {if $loyalty_exchange}loyaltyexchange{/if}" action="{route key=$basketAddRoute stockId='post'}" method="post">
                                            {else}
                                                <form class="basket basket-box {if $loyalty_exchange}loyaltyexchange{/if}" action="{route key=$basketAddRoute stockId=$newproduct->defaultStock->getIdentifier()}" method="get">
                                            {/if}

                                                {if $enablebasket && $newproduct->canBuyStock()}
                                                    <fieldset>
                                                        {if true == $newproduct->defaultStockOnly()}
                                                        <div class="shaded_inputwrap"><input name="quantity" value="{float precision=$QUANTITY_PRECISION value=1 trim=true}" type="text" class="short center"></div>
                                                        <span class="unit">{$newproduct->unit->translation->name|escape}</span>
                                                        <input type="hidden" value="{$newproduct->defaultStock->getIdentifier()|escape}" name="stock_id">
                                                        {/if}

                                                        {if !$newproduct->isBundle()}
                                                            <button class="addtobasket btn btn-red" type="submit">
                                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                                <span>{if $loyalty_exchange}{translate key="Exchange"}{else}{translate key="Add to cart"}{/if}</span>
                                                            </button>
                                                        {else}
                                                            <a class="btn btn-red" href="{route function='product' key=$newproduct->getIdentifier() productName=$newproduct->translation->name productId=$newproduct->getIdentifier()
                                            }">{translate key="check more"}</a>
                                                        {/if}
                                                    </fieldset>
                                                {elseif $enable_availability_notifier && $newproduct->isEnabledNotifier()}
                                                    {dynamic}
                                                        {assign var="availabilityNotifyUser" value=$newproduct->defaultStock->getAvailabilityNotifyByUser()}
                                                        <fieldset class="availability-notifier-container{if $availabilityNotifyUser != null} none{/if}">
                                                            <button class="availability-notifier-btn btn btn-red" type="submit" data-is-logged="{if true == $user_logged}true{else}false{/if}" data-stock-id="{$newproduct->defaultStock->getIdentifier()}" data-product-id="{$newproduct->product->product_id}" data-product-name="{$newproduct->translation->name|escape}">
                                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                                <span>{translate key="Notify of product availability"}</span>
                                                            </button>
                                                        </fieldset>
                                                        {if true == $user_logged}
                                                            <fieldset class="availability-notifier-unsubscribe-container{if $availabilityNotifyUser == null} none{/if}">
                                                                <button type="submit" class="availability-notifier-unsubscribe-btn btn btn-red" data-stock-id="{$newproduct->defaultStock->stock->stock_id}">
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
                            {/if}
                        </div>
                    </div>
{/if}
