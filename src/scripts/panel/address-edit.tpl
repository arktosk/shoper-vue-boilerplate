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

                    <div class="box" id="box_address">
                        <div class="boxhead">
                            <span>
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                {if $address_id > 0}
                                    {translate key="Edit address"}
                                {else}
                                    {translate key="New address"}
                                {/if}
                            </span>
                        </div>

                        <div class="innerbox">
                            <form action="{route key='panelAddressEdit' addressId=$address_id}" method="post">
                                <fieldset>
                                    {include file='formantispam.tpl'}

                                    <table class="address-handler">
                                        <tbody>
                                            {foreach from=$table item=tr}
                                                <tr>
                                                    <td class="label">
                                                        <label for="input_{$tr.name|escape}">
                                                            {if true == $tr.obligatory}
                                                                {assign var="requiredField" value=true}
                                                                <em class="color">*</em> 
                                                            {/if}
                                                            {$tr.label|escape}:
                                                        </label>
                                                    </td>

                                                    <td class="input">
                                                        {if 'select' == $tr.type}
                                                            <select class="{if $tr.error} error{/if}" name="{$tr.name|escape}" id="input_{$tr.name|escape}">
                                                                {foreach from=$countries_logiclist item=c}
                                                                    <option data-value="{$c->getIdentifier()}"{if $c->country->isocode == $tr.value} selected="selected"{/if} data-region="{if $c->country->regions}1{else}0{/if}" value="{$c->country->isocode|escape}">
                                                                        {$c->getLocalizedName()}
                                                                    </option>
                                                                {/foreach}
                                                            </select>
                                                        {else}
                                                            <div class="shaded_inputwrap{if $tr.error} error{/if}">
                                                                <input {if $tr.name == 'zip'}data-mask="__-___" data-pattern="{literal}^(\d{2})(-)(\d{3})${/literal}" data-valid-pattern="00-000"{/if} type="{$tr.type|escape}" name="{$tr.name|escape}" value="{$tr.value|escape}" size="25" id="input_{$tr.name|escape}">
                                                            </div>
                                                        {/if}
                                                    </td>

                                                    {if $tr.rowspan > 0}
                                                        <td class="{if $tr.hint}hint{/if}"{if $tr.rowspan > 1} rowspan="{$tr.rowspan|escape}"{/if}>
                                                            {$tr.hint|escape|nl2br}
                                                        </td>
                                                    {/if}
                                                </tr>

                                                {if $tr.error}
                                                    <tr>
                                                        <td />
                                                        <td class="error">
                                                            <ul class="input_error">
                                                                {foreach from=$tr.error item=err_text}
                                                                    <li>{$err_text|escape}</li>
                                                                {/foreach}
                                                            </ul>
                                                        </td>
                                                        <td />
                                                    </tr>
                                                {/if}
                                            {/foreach}

                                            {if $show_default1 || $show_default2}
                                                <tr>
                                                    <td class="spacer" colspan="2"></td>
                                                </tr>
                                            {/if}

                                            {if $show_default1}
                                                <tr>
                                                    <td class="label"></td>
                                                    <td class="input">
                                                        <span class="checkbox-wrap">
                                                            <input type="checkbox" name="default1" value="1" id="default1"{if 1 == $default1} checked="checked"{/if}>
                                                            <label for="default1"></label>
                                                        </span>
                                                        <label for="default1">{translate key='Default address'}</label>
                                                    </td>
                                                </tr>
                                            {/if}
                                            
                                            {if $show_default2}
                                                <tr>
                                                    <td class="label"></td>
                                                    <td class="input">
                                                        <span class="checkbox-wrap">
                                                            <input type="checkbox" name="default2" value="1" id="default2"{if 1 == $default2} checked="checked"{/if}>
                                                            <label for="default2"></label>
                                                        </span>
                                                        <label for="default2">{translate key='Delivery address'}</label>
                                                    </td>
                                                </tr>
                                            {/if}
                                        </tbody>
                                    </table>

                                    <input type="hidden" name="addressform" value="1">

                                    {if $requiredField}
                                    <div>
                                        <span><em class="color">*</em> - {translate key="Field mandatory"}</span>
                                    </div>
                                    {/if}

                                    <div class="bottombuttons">
                                        <button type="submit" name="button1" value="button1" class="btn undo">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>&laquo; {translate key='Back'}</span>
                                        </button>
                                        <button type="submit" name="button2" value="button2" class="btn btn-red important save">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            {if $address_id > 0}
                                            <span>{translate key='Save'}</span>
                                            {else}
                                            <span>{translate key='Add'}</span>
                                            {/if}
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
{include file='footerbox.tpl'}
{include file='footer.tpl' force_include_cache='1' force_include_cache_tags='Logic_SkinFooterGroupList,Logic_SkinFooterLinkList,Logic_SkinFooterGroup,Logic_SkinFooterLink'}
{plugin module=shop template=footer}
{include file='switch.tpl'}
</body>
</html>
