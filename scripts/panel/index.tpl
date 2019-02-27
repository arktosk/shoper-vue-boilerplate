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

                    <div class="box" id="box_panel">
                        <div class="boxhead">
                            <span>{translate key="Customer panel"}</span>
                        </div>

                        <div class="innerbox">
                            {if count($orders)}
                                <h4 class="first separator row">{translate key='Your orders'}</h4>
                                <table class="orders payable table">
                                    <thead>
                                        <tr>
                                            <td class="id">{translate key='Order no.'}</td>
                                            <td class="sum">{translate key='Value'}</td>
                                            <td class="status">{translate key='Status'}</td>
                                            <td class="parcels">{translate key='Shipment'}</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    {foreach from=$orders item=order name=list}
                                        {assign var=id value=$order->getIdentifier()}
                                        {assign var=link value=$orders_links[$id]}
                                        <tr class="{if $smarty.foreach.list.index % 2}odd{else}even{/if}">
                                            <td class="id">
                                                {translate key='%sOrder no. %d%s' p0="<a href=\"$link\">" p1=$id p2='</a>'}
                                                <span class="smalldate">({date value=$order->order->date})</span>
                                            </td>
                                            <td class="sum">{currency value=$order->sumOrder()}</td>
                                            <td class="status">
                                                <span>{$order->status->translation->name|escape}</span>
                                                {if $order->getAmountToPay() > 0 && $order->hasSupportOnlinePayment()}
                                                    {if $order->hasOnlinePayment()}
                                                        {assign var=onlinepayment value=$order->getOnlinePayment()}
                                                        {if !$onlinepayment->isFinished() or !$onlinepayment->isStarted()}
                                                            {if !$onlinepayment->isFinished() and $onlinepayment->isStarted()}
                                                                <a class="titlequestion" title="{translate key='Your payment is currently being processed. Are you sure you want to pay again?'}" href="{route
                                                                    key='panelPayment' orderId=$id}">{translate key='pay again'}</a>
                                                            {else}
                                                                <a href="{route key='panelPayment' orderId=$id}">{translate key='pay'}</a>
                                                            {/if}
                                                        {/if}
                                                    {else}
                                                        <a href="{route key='panelPayment' orderId=$id}">{translate key='pay'}</a>
                                                    {/if}
                                                {/if}
                                            </td>
                                            <td class="parcels">
                                                {if count($order->parcels) > 0}
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
                                                {else} - {/if}
                                            </td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                                {if $orders_alllink}
                                    <a class="allorders btn spanhover" href="{route key='panelOrders'}">
                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                        <span>{translate key='Order history (%d)' p1=$orders_count}</span>
                                    </a>
                                {/if}
                            {/if}

                            <h4 class="separator no-border row">{translate key='Account settings'}</h4>
                            <p class="name">{if $user->user->userinfo->firstname || $user->user->userinfo->lastname
                                }{$user->user->userinfo->firstname|escape} {$user->user->userinfo->lastname|escape}{/if}</p>
                            <p class="mail">{$user->user->userinfo->email|escape}</p>
                            
                            <a href="{route key='panelEdit'}" class="editprofile btn spanhover">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                <span>{translate key='Edit your profile'}</span>
                            </a>
                            <a href="{route key='panelPassword'}" class="changepass btn spanhover">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                <span>{translate key='Change password'}</span>
                            </a>

                            <h4 class="separator row">{translate key='Addresses'}</h4>
                            <ul class="address row">
                                <li>
                                    <b class="title">{translate key='Billing address'}</b>
                                    {if $billing_address}
                                        {assign var=address value=$billing_address->address}
                                        {if $address->firstname || $address->lastname
                                            }<p>{if $address->firstname}{$address->firstname|escape} {/if}{if $address->lastname}{$address->lastname|escape}{/if}</p>{/if}
                                        {if $address->company_name}<p>{$address->company_name|escape}</p>{/if}
                                        {if $address->tax_id}<p>{translate key='Tax ID'}: {$address->tax_id|escape}</p>{/if}
                                        {if $address->pesel}<p>{translate key='Personal Identification Number'}: {$address->pesel|escape}</p>{/if}
                                        {if $address->street_1}<p>{$address->street_1|escape}</p>{/if}
                                        {if $address->zip_code || $address->city
                                            }<p>{if $address->zip_code}{$address->zip_code|escape}, {/if}{if $address->city}{$address->city|escape}{/if}</p>{/if}
                                        {if $address->state}<p>{$address->state|escape}</p>{/if}
                                        {if $address->country}<p>{$address->country|escape}</p>{/if}
                                        {if $address->phone}<p>{$address->phone|escape}</p>{/if}
                                    {else}
                                        <p>{translate key='[none]'}</p>
                                    {/if}
                                </li>
                                <li>
                                    <b class="title">{translate key='Delivery address'}</b>
                                    {if $shipping_address}
                                        {assign var=address value=$shipping_address->address}
                                        {if $address->firstname || $address->lastname
                                            }<p>{if $address->firstname}{$address->firstname|escape} {/if}{if $address->lastname}{$address->lastname|escape}{/if}</p>{/if}
                                        {if $address->company_name}<p>{$address->company_name|escape}</p>{/if}
                                        {if $address->tax_id}<p>{translate key='Tax ID'}: {$address->tax_id|escape}</p>{/if}
                                        {if $address->street_1}<p>{$address->street_1|escape}</p>{/if}
                                        {if $address->zip_code || $address->city
                                            }<p>{if $address->zip_code}{$address->zip_code|escape}, {/if}{if $address->city}{$address->city|escape}{/if}</p>{/if}
                                        {if $address->state}<p>{$address->state|escape}</p>{/if}
                                        {if $address->country}<p>{$address->country|escape}</p>{/if}
                                        {if $address->phone}<p>{$address->phone|escape}</p>{/if}
                                    {else}
                                        <p>{translate key='[none]'}</p>
                                    {/if}
                                </li>
                            </ul>
                            <a href="{route key='panelAddressList'}" class="editaddresses btn spanhover">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                <span>{translate key='Edit an address'}</span>
                            </a>

                            {if $loyalty}
                                <h4 class="separator row">{translate key='Loyalty program'}</h4>
                                <ul class="loyalty row">
                                    <li>
                                        <p class="sum">{translate key='Total points: %s%s%s' p1='<b>' p2=$loyalty_points p3='</b>'}</p>
                                    </li>
                                    {if $loyalty_discount}
                                        <li class="loyalty_discount">
                                            <b>{translate key='Discount threshold'}</b>
                                            {if $loyalty_level && $loyalty_level.level}
                                                <p class="current">{translate key='Your permanent discount received for collecting a certain number of points (%s%s%s)' p1='<b>' p2=$loyalty_level.level p3='</b>'}</p>
                                                <h4>{translate key='%s discount' p1=$loyalty_level.discount}</h4>
                                                {if $loyalty_next_level}
                                                    <p class="next">{translate key='To get a bigger discount collect another %s%s%s points' p1='<b>' p2=$loyalty_next_level p3='</b>'}</p>
                                                {/if}
                                            {elseif $loyalty_next_level}
                                                <p class="next">{translate key="You still need at least %s%s%s points to get a permanent discount" p1='<b>' p2=$loyalty_next_level p3='</b>'}</p>
                                            {/if}
                                        </li>
                                    {/if}

                                    {if $loyalty_exchange_enabled}
                                        <a href="{route key='loyaltyList'}" class="loyaltylist button spanhover">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                            <span>{translate key='Go to the list of products that you can exchange for points'}</span>
                                        </a>
                                    {/if}
                                </ul>
                            {/if}

                            {if count($user->user->exchangedProducts)}
                                <h4 class="separator row">{translate key='Exchanged products'}</h4>
                                <table class="orders exchanged classic table">
                                    <thead>
                                        <tr>
                                            <td class="prod">{translate key='Product'}</td>
                                            <td class="quantity">{translate key='Quantity'}</td>
                                            <td class="points">{translate key='Points'}</td>
                                            <td class="status">{translate key='Status'}</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    {foreach from=$user->user->exchangedProducts item=exevent name=list}
                                        <tr class="{if $smarty.foreach.list.index % 2}odd{else}even{/if}">
                                            <td class="prod name">
                                                {if $exevent->stock && $exevent->product->translation}
                                                    {$exevent->product->translation->name|escape}
                                                    <span class="variant">{$exevent->stock->getName()|escape}</span>
                                                {else}
                                                    {translate key="(removed from the store)"}
                                                {/if}
                                            </td>
                                            <td class="quantity">
                                                {float precision=$QUANTITY_PRECISION value=$exevent->loyalty->quantity trim=true}&nbsp;{$exevent->product->unit->translation->name|escape}
                                            </td>
                                            <td class="points">
                                                {assign var=expoints value=$exevent->loyalty->score}
                                                {assign var=expoints value=$expoints*-1}
                                                {float value=$expoints precision=0|replace:' ':'&nbsp;'}
                                            </td>
                                            <td class="status">
                                                {if 1 == (int) $exevent->loyalty->status}
                                                    {translate key='Exchanged'}
                                                {else}
                                                    {translate key='Submitted for exchange'}
                                                    <span class="smalldate">({date value=$exevent->loyalty->date})</span<
                                                {/if}
                                            </td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            {/if}

                            {if $comments_count > 0 || $favourites_count > 0}
                                <h4 class="separator row">{translate key='Products'}</h4>
                                <div class="row">
                                    {if $comments_count > 0}
                                        <a href="{route key='panelComments'}" class="prodcomments btn spanhover">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                            <span>{translate key='Your product reviews (%d)' p0=$comments_count}</span>
                                        </a>
                                    {/if}
                                    {if $favourites_count > 0}
                                        <a href="{route key='panelFavourites'}" class="prodstorage btn spanhover">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                            <span>{translate key='Products on wishlist (%d)' p0=$favourites_count}</span>
                                        </a>
                                    {/if}
                                </div>
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