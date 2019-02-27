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

                    <div class="box" id="box_passchange">
                        <div class="boxhead">
                            <span>{translate key="Enter new password"}</span>
                        </div>

                        <div class="innerbox">
                            <form action="{route key='passremindStep3' basket=$basket}" method="post">
                                <fieldset>
                                    {include file='formantispam.tpl'}
                                    <label for="pass1_input"><em class="color">*</em> {translate key="Password"}:</label>
                                    <div class="shaded_inputwrap{if $data_error.pass1} error{/if}">
                                        <input type="password" name="pass1" id="pass1_input" value="" size="30" />
                                    </div>

                                    {if $data_error.pass1}
                                        <ul class="input_error">
                                            {foreach from=$data_error.pass1 item=err_text}
                                                <li>{$err_text|escape}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}

                                    <label for="pass2_input"><em class="color">*</em> {translate key="Repeat password"}:</label>
                                    <div class="shaded_inputwrap{if $data_error.pass2} error{/if}">
                                        <input type="password" name="pass2" id="pass2_input" value="" size="30" />
                                    </div>

                                    {if $data_error.pass2}
                                        <ul class="input_error">
                                            {foreach from=$data_error.pass2 item=err_text}
                                                <li>{$err_text|escape}</li>
                                            {/foreach}
                                        </ul>
                                    {/if}

                                    <div>
                                        <span><em class="color">*</em> - {translate key="Field mandatory"}</span>
                                    </div>
                                    <div class="bottombuttons">
                                        <button type="submit" class="btn save">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
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
