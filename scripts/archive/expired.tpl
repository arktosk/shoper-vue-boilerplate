{include file='header.tpl'}
<body{if $body_id} id="{$body_id|escape}"{/if}{if $body_class} class="{$body_class|escape}"{/if}>
{include file='body_head.tpl'}
    <div class="main row rodo">
        <div class="innermain container">
            <div class="s-row">
                <div class="center-row s-grid-6">
                    <div class="box rodo__expired-section">
                        <div class="boxhead">
                            <h3><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{translate key="Your archive has expired"}</h3>
                        </div>
                        <div class="f-row">
                            <p>{translate key="Send us an %semail%s to access a new data archive." p1="<a href='mailto:$contact_email'>" p2="</a>"}</p>
                        </div>
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
