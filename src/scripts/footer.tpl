    <footer class="footer row">
        <div class="innerfooter container row">
            <ul class="overall{if 1 == count($footergroups)} singlecol{/if}">
                {foreach from=$footergroups item=group name=groups}
                    <li class="overall flex flex-{$footergroups|count}" id="footgroup{$group->getIdentifier()}">
                        <ul>
                            <li class="head hidden">{$group->group->name|escape}</li>
                            {foreach from=$group->links item=link name=links}
                                {if $link->getHref()}
                                    <li>
                                        <a href="{$link->getHref()|escape}" {if $link->isPopup()}target="_blank" rel="noopener"{/if} title="{$link->getTitle()|escape}" id="footlink{$link->getIdentifier()}">
                                            <img alt="" src="{baseDir}/public/images/1px.gif">
                                            {$link->getTitle()|escape}
                                        </a>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                    </li>
                {/foreach}
            </ul>
        </div>

        {if strlen($skin->variant->footer)}
            <div class="userfooter container">
                <div class="row">
                    {$skin->variant->footer}
                </div>
            </div>
        {/if}
    </footer>

    <div class="up">
        <a href="#" title="{translate key="up"}" class="btn fa fa-2x fa-angle-up">
            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
            <span>{translate key="up"}</span>
        </a>
    </div>
</div><!-- and of wrap -->

<div class="modal-overlay"></div><!-- overlay for modal lightbox-->