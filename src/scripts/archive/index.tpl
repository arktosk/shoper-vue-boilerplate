{include file='header.tpl'}
<body{if $body_id} id="{$body_id|escape}"{/if}{if $body_class} class="{$body_class|escape}"{/if}>
{include file='body_head.tpl'}
    <div class="main row rodo">
        <div class="innermain container">
            <div class="s-row">
                <div class="rodo__container center-row s-grid-6">
                    <div class="box">
                        <form action="" method="post">
                            <fieldset>
                                <div class="boxhead">
                                    <h3><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{translate key="Enter a verification code that we have sent to your email"}</h3>
                                </div>
                                <div class="f-row">
                                    <p>{translate key="To protect your data, we have sent you a one-time verification code to your address %s. Enter the code to access the data." p1="$marked_email"}</p>
                                </div>
                                <div class="f-row">
                                    {capture assign="route"}
                                        {route key='archiveCode'}
                                    {/capture}
                                    <p>{translate key="Did not receive an email? %sGet a new access code%s" p1="<a data-customer-email='$marked_email' data-action='$route' data-rodo-new-code>" p2="</a>"}</p>
                                </div>
                                <div class="f-row">
                                    <div class="center-row f-grid-6">
                                        <div>
                                            <input id="verification_code" placeholder="{translate key='Enter 6-digit code'}" type="text" name="verification_code" class="{if $data_error.verification_code}error{/if}">
                                        </div>
                                        {if $data_error.verification_code}
                                            <ul class="row error">
                                                {foreach from=$data_error.verification_code item=err_text}
                                                    <li>{$err_text|escape}</li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    </div>
                                </div>
                                <div class="bottombuttons f-row">
                                    <div class="center-row f-grid-6">
                                        <button data-rodo-download-archive type="submit" name="download" value="download" class="btn btn-red">
                                            <img src="{baseDir}/public/images/1px.gif" alt="{translate key='Done'}" class="px1">
                                            <span>{translate key='Download your archive'}
                                                (<span data-rodo-convert-size>{$archive_size|escape}</span>)
											</span>
                                        </button>
                                        <p>{translate key="Available for only %s days" p1="$days_left"}.</p>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{include file='footerbox.tpl'}
{include file='footer.tpl' force_include_cache='1' force_include_cache_tags='Logic_SkinFooterGroupList,Logic_SkinFooterLinkList,Logic_SkinFooterGroup,Logic_SkinFooterLink'}
{plugin module=shop template=footer}
{include file='switch.tpl'}
</body>
</html>
