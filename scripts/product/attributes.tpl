{if count($attrs)}
    <div class="box tab" id="box_productdata">
        <div class="boxhead tab-head">
            <h3>
                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                {translate key="Technical data"}
            </h3>
        </div>

        <div class="innerbox tab-content product-attributes zebra">
            <table class="table">
                <tbody>
                    {foreach from=$attrs item=attr}
                        {if 1 == $attr.type}
                            <tr class="r--l-flex r--l-flex-wrap">
                                <td class="name r--l-box-5 r--l-md-box-10">{$attr.name|escape}</td>
                                <td class="value r--l-box-5 r--l-md-box-10">{if 1 == $attr.value}{translate key="Yes"}{else}{translate key="No"}{/if}</td>
                            </tr>
                        {elseif strlen($attr.value)}
                            <tr class="r--l-flex r--l-flex-wrap">
                                <td class="name r--l-box-5 r--l-md-box-10 r--l-xs-box-10">{$attr.name|escape}</td>
                                <td class="value r--l-box-5 r--l-md-box-10 r--l-xs-box-10">{$attr.value|escape}</td>
                            </tr>
                        {/if}
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
{/if}