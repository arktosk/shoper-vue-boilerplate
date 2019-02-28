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

                    <div class="box" id="box_register">
                        <form action="{route key='register'}" method="post" enctype="multipart/form-data" novalidate>
                            <fieldset>
                                {include file='formantispam.tpl'}

                                {if count($providers) > 0}
                                    <div class="social-login-buttons social-login-buttons_no-border">
                                        <h3>
                                            {translate key='Continue with'}
                                        </h3>

                                        {foreach from=$providers item=provider}
                                            {if $provider.type == 'link'}
                                                <a class="btn {$provider.class|escape} r--hspacing-xs" href="{$provider.href|escape}">{$provider.label|escape}</a>
                                            {/if}
                                        {/foreach}
                                    </div>
                                {/if}

                                <h3>
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >{translate key="Registration"}</span>
                                </h3>

                                <div class="innerbox address-handler">
                                    {foreach from=$table1 item=tr}
                                        <div {if $tr.class} data-text-start="{translate key='Register with'}:" class="social-{$tr.class|escape}"{else} data-text-end="{translate key='or using email'}"{/if}>
                                            <span class="login-label">
                                                {if $tr.type != 'checkbox' && $tr.type != 'link'}
                                                    <label for="input_{$tr.name|escape}">
                                                        {if true == $tr.obligatory}
                                                            <em class="color">*</em> 
                                                        {/if}
                                                        {$tr.label|escape}:
                                                    </label>
                                                {/if}
                                            </span>

                                            <div class="input">
                                                {if $tr.type === 'checkbox'}
                                                    {if true == $tr.obligatory}
                                                        <em class="color">*</em> 
                                                    {/if}

                                                    <span class="checkbox-wrap">
                                                        <input type="{$tr.type|escape}" name="{$tr.name|escape}" value="1" id="input_{$tr.name|escape}"{if $tr.value} checked{/if}>
                                                        <label for="input_{$tr.name|escape}"></label>
                                                    </span>

                                                    <label for="input_{$tr.name|escape}">
                                                        {$tr.label|escape}
                                                    </label>
                                                {elseif $tr.type === 'link'}
                                                    <div>
                                                        {if $tr.type == 'link'}
                                                            <a class="btn {$tr.class|escape}" href="{$tr.href|escape}">{$tr.label|escape}</a>
                                                        {/if}
                                                    </div>
                                                {else}
                                                    <span class="shaded_inputwrap{if $tr.error} error{/if}">
                                                        <input type="{$tr.type|escape}" name="{$tr.name|escape}" value="{$tr.value|escape}" size="25" id="input_{$tr.name|escape}"{if $tr.readonly == true} readonly{/if}>
                                                    </span>
                                                {/if}

                                                {if $tr.error}
                                                    <div>
                                                        <ul class="input_error">
                                                            {foreach from=$tr.error item=err_text}
                                                                <li>{$err_text|escape}</li>
                                                            {/foreach}
                                                        </ul>
                                                    </div>
                                                {/if}
                                            </div>

                                            {if $tr.rowspan > 0}
                                                <span class="{if $tr.hint}hint{/if}"{if $tr.rowspan > 1} rowspan="{$tr.rowspan|escape}"{/if}>
                                                    {$tr.hint|escape|nl2br}
                                                </span>
                                            {/if}
                                        </div>
                                    {/foreach}
                              
                                    {if 'full' == $mode}
                                        <h4 class="separator address">{translate key='Address details'}</h4>
                                        <div>
                                            <span class="adress-label"></span>
                                            <span class="input">
                                                <span class="radio-wrap">
                                                    <input type="radio" name="address_type" value="1" id="address_type1"{if 1 == (int) $address_type} checked="checked"{/if}>
                                                    <label for="address_type1"></label>
                                                </span>
                                                <label for="address_type1">{translate key='private person'}</label>

                                                <span class="radio-wrap">
                                                    <input type="radio" name="address_type" value="2" id="address_type2"{if 2 == (int) $address_type} checked="checked"{/if}>
                                                    <label for="address_type2"></label>
                                                </span>
                                                <label for="address_type2">{translate key='company'}</label>
                                            </span>
                                        </div>
                                        
                                        {foreach from=$table2 item=tr}
                                            <div class="{$tr.name|escape}">
                                                <span class="adress-label">
                                                    <label for="input_{$tr.name|escape}">
                                                        {if true == $tr.obligatory}
                                                            <em class="color">*</em> 
                                                        {/if}
                                                        {$tr.label|escape}:
                                                    </label>
                                                </span>

                                                <div class="input">
                                                    {if 'select' == $tr.type}
                                                        <select class="{if $tr.error} error{/if}" name="{$tr.name|escape}" id="input_{$tr.name|escape}">
                                                            {foreach from=$countries_logiclist item=c}
                                                                <option data-value="{$c->getIdentifier()}" data-region="{if $c->country->regions}1{else}0{/if}"{if $c->country->isocode == $tr.value} selected="selected"{/if} value="{$c->country->isocode|escape}">
                                                                    {$c->getLocalizedName()}
                                                                </option>
                                                            {/foreach}
                                                        </select>   
                                                    {else}
                                                        <span class="shaded_inputwrap{if $tr.error} error{/if}">
                                                            <input {if $tr.name == 'zip'}data-mask="__-___" data-pattern="{literal}^(\d{2})(-)(\d{3})${/literal}" data-valid-pattern="00-000"{/if} type="{$tr.type|escape}" name="{$tr.name|escape}" value="{$tr.value|escape}" size="25" id="input_{$tr.name|escape}">
                                                        </span>
                                                    {/if}

                                                    {if $tr.error}
                                                        <div>
                                                            <ul class="input_error">
                                                                {foreach from=$tr.error item=err_text}
                                                                    <li>{$err_text|escape}</li>
                                                                {/foreach}
                                                            </ul>
                                                        </div>
                                                    {/if}
                                                </div>
                                                {if $tr.rowspan > 0}
                                                    <span class="{if $tr.hint}hint{/if}"{if $tr.rowspan > 1} rowspan="{$tr.rowspan|escape}"{/if}>
                                                        {$tr.hint|escape|nl2br}
                                                    </span>
                                                {/if}
                                            </div>
                                        {/foreach}   
                                    {/if}

                                    {if count($additional_fields) > 0}
                                        <h4 class="separator additional">{translate key='Additional information'}</h4>

                                        {foreach from=$additional_fields item=field}
                                            {assign var=name value='additional_'|cat:$field->getIdentifier()}

                                            {if $additional_error.$name}
                                        		{if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                        			<div class="witherror witherror_checkbox">
                                        		{else}
                                        			<div class="witherror witherror_text">
                                        		{/if}
                                        	{else}
                                        		<div class="clear">
                                        	{/if}

                                                {if $field->field->type == constant('Logic_AdditionalField::TYPE_HIDDEN')}
                                                    {additionalField field=$field name=$name value=$additional_value.$name|escape}
                                                {elseif $field->field->type == constant('Logic_AdditionalField::TYPE_INFO')}
                                                    <div class="input_info">
                                                        {$field->translation->description}
                                                    </div>
                                                {else}
                                            	    <div class="input">
                                                        <span class="check-label">
                                                            {if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                                {if 1 == $field->field->req}<em class="color">*</em>{/if}
                                                            {else}
                                                                <label for="{$name|escape}">
                                                                    {if 1 == $field->field->req}<em class="color">*</em>{/if}
                                                                    {$field->translation->description}
                                                                </label>
                                                            {/if}
                                                        </span>
                                                    	{if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                            <span class="checkbox-wrap">
                                                        		{additionalField field=$field name=$name value=$additional_value.$name editable=true}
                                                                <label for="{$name|escape}"></label>
                                                            </span>
                                                    		<label for="{$name|escape}">{$field->translation->description}</label>
                                                    	{elseif $field->field->type == constant('Logic_AdditionalField::TYPE_SELECT')}
                                                    		{additionalField field=$field name=$name value=$additional_value.$name|escape editable=true}
                                                    	{else}
                                                    		<span class="shaded_inputwrap{if $additional_error.$name} error{/if}">
                                                    			{additionalField field=$field name=$name value=$additional_value.$name|escape editable=true size=25}
                                                    		</span>
                                                    	{/if}
                                                    </div>
                                                {/if}                                 
                                            </div>

                                            {if $additional_error.$name}
                                                <div class="error">
                                                    {formErrors errors=$additional_error.$name class="input_error"}
                                                </div>
                                            {/if}
                                        {/foreach}
                                    {/if}

                                    {foreach from=$table3 item=tr}
                                        <div class="clear">
                                            <div class="input">
                                                {if $tr.type === 'checkbox'}
                                                    <em class="color">{if true == $tr.obligatory}*{else}&nbsp;&nbsp;{/if}</em> 

                                                    <span class="checkbox-wrap">
                                                        <input type="{$tr.type|escape}" name="{$tr.name|escape}" value="1" id="input_{$tr.name|escape}"{if $tr.value} checked{/if}>
                                                        <label for="input_{$tr.name|escape}"></label>
                                                    </span>

                                                    <label for="input_{$tr.name|escape}">
                                                        {$tr.label|escape}
                                                    </label>
                                                {else}
                                                    <span class="check-label">
                                                        <label for="input_{$tr.name|escape}">{$tr.label|escape}:</label>
                                                    </span>

                                                    <span class="shaded_inputwrap{if $tr.error} error{/if}">
                                                        <input type="{$tr.type|escape}" name="{$tr.name|escape}" value="{$tr.value|escape}" size="25" id="input_{$tr.name|escape}" />
                                                    </span>
                                                {/if}

                                                {if $tr.error}
                                                    <div>
                                                        <ul class="input_error">
                                                            {foreach from=$tr.error item=err_text}
                                                                <li>{$err_text|escape}</li>
                                                            {/foreach}
                                                        </ul>
                                                    </div>
                                                {/if}
                                            </div>

                                            {if $tr.rowspan > 0}
                                                <span class="{if $tr.hint}hint{/if}"{if $tr.rowspan > 1} rowspan="{$tr.rowspan|escape}"{/if}>
                                                    {$tr.hint|escape|nl2br}
                                                </span>
                                            {/if}
                                        </div>
                                    {/foreach}

                                    {$recaptcha}

                                    <input type="hidden" name="addressform" value="{$mode|escape}" />

                                    <div>
                                        <span><em class="color">*</em> - {translate key="Field mandatory"}</span>
                                    </div>
                                    <div class="bottombuttons">
                                        <button type="submit" class="btn btn-red right register">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                            <span>{translate key="Create an account"}</span>
                                        </button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
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
