{include file='header.tpl'}
<body{if $body_id} id="{$body_id|escape}"{/if}{if $body_class} class="{$body_class|escape}"{/if}>
    <div class="main row">
        <div class="innermain container">
            <div class="s-row">
                <div class="box s-row-12" id="box_htmlpricelist">
                    <div class="boxhead">
                        <h3>{translate key="PRICE LIST"}</h3>
                    </div>

                    {if !$hide_table}
                        <div class="innerbox">
                            <form class="table-navigator row" action="">
                                {include file=paginator.tpl}
                            </form>

                            <table class="pricelist table">
                                <tbody>
                                    <tr class="f-row">
                                        <td class="first f-grid-8">{translate key="Product name"}</td>
                                        <td class="f-grid-2">{translate key="Net price"}</td>
                                        <td class="f-grid-2">{translate key="Gross price"}</td>
                                    </tr>

                                    {foreach from=$data item=group}
                                        <tr class="category f-row">
                                            <td colspan="3" class="boxhead f-grid-12">
                                                <h4>
                                                    <a href="{$group.url|escape}">{$group.name|escape} ({$group.length})</a>
                                                </h4>
                                            </td>
                                        </tr>

                                        {foreach from=$group.products item=product}
                                            <tr class="product f-row">
                                                <td class="first f-grid-8"><a href="{$product.url}">{$product.name|escape}</a></td>
                                                
                                                {if $showprices}
                                                    <td class="f-grid-2">{currency value=$product.price_netto}</td>
                                                    <td class="f-grid-2">{currency value=$product.price_brutto} {if $product.price_currency_brutto}({currency value=$product.price_currency_brutto rate=1 currency=$product.currency}){/if}</td>
                                                {else}
                                                   <td class="f-grid-2">-</td>
                                                   <td class="f-grid-2">-</td>
                                                {/if}
                                            </tr>
                                        {/foreach}
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</body>
</html>
