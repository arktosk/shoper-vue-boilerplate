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

                    <div class="box" id="box_useredit">
                        <div class="boxhead">
                            <span>
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                {translate key="Edit your profile"}
                            </span>
                        </div>

                        <div class="innerbox">
                            <form action="{route key='panelEdit'}" method="post">
                                <fieldset>
                                    {include file='formantispam.tpl'}

                                    <label for="mail_input">
                                        <em class="color">*</em> {translate key="E-mail"}:
                                    </label>
                                    <div class="shaded_inputwrap">
                                        <input type="text" name="mail" id="mail_input" value="{$data.mail|escape}" size="30" class="{if $data_error.surname} error{/if}">
                                    </div>
                                    {if $data_error.mail}
                                        <ul class="input_error">
                                            {foreach from=$data_error.mail item=err_text}
                                                <li>{$err_text|escape}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}

                                    <label for="name_input">{translate key="First name"}:</label>
                                    <div class="shaded_inputwrap">
                                        <input type="text" name="name" id="name_input" value="{$data.name|escape}" size="30" class="{if $data_error.surname} error{/if}">
                                    </div>
                                    {if $data_error.name}
                                        <ul class="input_error">
                                            {foreach from=$data_error.name item=err_text}
                                                <li>{$err_text|escape}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}

                                    <label for="surname_input">{translate key="Last name"}:</label>
                                    <div class="shaded_inputwrap">
                                        <input type="text" name="surname" id="surname_input" value="{$data.surname|escape}" size="30" class="{if $data_error.surname} error{/if}">
                                    </div>
                                    {if $data_error.surname}
                                        <ul class="input_error">
                                            {foreach from=$data_error.surname item=err_text}
                                                <li>{$err_text|escape}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}

                                    <label for="newsletter_input">{translate key="Newsletter"}:</label>
                                    <div class="shaded_inputwrap">
                                        <span class="checkbox-wrap">
                                            <input type="checkbox" name="newsletter" id="newsletter_input" value="1" {if 1 == $data.newsletter} checked{/if}>
                                            <label for="newsletter_input"></label>
                                        </span>
                                        <label for="newsletter_input">{translate key='I voluntarily agree to receive information about new products and promotions'}</label>
                                    </div>

                                    {if $data_error.newsletter}
                                        <ul class="input_error">
                                            {foreach from=$data_error.newsletter item=err_text}
                                                <li>{$err_text|escape}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}

                                    {if count($additional_fields) > 0}
                                        <h4 class="separator">{translate key='Additional information'}</h4>

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
                                                    {additionalField field=$field name=$name value=$data.$name|escape}
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
                                                                {additionalField field=$field name=$name value=$data.$name editable=true}
                                                                <label for="{$name|escape}"></label>
                                                            </span>
                                                            <label for="{$name|escape}">{$field->translation->description}</label>
                                                        {elseif $field->field->type == constant('Logic_AdditionalField::TYPE_SELECT')}
                                                            {additionalField field=$field name=$name value=$data.$name|escape editable=true}
                                                        {else}
                                                            <span class="shaded_inputwrap{if $additional_error.$name} error{/if}">
                                                                {additionalField field=$field name=$name value=$data.$name|escape editable=true size=25}
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

                                    <div>
                                        <span><em class="color">*</em> - {translate key="Field mandatory"}</span>
                                    </div>

                                    <div class="bottombuttons row">
                                        <button type="submit" class="btn save">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                            <span>{translate key="Save"}</span>
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
