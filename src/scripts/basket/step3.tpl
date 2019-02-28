{include file='header.tpl'}
<body{if $body_id} id="{$body_id|escape}"{/if}{if $body_class} class="{$body_class|escape}"{/if}>
{include file='body_head_checkout.tpl'}
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

                    <div class="box unibox" id="box_basketsummary">
                        <div class="innerbox">
                                <table class="productlist table zebra classic">
                                    <thead>
                                        <tr>
                                            <td class="rwd-hide-medium rwd-hide-small img"></td>
                                            <td class="name">{translate key="Product"}</td>
                                            {if $showDelivery}
                                                <td class="time rwd-hide-medium rwd-hide-small">{translate key="Dispatched within"}</td>
                                            {/if}
                                            <td class="quantity">{translate key="Quantity"}</td>
                                            <td class="price">{translate key="Price"}</td>
                                            <td class="sum">{translate key="Value"}</td>
                                        </tr>
                                    </thead>

                                    <tbody>
                                    {foreach from=$user->basket item=basket_product}
                                        {if !$basket_product->isChild()}
                                            <tr data-product-id="{$basket_product->product->product->product_id}" data-category="{$basket_product->product->defaultCategory->translation->name|escape}" {if $basket_product->product->product->producer_id}data-producer="{$basket_product->product->producer->manufacturer->name|escape}"{/if}>
                                                <td class="img rwd-hide-medium rwd-hide-small">
                                                    <img src="{imageUrl type='productGfx' width=75 height=75 image=$basket_product->stock->mainImageName() overlay=1}" alt="{$basket_product->product->translation->name|escape}">
                                                </td>
                                                <td class="name">
                                                    {if !$basket_product->isChild()}
                                                        <a href="{route function='product' key=$basket_product->product->product->product_id productName=$basket_product->product->translation->name
                                                                productId=$basket_product->product->product->product_id}" title="{$basket_product->product->translation->name|escape}">{$basket_product->product->translation->name|escape}</a>
                                                        <span class="variant">{$basket_product->getName()|escape}</span>
                                                    {/if}

                                                    {if $basket_product->isParent()}
                                                        {if count($basket_product->getChildren())}
                                                            <div class="bundle-products">
                                                                {foreach from=$basket_product->getChildren() item=bundle}
                                                                    <p>
                                                                        <span class="bundle-product-name">{$bundle->product->translation->name|escape}</span>
                                                                        <span class="variant">{$bundle->getName()|escape}</span>
                                                                    </p>
                                                                {/foreach}
                                                            </div>
                                                        {/if}
                                                    {/if}
                                                </td>
                                                {if $showDelivery}
                                                    <td class="time rwd-hide-medium rwd-hide-small">{$basket_product->stock->delivery->translation->name|escape}</td>
                                                {/if}
                                                <td class="quantity">
                                                    {assign var=id value=$basket_product->getIdentifier()}
                                                    {float precision=$QUANTITY_PRECISION value=$basket_product->basket->quantity trim=true}
                                                    {$basket_product->product->unit->translation->name|escape}
                                                </td>
                                                <td class="price">{currency value=$basket_product->getPrice()}</td>
                                                <td class="sum">
                                                    <em class="color">{currency value=$basket_product->getPriceForAll()}</em>
                                                </td>
                                            </tr>
                                        {/if}
                                    {/foreach}
                                    </tbody>
                                </table>

                                <div class="clear overflow">
                                    <div class="address delivery">
                                        <h4 class="separator delivery">{translate key="Delivery address"}</h4>
                                        <div class="delivery-details">
                                        {if $shipping->handler->isOverwriteDeliveryAddress()}
                                            {plugin module=shop template=basket-address-delivery-overwrite-rwd}
                                        {else}
                                            {if $data.name2 || $data.surname2}
                                                <p>
                                                    {if $data.name2}
                                                        {$data.name2|escape} 
                                                    {/if}
                                                    {if $data.surname2}
                                                        {$data.surname2|escape}
                                                    {/if}
                                                </p>
                                            {/if}

                                            {if $data.coname2}
                                                <p>{$data.coname2|escape}</p>
                                            {/if}

                                            {if $data.nip2}
                                                <p>{translate key='Tax ID'}: {$data.nip2|escape}</p>
                                            {/if}

                                            {if $data.other_address2}
                                                <p>{$data.other_address2|escape}</p>
                                            {/if}

                                            {if $data.zip2 || $data.city2}
                                                <p>
                                                    {if $data.zip2}
                                                        {$data.zip2|escape}, 
                                                    {/if}
                                                    {if $data.city2}
                                                        {$data.city2|escape}
                                                    {/if}
                                                </p>
                                            {/if}

                                            {if $data.state2}
                                                <p>{$data.state2|escape}</p>
                                            {/if}

                                            {if $data.country2}
                                                <p>{country code=$data.country2}</p>
                                            {/if}

                                            {if $data.phone2}
                                                <p>{$data.phone2|escape}</p>
                                            {/if}
                                        {/if}

                                            <p>
                                                {if $data.mode == 'single'}
                                                    <a href="{route key='basketNoRegister'}">({translate key="change"})</a>
                                                {elseif $data.mode == 'register'}
                                                    <a href="{route key='basketRegister'}">({translate key="change"})</a>
                                                {else}
                                                    <a href="{route key='basketStep2'}">({translate key="change"})</a>
                                                {/if}
                                            </p>
                                        </div>

                                        {if $pocztaPolskaPickupPointsIds}
                                            <div data-pp-pick-up-points class="pp-pick-up-points">
                                                <input type="hidden" name="pp-pick-up-points-delveries" id="pp-pick-up-points-delveries" value="{$pocztaPolskaPickupPointsIds|escape}">
                                                <input type="hidden" name="pp-pick-up-points-apikey" id="pp-pick-up-points-apikey" value="{$pocztaPolskaGmapApikey|escape}">
                                                {if $pocztaPolskaPickupPoint}
                                                    <input type="hidden" name="pp-pick-up-point" id="pp-pick-up-point" value="{$pocztaPolskaPickupPoint|escape}">
                                                {/if}
                                            </div>
                                        {/if}
                                    </div>

                                    <div class="address invoice">
                                        <h4 class="separator invoice2">{translate key="Billing address"}</h4>

                                        {if 1 == $data.address_type && ($data.name || $data.surname)}
                                            <p>
                                                {if $data.name}
                                                    {$data.name|escape}
                                                {/if}
                                                {if $data.surname}
                                                    {$data.surname|escape}
                                                {/if}
                                            </p>
                                        {/if}

                                        {if $data.coname}
                                            <p>{$data.coname|escape}</p>
                                        {/if}

                                        {if $data.nip}
                                            <p>{translate key='Tax ID'}: {$data.nip|escape}</p>
                                        {/if}

                                        {if $data.other_address}
                                            <p>{$data.other_address|escape}</p>
                                        {/if}

                                        {if $data.zip || $data.city}
                                            <p>
                                                {if $data.zip}
                                                    {$data.zip|escape},
                                                {/if}
                                                {if $data.city}
                                                    {$data.city|escape}
                                                {/if}
                                            </p>
                                        {/if}

                                        {if $data.pesel}
                                            <p>{translate key='Personal Identification Number'}: {$data.pesel|escape}</p>
                                        {/if}

                                        {if $data.state}
                                            <p>{$data.state|escape}</p>
                                        {/if}

                                        {if $data.country}
                                            <p>{country code=$data.country}</p>
                                        {/if}

                                        {if $data.phone}
                                            <p>{$data.phone|escape}</p>
                                        {/if}

                                        <p>
                                            {if $data.mode == 'single'}
                                                <a href="{route key='basketNoRegister'}">({translate key="change"})</a>
                                            {elseif $data.mode == 'register'}
                                                <a href="{route key='basketRegister'}">({translate key="change"})</a>
                                            {else}
                                                <a href="{route key='basketStep2'}">({translate key="change"})</a>
                                            {/if}
                                        </p>
                                    </div>

                                    <div class="address information">
                                        <h4 class="separator information">{translate key="Information"}</h4>
                                        <ul>
                                            {if $delivery}
                                                <li class="date">
                                                    <span>
                                                        {translate key='Expected shipping date'}:
                                                        <strong class="date">{$delivery->translation->name|escape}</strong>
                                                    </span>
                                                </li>
                                            {/if}

                                            <li class="delivery">
                                                <span>
                                                    {translate key='Selected form of delivery'}:
                                                    <strong class="delivery">{$shipping->translation->name|escape}</strong> <a href="{if $shipping_extra_step == 1}{route key='basketStep3'}{else}{route key='basket'}{/if}">({translate key="change"})</a>
                                                </span>
                                            </li>

                                            <li class="payment">
                                                <span>
                                                    {translate key='Selected form of payment'}:
                                                    <strong class="payment">{$payment->handler->getName()|escape}</strong> <a href="{if $shipping_extra_step == 1}{route key='basketStep3'}{else}{route key='basket'}{/if}">({translate key="change"})</a>
                                                </span>
                                            </li>

                                            {if $data.comment}
                                                <li class="comment">
                                                    <span>
                                                        {translate key='Notes'}:
                                                        <strong class="comment">{$data.comment|escape}</strong>
                                                    </span>
                                                </li>
                                            {/if}
                                        </ul>
                                    </div>
                                </div>

                                <div class="taxes">
                                    <span class="label">{translate key='Shipping cost'}:</span> 
                                    <span class="cost">{currency value=$shipping->getCost()}</span><br>

                                    {if $user->basket->getDiscount()}
                                        <span class="label">{translate key='Discounts granted'}:</span> 
                                        <span class="cost">{currency value=$user->basket->getDiscount()}</span><br>
                                    {/if}

                                    {if $isLocalizedTaxDetected && !$additional_tax_info}
                                        <span class="label">{translate key='Total (without tax)'}:</span> 
                                        <span class="cost">{currency value=$sum_net}</span><br>
                                        <span class="label">{translate key='Taxes (recalculated for'} {if $taxBasedOn == 1}{country code=$data.country2}{else}{country code=$data.country}{/if}):</span> 
                                        <span class="cost">{currency value=$taxSum}</span><br>
                                    {/if}
                                </div>

                                {if $additional_tax_info == '1'}
                                    <div class="taxes">
                                        <span class="label">{translate key='Total (without tax)'}:</span> 
                                        <span class="cost">{currency value=$sum_net}</span><br>

                                        {foreach from=$taxes item=taxAmount key=tax}
                                            <span class="label">{translate key='VAT.'} {$tax}%:</span> 
                                            <span class="cost">{currency value=$taxAmount}</span><br>
                                        {/foreach}
                                    </div>
                                {/if}

                                <p class="sum">
                                    <span class="label">{translate key="To pay"}:</span>
                                    <span class="sum">{currency value=$sum}</span>
                                </p>

                                <form method="post" action="{route key='basketStep3'}">
                                    <fieldset>
                                        <input type="hidden" name="summaryform" value="1" >
                                        <div class="bottombuttons">
                                            <button type="submit" name="button1" value="button1" class="btn undo back">
                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                <span>{translate key='Back'}</span>
                                            </button>
                                            <button type="submit" name="button2" value="button2" class="btn btn-red order clickhide">
                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                <span>{translate key='Confirm order'}</span>
                                            </button>
                                        </div>
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
<script>
    try {literal}{{/literal}Shop.values.ShippingHidden = {$shipping_extra_step}; {literal}}{/literal} catch(e) {literal}{ }{/literal}
</script>
{include file='footerbox.tpl'}
{include file='footer.tpl' force_include_cache='1' force_include_cache_tags='Logic_SkinFooterGroupList,Logic_SkinFooterLinkList,Logic_SkinFooterGroup,Logic_SkinFooterLink'}
{plugin module=shop template=footer}
{include file='switch.tpl'}
</body>
</html>
