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

                    <div class="box" id="box_order">
                        <div class="boxhead">
                            <span>{translate key="Order details"} (id: {$order->getIdentifier()})</span>
                        </div>

                        <div class="innerbox">
                            {assign var=id value=$order->getIdentifier()}
                            <div class="row f-row order-details">
                                <ul class="details f-grid-4">
                                    <li class="id">
                                        <strong>{translate key='Order number'}: </strong><span class="id">{$id|escape}</span>
                                    </li>
                                    <li class="status">
                                        <strong>{translate key='Status'}: </strong><span class="status">{$order->status->translation->name|escape}</span>
                                    </li>
                                    {if count($order->paidTransactions) > 0}
                                    <li class="paid">
                                        <strong>{translate key='Paid'}:</strong>
                                        {assign var="sum" value=$order->paidTransactions->sumTransactions()}
                                        {currency id=$order->order->currency_id rate=1 value=$sum}
                                    </li>
                                    {/if}
                                    {if count($order->refundTransactions) > 0}
                                    <li class="refunded">
                                        <strong>{translate key='Refunded'}:</strong>
                                        {assign var="refunded" value=$order->refundTransactions->sumTransactions()}
                                        {currency id=$order->order->currency_id rate=1 value=$refunded}
                                    </li>
                                    {/if}
                                    <li class="date">
                                        <strong>{translate key='Order date'}: </strong><span class="date">{date value=$order->order->date}</span>
                                    </li>

                                    {if $config_confirm}
                                        <li class="confirm"><strong>{translate key='E-mail confirmation'}: </strong>
                                            <span class="confirm">
                                                {if 1 == $order->order->confirm}
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1 confirmed" />
                                                    <span class="confirmed">{translate key='confirmed'}</span>
                                                {else}
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1 notconfirmed" />
                                                    <span class="notconfirmed">{translate key='none!'}</span>
                                                {/if}
                                            </span>
                                        </li>
                                    {/if}

                                    <li class="payment">
                                        <strong>{translate key='Payment'}: </strong><span class="payment">{$order->payment->translation->title|escape}</span>
                                    </li>
                                    <li class="shipping">
                                        <strong>{translate key='Shipping method'}: </strong><span class="shipping">{$order->shipping->translation->name|escape}</span>
                                    </li>

                                    {if $order->invoice && true == $show_invoice}
                                        <li class="invoice">
                                            <strong>{translate key='Invoice'}: </strong> <span class="invoice"><a href="{baseDir}/console/invoices/pdf/id/{$order->invoice->invoice->invoice_id}{if $token}/token/{$token|escape}{/if}">{translate key='display'}</a></span>
                                        </li>
                                    {/if}

                                    {if count($order->parcels) > 0}
                                        <li class="parcel"><strong>{translate key='Shipment'}: </strong>
                                            <span class="parcel">
                                                {foreach from=$order->parcels item=parcel}
                                                    {if $parcel->parcel->send_date !== '0000-00-00 00:00:00'}
                                                        {if strlen($parcel->getTraceLink())}
                                                            <a href="{$parcel->getTraceLink()|escape}" target="_blank" rel="noopener" class="trace">{$parcel->parcel->shipping_code|escape}</a>
                                                        {elseif $parcel->parcel->shipping_code}
                                                            <span>{$parcel->parcel->shipping_code|escape}</span>
                                                        {/if}

                                                        <span class="date">({translate key='sent'}: {date value=$parcel->parcel->send_date})</span><br />
                                                    {else}
                                                        <span>{translate key="ready to dispatch"}</span>
                                                    {/if}
                                                {/foreach}
                                            </span>
                                        </li>
                                    {/if}

                                    {if $order->order->notes_pub}
                                        <li class="notes">
                                            <strong>{translate key='Notes'}: </strong><span class="notes">{$order->order->notes_pub|escape}</span>
                                        </li>
                                    {/if}
                                    {plugin module=shop template=panel-order-details-rwd}
                                </ul>

                                <ul class="address f-grid-4 row">
                                    <li>
                                        {assign var=address value=$order->billingAddress}
                                        <b>{translate key='Billing address'}</b>
                                        {if $address->firstname || $address->lastname}
                                            <p>
                                                {if $address->firstname}
                                                    {$address->firstname|escape}
                                                {/if}
                                                {if $address->lastname}
                                                    {$address->lastname|escape}
                                                {/if}
                                            </p>
                                        {/if}

                                        {if $address->company}
                                            <p>{$address->company|escape}</p>
                                        {/if}

                                        {if $address->tax_id}
                                            <p>{translate key='Tax ID'}: {$address->tax_id|escape}</p>
                                        {/if}

                                        {if $address->pesel}
                                            <p>{translate key='Personal Identification Number'}: {$address->pesel|escape}</p>
                                        {/if}

                                        {if $address->street1}
                                            <p>{$address->street1|escape}</p>
                                        {/if}

                                        {if $address->postcode || $address->city}
                                            <p>
                                                {if $address->postcode}
                                                    {$address->postcode|escape},
                                                {/if}
                                                {if $address->city}
                                                    {$address->city|escape}
                                                {/if}
                                            </p>
                                        {/if}

                                        {if $address->state}
                                            <p>{$address->state|escape}</p>
                                        {/if}

                                        {if $address->country}
                                            <p>{$address->country|escape}</p>
                                        {/if}

                                        {if $address->phone}
                                            <p>{$address->phone|escape}</p>
                                        {/if}
                                    </li>
                                </ul>

                                <ul class="address f-grid-4">
                                    <li>
                                        {assign var=address value=$order->deliveryAddress}
                                        
                                        {if $shippingHandler->isOverwriteDeliveryAddress()}
                                            {plugin module=shop template=panel-order-address-delivery-overwrite-rwd}
                                        {else}
                                            <b>{translate key='Delivery address'}</b>
                                            {if $address->firstname || $address->lastname}
                                                <p>
                                                    {if $address->firstname}
                                                        {$address->firstname|escape} 
                                                    {/if}
                                                    {if $address->lastname}
                                                        {$address->lastname|escape}
                                                    {/if}
                                                </p>
                                            {/if}

                                            {if $address->company}
                                                <p>
                                                    {$address->company|escape}
                                                </p>
                                            {/if}

                                            {if $address->tax_id}
                                                <p>{translate key='Tax ID'}: {$address->tax_id|escape}</p>
                                            {/if}

                                            {if $address->street1}
                                                <p>{$address->street1|escape}</p>
                                            {/if}

                                            {if $address->postcode || $address->city}
                                                <p>
                                                    {if $address->postcode}
                                                        {$address->postcode|escape}, 
                                                    {/if}
                                                    {if $address->city}
                                                        {$address->city|escape}
                                                    {/if}
                                                </p>
                                            {/if}

                                            {if $address->state}
                                                <p>{$address->state|escape}</p>
                                            {/if}

                                            {if $address->country}
                                                <p>{$address->country|escape}</p>
                                            {/if}

                                            {if $address->phone}
                                                <p>{$address->phone|escape}</p>
                                            {/if}
                                        {/if}
                                    </li>
                                </ul>
                            </div>

                            <h4 class="products row">{translate key='Ordered products'}</h4>
                            <table class="products classic zebra table">
                                <thead>
                                    <tr>
                                        <td class="name">{translate key='Name'}</td>
                                        <td class="quantity">{translate key='Quantity'}</td>
                                        <td class="price">{translate key='Price'}</td>
                                        <td class="sum">{translate key='Value'}</td>
                                    </tr>
                                </thead>

                                <tbody>
                                    {foreach from=$order->products item=product name=list}
                                        {if !$product->isChild()}
                                            <tr class="{if $smarty.foreach.list.index % 2}odd{else}even{/if}">
                                                <td class="name">
                                                    {assign var=isProductActive value=$product->productObject->translation->active|escape}

                                                    {if $isProductActive}
                                                        <a href="{route function=$productRoute key=$product->productObject->product->product_id productName=$product->productObject->translation->name productId=$product->product->product_id}">
                                                            {$product->product->name|escape}{if $product->hasOptionsRepresentation()}, <span class="variant">{$product->getOptionsString()|escape}</span>{/if}
                                                        </a>
                                                    {else}
                                                        {$product->product->name|escape}{if $product->hasOptionsRepresentation()}, <span class="variant">{$product->getOptionsString()|escape}</span>{/if}
                                                    {/if}

                                                    {if $product->isParent()}
                                                        {if count($product->getChildren())}
                                                            <div class="bundle-products">
                                                                {foreach from=$product->getChildren() item=bundle}
                                                                    <p>
                                                                        {if $isProductActive}
                                                                            <a href="{route function=$productRoute key=$bundle->product->product_id productName=$bundle->product->name productId=$bundle->product->product_id}">
                                                                                <span class="bundle-product-name">{$bundle->product->name|escape}</span>
                                                                            </a>
                                                                        {else}
                                                                            <span class="bundle-product-name">{$bundle->product->name|escape}</span>
                                                                        {/if}
                                                                    </p>
                                                                {/foreach}
                                                            </div>
                                                        {/if}
                                                    {/if}
                                                </td>
                                                <td class="quantity">{stock value=$product->product->quantity} {$product->product->unit|escape}</td>
                                                <td class="price">{currency value=$product->product->price id=$order->order->currency_id rate=$order->order->currency_rate}</td>
                                                <td class="sum">{currency value=$product->getPriceTimesQuantity(false) id=$order->order->currency_id rate=$order->order->currency_rate}</td>
                                            </tr>
                                        {/if}
                                    {/foreach}
                                </tbody>
                            </table>

                            <div>
                                <div class="r--l-flex r--l-flex-right r--align-right r--l-spacing-vertical-s">
                                    <span class="r--l-box-8">{translate key='Total'}:</span>
                                    <span class="r--l-box-2">{currency value=$order->sumProductsCost() id=$order->order->currency_id rate=$order->order->currency_rate}</span>
                                </div>

                                <div class="r--l-flex r--l-flex-right r--align-right{if $order->sumDiscounts() <= 0} r--l-spacing-vertical-s{/if}">
                                    <span class="r--l-box-8">{translate key='Shipping cost'}:</span>
                                    <span class="r--l-box-2">{currency value=$order->order->shipping_cost id=$order->order->currency_id rate=$order->order->currency_rate}</span>
                                </div>

                                {if $order->sumDiscounts() > 0}
                                    <div class="r--l-flex r--l-flex-right r--align-right r--l-spacing-vertical-s">
                                        <span class="r--l-box-8">{translate key='Discounts granted'}:</span>
                                        <span class="r--l-box-2">{currency value=$order->sumDiscounts() id=$order->order->currency_id rate=$order->order->currency_rate}</span>
                                    </div>
                                {/if}

                                {if $additional_tax_info == '1'}
                                    <div class="r--l-flex r--l-flex-right r--align-right">
                                        <span class="r--l-box-8">{translate key='Total (without tax)'}:</span> 
                                        <span class="r--l-box-2">{currency value=$order->sumOrder(true)}</span>
                                    </div>

                                    {foreach from=$taxes item=taxAmount key=tax name=taxes}
                                        <div class="r--l-flex r--l-flex-right r--align-right{if $smarty.foreach.taxes.last} r--l-spacing-vertical-s{/if}">
                                            <span class="r--l-box-8">{translate key='VAT.'} {$tax}%:</span> 
                                            <span class="r--l-box-2">{currency value=$taxAmount}</span>
                                        </div>
                                    {/foreach}
                                {/if}

                                <div class="r--l-flex r--l-flex-right r--align-right">
                                    <span class="r--l-box-8">
                                        <span class="r--fs-l">{translate key='To pay'}:</span>
                                    </span>

                                    <span class="r--l-box-2 ">
                                        <strong class="r--fs-l">{currency value=$order->getAmountToPay() id=$order->order->currency_id rate=$order->order->currency_rate}</strong>
                                    </span>
                                </div>
                            </div>

                            {if $order->getAmountToPay() > 0 && $order->hasSupportOnlinePayment()}
                                <form action="{route key='panelPayment' orderId=$id token=$token}" method="get" class="pay row">
                                    <fieldset>
                                        {if $order->hasOnlinePayment()}
                                            {assign var=onlinepayment value=$order->getOnlinePayment()}
                                            {if !$onlinepayment->isFinished() or !$onlinepayment->isStarted()}
                                                {if !$onlinepayment->isFinished() and $onlinepayment->isStarted()}
                                                    {translate key='Your payment is being processed.'}
                                                    <button class="btn btn-red2 important pay" type="submit">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                        <span>{translate key='Pay again'}</span>
                                                    </button>
                                                {else}
                                                    <button class="btn btn-red2 important pay" type="submit">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                        <span>{translate key='Pay'}</span>
                                                    </button>
                                                {/if}
                                            {/if}
                                        {else}
                                            <button class="btn btn-red2 important pay" type="submit">
                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                <span>{translate key='Pay'}</span>
                                            </button>
                                        {/if}
                                    </fieldset>
                                </form>
                            {/if}

                            {if $order->isDigital()}
                                <h4 class="digital row">{translate key='Files to download'}</h4>
                                {if $order->isDownloadReady()}
                                    {foreach from=$order->products item=p}
                                        {if $p->isDigital()}
                                            <dl class="details row">
                                                <dt>{$p->product->name|escape}</dt>
                                                <dd>
                                                    {foreach from=$p->productObject->digital item=d}
                                                        <a href="{if $token}{route key='panelDigital' hash=$p->getDigitalHash($d->getIdentifier()) prodId=$p->getIdentifier() digitalId=$d->getIdentifier()}{else
                                                                    }{route key='panelDigital' prodId=$p->getIdentifier() digitalId=$d->getIdentifier()}{/if}">{$d->getDesc()}</a> ({size value=$d->getSize()})<br />
                                                    {/foreach}
                                                </dd>
                                            </dl>
                                        {/if}
                                    {/foreach}
                                {else}
                                    <p>{translate key='Files will be made ​​available after payment.'}</p>
                                {/if}
                                <div class="row"></div>
                            {/if}
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
