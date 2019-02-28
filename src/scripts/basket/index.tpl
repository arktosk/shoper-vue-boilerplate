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

                    {if count($user->basket)}
                        <div class="box unibox" id="box_basketlist">
                            <div class="boxhead">
                                <h3>
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                    {translate key='Contents of your cart'}
                                </h3>
                            </div>

                            <div class="innerbox">
                                <form action="{route key='basket'}" method="post">
                                    {include file='formantispam.tpl'}
                                    <table class="productlist table zebra">
                                        <thead>
                                            <tr>
                                                <td class="large img"></td>
                                                <td class="name">{translate key="Product"}</td>
                                                {if $showDelivery}
                                                    <td class="rwd-hide-medium time">{translate key="Dispatched within"}</td>
                                                {/if}
                                                <td class="quantity">{translate key="Quantity"}</td>
                                                <td class="rwd-hide-small price">{translate key="Price"}</td>
                                                <td class="sum">{translate key="Value"}</td>
                                                <td class="actions">{translate key="Actions"}</td>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            {foreach from=$user->basket item=basket_product}
                                                {if !$basket_product->isChild()}
                                                    <tr data-product-id="{$basket_product->product->product->product_id}" data-category="{$basket_product->product->defaultCategory->translation->name|escape}" {if $basket_product->product->product->producer_id}data-producer="{$basket_product->product->producer->manufacturer->name|escape}"{/if}>
                                                        <td class="img large">
                                                            <img src="{imageUrl type='productGfx' width=75 height=75 image=$basket_product->stock->mainImageName() overlay=1}" alt="{$basket_product->product->translation->name|escape}" />
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
                                                            <td class="rwd-hide-medium time">{$basket_product->stock->delivery->translation->name|escape}</td>
                                                        {/if}
                                                        <td class="quantity">{assign var=id value=$basket_product->getIdentifier()}
                                                            <span class="shaded_inputwrap{if true == $quantity_error.$id} error{/if}"><input name="quantity_{$id}" value="{float precision=$QUANTITY_PRECISION value=$quantity.$id trim=true noformat=true}" type="{if $basket_product->product->unit->unit->floating_point == 0}number{else}text{/if}" class="short center" /></span>
                                                            {$basket_product->product->unit->translation->name|escape}
                                                        </td>
                                                        <td class="rwd-hide-small price">{currency value=$basket_product->getPrice()}
                                                        <td class="sum">
                                                            <em class="color">{currency value=$basket_product->getPriceForAll()}</em>
                                                        </td>
                                                        <td class="actions">
                                                            <a href="{route key='basketRemove' basketId=$basket_product->getIdentifier()}" title="{translate key='Remove product from cart'}" class="prodremove">
                                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                                <span>{translate key='Remove'}</span>
                                                                <i class="fa fa-times"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                {/if}
                                            {/foreach}
                                        </tbody>
                                    </table>

                                    <div id="cart-options">
                                        <div class="delivery-container">
                                            <div class="deliverycountry{if count($shipping_countries) < 2} none{/if}">
                                                <span colspan="3" class="desc">
                                                    <em>{translate key="Shipping country"}:</em>
                                                </span>
                                                <span colspan="3" class="select">
                                                    <select name="shipping_country">
                                                    {foreach from=$shipping_countries item=c key=k}
                                                        <option value="{$k|escape}"{if $k == $shipping_country} selected="selected"{/if}>{$c|escape}</option>
                                                    {/foreach}
                                                    </select>
                                                </span>
                                                <span class="actions"></span>
                                            </div>

                                            <div {if $shipping_extra_step}class="none"{/if}>
                                                <h5>{translate key="Shipping method"}:</h5>

                                                {foreach from=$shippings item=shipping name=list}
                                                    <div{if $shipping->shipping->engine} data-engine="{$shipping->shipping->engine|escape}"{/if} class="delivery{if $shipping_id == (int) $shipping->getIdentifier()} selected{/if}{if 0 == $smarty.foreach.list.index} first{/if}">
                                                        <span class="name">
                                                            <span class="radio-wrap">
                                                                <input type="radio" name="shipping_id" id="shipping_{$shipping->getIdentifier()}" value="{$shipping->getIdentifier()}" {if $shipping_id == (int) $shipping->getIdentifier()}checked="checked" {/if}/>
                                                                <label for="shipping_{$shipping->getIdentifier()}"></label>
                                                            </span>
                                                            <label for="shipping_{$shipping->getIdentifier()}">{$shipping->translation->name|escape}</label>
                                                            <span class="description">{$shipping->translation->description|escape}</span>
                                                        </span>
                                                        <span class="value">
                                                            {currency value=$shipping->getCost($user->basket)}
                                                        </span>
                                                    </div>
                                                {/foreach}
                                            </div>

                                            {if $pocztaPolskaPickupPointsIds && !$shipping_extra_step}
                                                <div data-pp-pick-up-points class="pp-pick-up-points">
                                                    <input type="hidden" name="pp-pick-up-points-delveries" id="pp-pick-up-points-delveries" value="{$pocztaPolskaPickupPointsIds|escape}">
                                                    <input type="hidden" name="pp-pick-up-points-apikey" id="pp-pick-up-points-apikey" value="{$pocztaPolskaGmapApikey|escape}">
                                                    {if $pocztaPolskaPickupPoint}
                                                        <input type="hidden" name="pp-pick-up-point" id="pp-pick-up-point" value="{$pocztaPolskaPickupPoint|escape}">
                                                    {/if}
                                                </div>
                                            {/if}
                                        </div>

                                        <div class="payment-container{if $shipping_extra_step} none{/if}">
                                            <h5>
                                                {translate key="Payment method"}:
                                            </h5>

                                            {foreach from=$payments item=payment name=list}
                                                <div class="payment{if $payment_id == (int) $payment->getIdentifier()} selected{/if}{if 0 == $smarty.foreach.list.index} first{/if}">
                                                    <span class="name">
                                                        <span class="radio-wrap">
                                                            <input type="radio" name="payment_id" id="payment_{$payment->getIdentifier()}" value="{$payment->getIdentifier()}" {if $payment_id == (int) $payment->getIdentifier()}checked="checked" {/if}/>
                                                            <label for="payment_{$payment->getIdentifier()}"></label>
                                                        </span>
                                                        <label for="payment_{$payment->getIdentifier()}">
                                                            {$payment->translation->title|escape}
                                                        </label>
                                                        <span class="description">
                                                            {$payment->translation->description|escape}
                                                            {plugin module=shop template=basket-payment-list payment=$payment sum=$sum}
                                                        </span>
                                                        <span class="additional_cost_percent"></span>
                                                    </span>
                                                    <span class="value"></span>
                                                </div>
                                            {/foreach}
                                        </div>

                                        <div class="summary-container">
                                            <div class="promo-container">
                                                {if $showpromocodes}
                                                    {if true == $promocode_error || ! $promocode}
                                                        <div class="promocode">
                                                            <span class="checkbox-wrap">
                                                                <input id="promocodeshow" name="promocodeshow" type="checkbox"{if $promocode} checked{/if}>
                                                                <label for="promocodeshow"></label>
                                                            </span>
                                                            <span class="desc">
                                                                <label for="promocodeshow">{translate key="I have a discount coupon code"}</label>
                                                            </span>
                                                            <span class="input">
                                                                <div class="shaded_inputwrap{if true == $promocode_error} error{/if}">
                                                                    <input type="text" value="{$promocode|escape}" name="promocode">
                                                                </div>
                                                            </span>
                                                            <span class="action">
                                                                <button type="submit" class="btn">
                                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                                    <span>{translate key="Use"}</span>
                                                                    <i class="icon-ok"></i>
                                                                </button>
                                                            </span>
                                                        </div>
                                                    {else}
                                                        <input type="hidden" name="promocode" value="{$promocode|escape}" />
                                                    {/if}
                                                {/if}

                                                {foreach from=$promos item=promo key=key}
                                                <div class="promo {$key}">
                                                        {if $key === 'code'}
                                                            <div>
                                                                <button class="btn btn-remove-promocode">
                                                                    <span>{translate key="remove discount code"}</span>
                                                                </button>
                                                            </div>
                                                        {/if}
                                                        <span class="desc">
                                                            {$promo.desc|replace:'%d':$promo.val}:
                                                        </span>
                                                        <span class="value">
                                                            {currency value=$promo.price}
                                                        </span>
                                                    </div>
                                                {/foreach}
                                            </div>

                                            <div class="recount">
                                                <span>
                                                    <span class="button" id="recalc" data-recount="{if $recount}true{else}false{/if}">
                                                        <input type="hidden" name="recount" value="1" />
                                                        <button type="submit" name="button" value="button" class="btn">
                                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                            <span>{translate key='Calculate'}</span>
                                                        </button>
                                                    </span>
                                                    <span class="desc"><em>{translate key="Total"}:</em></span>
                                                    <span class="sum">
                                                        <em class="color">{currency value=$user->basket->sumProducts(false, false)}</em>
                                                    </span>
                                                </span>
                                            </div>

                                            <div class="deliveryhead">
                                                <span class="cost">
                                                    {if 1 == $shipping_extra_step}
                                                        <em>{translate key="Shipping cost from"}:</em>
                                                    {else}
                                                        <em>{translate key="Shipping cost"}:</em>
                                                    {/if}
                                                </span>
                                                <span class="value"><em class="color"></em></span>
                                                <span class="actions"></span>
                                            </div>

                                            <div class="sum">
                                                <span class="desc">
                                                    {translate key="To pay"}:
                                                </span>
                                                <span class="value">
                                                    {currency value=$sum}
                                                </span>
                                            </div>

                                            {if $additional_tax_info == '1'}
                                                <div class="tax-additional-info">
                                                    {translate key="Including tax and shipping costs"}
                                                </div>
                                            {/if}

                                            {if $loyalty_points}
                                                <div class="loyalty_points">
                                                    <span class="value">
                                                        {translate key="You gain %s%s%s points" p1='<span class="points">' p2=$loyalty_points p3='</span>'}
                                                    </span>
                                                </div>
                                            {/if}
                                        </div>

                                        <div class="buttons">
                                            <span class="back">
                                                <button type="submit" class="btn back" name="button1" value="button1">
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                    <span>{translate key='Continue shopping'}</span>
                                                </button>
                                            </span>
                                            <span class="forward">
                                                <button type="submit" class="important order btn btn-red" name="button2" value="button2">
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                    <span>{translate key='Order now'}</span>
                                                </button>
                                            </span>  

                                            {plugin module=shop template=basket-submit-buttons}
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    {else}
                        <div class="alert-info alert">
                            <p>{translate key="Your cart is empty."}</p>
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

    <script type="text/javascript">
        try {literal}{{/literal} Shop.values.Country2Shipping = {$country2shipping}; Shop.values.Shipping2Payment = {$shipping2payment}; Shop.values.SumNoShipping = {$sum_noship}; Shop.values.ShippingValue = {$shippingvalue}; Shop.values.PaymentAdditional = {$paymentadditional}; Shop.values.CurrencyMap = "{$currencymap}"; Shop.values.ShippingHidden = {$shipping_extra_step}; {literal}}{/literal} catch(e) {literal}{ }{/literal}
    </script>
{include file='footerbox.tpl'}
{include file='footer.tpl' force_include_cache='1' force_include_cache_tags='Logic_SkinFooterGroupList,Logic_SkinFooterLinkList,Logic_SkinFooterGroup,Logic_SkinFooterLink'}
{plugin module=shop template=footer}
{include file='switch.tpl'}
</body>
</html>
