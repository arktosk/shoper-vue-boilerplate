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

                    <div class="box" id="box_orders">
                        <div class="boxhead">
                            <span>{translate key="Order history"}</span>
                        </div>

                        <div class="innerbox">
                            <table class="orders classic table">
                                <thead>
                                    <tr>
                                        <td class="id">{translate key='ID'}</td>
                                        <td class="date rwd-hide-medium">{translate key='Order date'}</td>
                                        <td class="sum">{translate key='Value'}</td>
                                        <td class="shipping">{translate key='Shipping method'}</td>
                                        {if $config_confirm}<td class="status">{translate key='Confirmation'}</td>{/if}
                                        <td class="actions">{translate key='Actions'}</td>
                                    </tr>
                                </thead>

                                <tbody>
                                    {foreach from=$orders item=order name=list}
                                        {assign var=id value=$order->getIdentifier()}
                                        <tr class="{if $smarty.foreach.list.index % 2}odd{else}even{/if}">
                                            <td class="id">{$id|escape}</td>
                                            <td class="date rwd-hide-medium">{date value=$order->order->date}</td>
                                            <td class="{if $order->sumOrder() == $order->order->paid}paid{else}notpaid{/if}">{currency value=$order->sumOrder() id=$order->order->currency_id rate=$order->order->currency_rate}</td>
                                            <td class="shipping">{$order->shipping->translation->name|escape}</td>

                                            {if $config_confirm}
                                                <td class="status">
                                                    {if 1 == $order->order->confirm}
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1 confirmed" >
                                                        <span class="confirmed">{translate key='confirmed'}</span>
                                                    {else}
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1 notconfirmed" >
                                                        <span class="notconfirmed">{translate key='none!'}</span>
                                                    {/if}
                                                </td>
                                            {/if}

                                            <td class="actions">
                                                <a href="{route key='panelOrder' orderId=$id}" class="details btn btn-red spanhover" title="{translate key='Order details'}">
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                    <span>{translate key='details'}</span>
                                                </a>

                                                {if $order->getAmountToPay() > 0 && $order->hasSupportOnlinePayment()}
                                                    <a href="{route key='panelPayment' orderId=$id}" class="payment btn spanhover">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                        <span>{translate key='pay'}</span>
                                                    </a>
                                                {/if}

                                                {if $order->invoice && true == $show_invoice}
                                                    <a href="{baseDir}/console/invoices/pdf/id/{$order->invoice->invoice->invoice_id}" class="invoice btn spanhover">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                        <span>{translate key='invoice'}</span>
                                                    </a>
                                                {/if}
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
