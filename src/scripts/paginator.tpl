{assign var="stick" value=false}

{if !$router_name_first}
    {assign var="router_name_first" value=$router_name}
{/if}
{if !$router_params}
    {assign var="router_params" value=null}
{/if}

{if $pages->pageCount > 0}

    <ul class="paginator">

    {if isset($pages->previous) && $pages->previous > 0}
        <li class="first"><a href="{array __key=urlOptions page=$pages->previous}{arrayMerge __key=urlOptions a1=$router_params a2=$urlOptions}{assemble params=$urlOptions route=$router_name type=$router_type}{if $google}?{$google|escape}{/if}" title="">&laquo;</a></li>
    {else}
        <li class="first"><span>&laquo;</span></li>
    {/if}

    {if $pages->firstPageInRange > 1}
        <li><a href="{array __key=urlOptions page=1}{arrayMerge __key=urlOptions a1=$router_params a2=$urlOptions}{assemble params=$urlOptions route=$router_name type=$router_type}{if $google}?{$google|escape}{/if}" title="">1</a></li>
        {assign var="stick" value=true}
        {if $pages->firstPageInRange > 2}
            <li class="stick"><span>|</span></li><li><span>...</span></li>
        {/if}
    {/if}

    {foreach from=$pages->pagesInRange item=b}
        {if $stick}
            <li class="stick"><span>|</span></li>
        {/if}
        {assign var="stick" value=true}
        {if $b == $pages->current}
            <li class="selected"><span>{$b}</span></li>
        {else}
            {if $b == 1}
                <li><a href="{array __key=urlOptions page=$b}{arrayMerge __key=urlOptions a1=$router_params a2=$urlOptions}{assemble params=$urlOptions route=$router_name_first type=$router_type}{if $google}?{$google|escape}{/if}" title="">{$b}</a></li>
            {else}
                <li><a href="{array __key=urlOptions page=$b}{arrayMerge __key=urlOptions a1=$router_params a2=$urlOptions}{assemble params=$urlOptions route=$router_name type=$router_type}{if $google}?{$google|escape}{/if}" title="">{$b}</a></li>
            {/if}
        {/if}
    {/foreach}

    {if $b != $pages->pageCount}
        {if $pages->pageCount - $b > 1}
            <li class="stick"><span>|</span></li><li><span>...</span></li>
        {/if}
        <li class="stick"><span>|</span></li><li><a href="{array __key=urlOptions page=$pages->pageCount}{arrayMerge __key=urlOptions a1=$router_params a2=$urlOptions}{assemble params=$urlOptions route=$router_name type=$router_type}{if $google}?{$google|escape}{/if}" title="">{$pages->pageCount}</a></li>
    {/if}

    {if isset($pages->next) && $pages->next > 0}
        <li class="last"><a href="{array __key=urlOptions page=$pages->next}{arrayMerge __key=urlOptions a1=$router_params a2=$urlOptions}{assemble params=$urlOptions route=$router_name type=$router_type}{if $google}?{$google|escape}{/if}" title="">&raquo;</a></li>
    {else}
        <li class="last"><span>&raquo;</span></li>
    {/if}
    </ul>
{/if}