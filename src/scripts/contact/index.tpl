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

                    <div class="box" id="box_contact">
                        <div class="boxhead">
                            <h3>
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                {translate key="Contact form"}
                            </h3>
                        </div>

                        <div class="innerbox">
                            <form class="formprotect" method="post" action="{route key='contact'}" enctype="multipart/form-data" novalidate>
                                <fieldset>
                                    {include file='formantispam.tpl'}
                                    <div class="f-row">
                                            <div class="labe-name f-grid-3">
                                                <label for="contact1">{translate key="First and last name"}:</label>
                                            </div>

                                            <div class="f-grid-9">
                                                <input id="contact1" type="text" name="name" value="{$data.name|escape}" size="30"  class="{if $data_error.name}error{/if}">
                                                {if $data_error.name}
                                                    <ul class="row error">
                                                    {foreach from=$data_error.name item=err_text}
                                                        <li>{$err_text|escape}</li>
                                                    {/foreach}
                                                    </ul>
                                                {/if}
                                            </div>
                                    </div>

                                    <div class="f-row">
                                            <div class="labe-address f-grid-3">
                                                <label for="contact2">{translate key="E-mail address"}: <em class="color">*</em> </label>
                                            </div>

                                            <div class="f-grid-9">
                                                <input id="contact2" type="email" name="mail" value="{$data.mail|escape}" size="30" class="{if $data_error.mail}error{/if}">
                                                {if $data_error.mail}
                                                    <ul class="error">
                                                    {foreach from=$data_error.mail item=err_text}
                                                        <li>{$err_text|escape}</li>
                                                    {/foreach}
                                                    </ul>
                                                {/if}
                                            </div>
                                    </div>

                                    <div class="f-row">
                                            <div class="labe-address f-grid-3">
                                                <label for="contact3">{translate key="Subject"}:</label>
                                            </div>

                                            <div class="f-grid-9">
                                                <input id="contact3" type="text" name="subject" value="{$data.subject|escape}" size="30" class="{if $data_error.subject}error{/if}">
                                                {if $data_error.subject}
                                                    <ul class="error">
                                                    {foreach from=$data_error.subject item=err_text}
                                                        <li>{$err_text|escape}</li>
                                                    {/foreach}
                                                    </ul>
                                                {/if}
                                            </div>
                                    </div>

                                    <div class="f-row">
                                            <div class="labe-message f-grid-3">
                                                <label for="contact4">{translate key="Message"}: <em class="color">*</em></label>
                                            </div>

                                            <div class="f-grid-9">
                                                <textarea rows="5" cols="30" id="contact4" name="text" class="{if $data_error.text}error{/if}">{$data.text|escape}</textarea>
                                                {if $data_error.text}
                                                    <ul class="error">
                                                    {foreach from=$data_error.text item=err_text}
                                                        <li>{$err_text|escape}</li>
                                                    {/foreach}
                                                    </ul>
                                                {/if}
                                            </div>
                                    </div>
                                        
                                    {foreach from=$additional_fields item=field}
                                    	{assign var=name value='additional_'|cat:$field->getIdentifier()}
                                    	{if $data_error.$name}
                                            {if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                <div class="error witherror_checkbox f-row">
                                            {else}
                                                <div class="error witherror_text f-row">
                                            {/if}
                                    	{else}
                                            <div class="f-row">
                                    	{/if}

                                            {if $field->field->type == constant('Logic_AdditionalField::TYPE_HIDDEN')}
                                                {additionalField field=$field name=$name value=$additional_value.$name|escape}
                                            {elseif $field->field->type == constant('Logic_AdditionalField::TYPE_INFO')}
                                                <div class="input_info">
                                                    {$field->translation->description}
                                                </div>
                                            {else}
                                                {if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                    <div class="label-checkbox checkbox-input-req">
                                                {else}
                                                    <div class="label-checkbox">
                                                {/if}
                                                
                                                    {if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                        {if 1 == $field->field->req}<em class="color">*</em>{/if}
                                                    {else}
                                                        <label for="{$name|escape}">
                                                            {if 1 == $field->field->req}<em class="color">*</em>{/if}
                                                            {$field->translation->description}
                                                        </label>
                                                    {/if}
                                                </div>

                                                {if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                    <div class="label-checkbox checkbox-input">
                                                {else}
                                                    <div class="label-checkbox">
                                                {/if}
                                                    {if $field->field->type == constant('Logic_AdditionalField::TYPE_CHECKBOX')}
                                                        {additionalField field=$field name=$name value=$data.$name editable=true}
                                                        <label for="{$name|escape}">{$field->translation->description}</label>
                                                    {elseif $field->field->type == constant('Logic_AdditionalField::TYPE_SELECT')}
                                                        {additionalField field=$field name=$name value=$additional_value.$name|escape editable=true}
                                                    {else}
                                                        <div class="{if $data_error.$name}error{/if}" class="f-grid-7">
                                                            {additionalField field=$field name=$name value=$data.$name|escape editable=true size=30}
                                                        </div>
                                                    {/if}
                                                </div>
                                            {/if}
                                        </div>

                                    	{if $data_error.$name}
                                            <div class="row">
                                                <div class="error">
                                                    {formErrors errors=$data_error.$name class="input_error"}
                                               </div>
                                            </div>
                                        {/if}
                                    {/foreach}
                                    <div>
                                        <span><em class="color">*</em> - {translate key="Field mandatory"}</span>
                                    </div>
                                    <div class="bottombuttons f-row">
                                        <div class="f-grid-12">
                                            {$recaptcha}
                                            <button type="submit" class="btn btn-red2 send">
                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                                <span>{translate key="Send"}</span>
                                            </button>
                                        </div>
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
