{if count($boxNs->$box_id->banners) > 0}
    <div class="box box_banner" id="box_banner{$box_id}">
            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
            {foreach from=$boxNs->$box_id->banners item=banner}
                {if 'swf' == substr($banner->banner->file, -3)}
                    <!--[if !IE]> -->
                    <object type="application/x-shockwave-flash" data="{baseDir}/{$banner->getUrl()}?clickTag={$banner->clickTagLink()|escape}" width="{$banner->banner->width|escape}" height="{$banner->banner->height|escape}" title="{$banner->banner->name|escape}">
                        <param name="movie" value="{baseDir}/{$banner->getUrl()}?clickTag={$banner->clickTagLink()|escape}" />
                        <param name="loop" value="true" />
                        <param name="menu" value="false" />
                        <param name="wmode" value="transparent" />
                    </object>
                    <!-- <![endif]-->
                    <!--[if IE]>
                    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="{$banner->banner->width|escape}" height="{$banner->banner->height|escape}">
                        <param name="movie" value="{baseDir}/{$banner->getUrl()}?clickTag={$banner->clickTagLink()|escape}" />
                        <param name="loop" value="true" />
                        <param name="menu" value="false" />
                        <param name="wmode" value="transparent" />
                    </object>
                    <![endif]-->
                {else}
                    <a {if 1 == (int) $banner->banner->blank}target="_blank" rel="noopener"{/if} href="{route key='banner' bannerId=$banner->getIdentifier()}" title="{$banner->banner->name|escape}" class="banner">
                        <img src="{baseDir}/{$banner->getUrl()}" alt="{$banner->banner->name|escape}" width="{$banner->banner->width|escape}" height="{$banner->banner->height|escape}" />
                    </a>
                {/if}
            {/foreach}
    </div>
{/if}
