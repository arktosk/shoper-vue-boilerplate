 
    <div class="menu row{if !count($headerlinks)} small{/if}">
        <nav class="innermenu row container relative">
            {if count($headerlinks)}
                <ul class="menu-list large standard">
                    <li class="home-link-menu-li">
                        <h3>
                            <a href="{baseDir nonempty=1}" title="{translate key='Home page'}">
                                <img src="{baseDir}/public/images/1px.gif" alt="{translate key='Home page'}" class="px1">
                            </a>
                        </h3>
                    </li>

                    {foreach from=$headerlinks item=link}
                        {if $link->getHref() || $link->isActiveCategory() || $link->isActiveNewsCategory()}
                            <li{if $link->hasSubCategories() || $link->hasNewsSubCategories()} class="parent"{/if}{if $link->isCategory()} id="hcategory_{$link->getCategoryId()|escape}"{elseif $link->isNewsCategory()} id="ncategory_{$link->getNewsCategoryId()|escape}"{/if}>
                                <h3>
                                    <a {if $link->isPopup()}target="_blank" rel="noopener"{/if} href="{$link->getHref($view)|escape}" title="{$link->getTitle()|escape}" id="headlink{$link->getIdentifier()}" class="spanhover mainlevel">
                                        <span>{$link->getTitle()|escape}</span>
                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                    </a>
                                </h3>
                                {if $link->hasSubCategories()}
                                    {include file='headermenu.tpl' level=1 headermenu_categories=$link->getActiveLangChildrenList()}
                                {elseif $link->hasNewsSubCategories()}
                                    {include file='headernews.tpl' headernews_categories=$link->getNewsActiveLangChildrenList()}
                                {/if}
                            </li>
                        {/if}
                    {/foreach}
                </ul>
            {/if}

            <ul class="menu-mobile rwd-show-medium rwd-hide-full">
                <li class="menu-mobile-li small-menu flex flex-4">
                    <a href="{baseDir nonempty=1}" title="{translate key='Menu'}" class="fa fa-align-justify">
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </a>
                </li>
                <li class="menu-mobile-li small-search flex flex-4" id="activ-search">
                    <a title="{translate key='Search'}" class="fa fa-search">
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </a>
                </li>
                <li class="menu-mobile-li small-panel flex flex-4" id="activ-panel">
                    <a href="{route key='panel'}" title="{translate key='My account'}" class="fa fa-user">
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </a>
                </li>
                <li class="menu-mobile-li small-cart flex flex-4">
                    <a href="{route key='basket'}" title="{translate key='Cart'}" class="icon icon-custom-cart">
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    
