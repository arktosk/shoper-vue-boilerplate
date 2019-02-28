{$snippet_pre_body}

{dynamic}
    {if $cookie}
        <div id="cookie" class="none">
            <div class="pagewidth">
                {if $cookiepage}
                    <span>{translate key="This site uses cookies to deliver services in accordance with the %sCookie Files Policy%s. You can set the conditions for storage and access to cookies in your browser settings." s1="<a href=\"$cookiepage\">" s2="</a>"}</span>
                {else}
                    <span>{translate key="This site uses cookies to deliver services in accordance with the %sCookie Files Policy%s. You can set the conditions for storage and access to cookies in your browser settings." s1="" s2=""}</span>
                {/if}
                <span class="close fa fa-times">&nbsp;</span>
            </div>
        </div>
    {/if}
{/dynamic}

<div class="wrap rwd">
    <header class="row">
        {if 1 == $skin_settings->header->basket}
            {dynamic}
                <div class="login-bar row container">
                    <ul class="links right inline">
                        {if true == $user_logged}
                            <li class="hello">
                                {translate key="Hello"} <b>{$user->user->getName()|escape}</b>
                            </li>
                            <li class="myaccount">
                                <a href="{route key='panel'}" title="{translate key="My account"}" class="myaccount">
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                    <span>{translate key="My account"}</span>
                                </a>
                            </li>
                            <li class="logout">
                                <a href="{route key='logout'}" title="{translate key='Sign out'}" class="logout">
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                    <span>{translate key='Sign out'}</span>
                                </a>
                            </li>
                        {else}
                            {if $enable_register}
                                <li class="register">
                                    <a href="{route key='register'}" title="{translate key='Create an account'}" class="register">
                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                        <span>{translate key='Create an account'}</span>
                                    </a>
                                </li>
                            {/if}
                            <li class="login">
                                <a href="{route key='login'}" title="{translate key='Sign in'}" class="login">
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                    <span>{translate key='Sign in'}</span>
                                </a>
                            </li>
                        {/if}
                    </ul>
                </div>
            {/dynamic}                
        {/if}

        <div class="logo-bar row container">
            <a href="{baseDir nonempty=1}" title="{translate key='Home page'}" class="link-logo {if $seo_has_blank_logo}link-logo-text{else}link-logo-img{/if}">
                {if $seo_has_blank_logo}
                    {$seo_logo_title|escape}
                {else}
                    <img src="{$path}images/logo.png" alt="{$seo_logo_title|escape}">
                {/if}
            </a>

            {if 1 == $skin_settings->header->basket}
                {dynamic}
                    <div class="basket right{if 0 == $user->basket->countProducts()} empty-basket{/if}">
                        <a href="{route key='basket'}" title="{translate key='Cart'}" class="count">
                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                            <span class="countlabel">
                                <span>{translate key="Cart"}:</span>
                                <b>
                                    {if 0 == $user->basket->countProducts()}
                                        ({translate key="empty"})
                                    {else}
                                        <b class="sum">{currency value=$user->basket->sumProducts()}</b> 
                                        <b class="count">(<span>{$user->basket->countProducts()}</span>)</b>
                                    {/if}
                                </b>
                            </span>
                        </a>
                    </div>

                    <div class="basket-contain">
                        <div class="basket-products">
                            <ul class="basket-product-list">
                                {foreach from=$user->basket item=basket_product}
                                    {if !$basket_product->isChild()}
                                        <li data-product-id="{$basket_product->product->product->product_id}" data-category="{$basket_product->product->defaultCategory->translation->name|escape}" {if $basket_product->product->product->producer_id}data-producer="{$basket_product->product->producer->manufacturer->name|escape}"{/if}>
                                            <img src="{imageUrl type='productGfx' width=75 height=75 image=$basket_product->stock->mainImageName() overlay=1}" alt="{$basket_product->product->translation->name|escape}" />

                                            <a class="product-name" href="{route function='product' key=$basket_product->product->product->product_id productName=$basket_product->product->translation->name productId=$basket_product->product->product->product_id}" title="{$basket_product->product->translation->name|escape}">
                                                {$basket_product->product->translation->name|escape}

                                                {if $basket_product->getName()}
                                                    <span class="product-variant">{$basket_product->getName()|escape}</span>
                                                {/if}
                                            </a>

                                            <span class="product-info">
                                                <span class="product-amount">{float precision=$QUANTITY_PRECISION value=$basket_product->basket->quantity trim=true}</span> x <span class="product-price">{currency value=$basket_product->getPrice()}</span>
                                            </span>

                                            <span class="remove-product"><a href="{route key='basketRemove' basketId=$basket_product->getIdentifier()}">{translate key="remove"}</a></span>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        </div>
                        
                        <div class="basket-summery">
                            <a href="{route key='basket'}">{translate key="to checkout"}</a>
                            <span class="basket-price{if $user->basket->sumProducts(false, false) !== $user->basket->sumProducts()} basket-price-discount{/if}">
                                <span class="price-total">
                                    <span>{translate key="total"}:</span>
                                    <strong class="price-products">{currency value=$user->basket->sumProducts(false, false)}</strong>
                                </span>
                                {if $user->basket->sumProducts(false, false) !== $user->basket->sumProducts()}
                                <span class="price-total-discount">
                                        <span>{translate key="total (after discount)"}:</span>
                                        <strong class="price-total">{currency value=$user->basket->sumProducts()}</strong>
                                    </span>
                                {/if}
                            </span>
                        </div>
                    </div>
                {/dynamic}
            {/if}

            {if $searchWithSuggest == false}
                <form class="search-form right {if 1 != $skin_settings->header->searchbox}none{/if}" action="{route key='search'}" method="post">
                    <fieldset>
                        <input type="text" name="search" placeholder="{translate key='search in the store...'}" value="" class="search-input s-grid-3" />
                        <button type="submit" class="search-btn btn btn-red">
                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                            <span>{translate key="Search"}</span>
                        </button>
                            <a href="{route key='search'}" title="{translate key='advanced search'}" class="none adv-search">{translate key='advanced search'}</a>
                    </fieldset>
                </form>
            {else}
                <div class="search__container{if $skin_settings->header->searchbox != 1} none{/if}">
                    {include file="search.tpl"}
                </div>
            {/if}
        </div>
    </header>

    {include file='headerlinks.tpl' force_include_cache='1' force_include_cache_key_part=$view force_include_cache_tags='Logic_SkinHeaderLinkList,Logic_SkinHeaderLink,Logic_CategoryList,Logic_Category'}
    
    {if count($breadcrumbs->getBreadCrumbs()) > 0}
        <div class="breadcrumbs large tablet row">
            <div class="innerbreadcrumbs row container">
                <a href="{baseDir nonempty=1}" title="{translate key='Home page'}" rel="nofollow" class="breadcrumb-home left">
                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    <span>{translate key="You are here"}:</span>
                </a>

                <ul class="path left inline">
                    {if $body_class|strstr:"product_new" && $category_name == ''}
                        <li class="bred-2 last">
                            <span class="raq">&raquo;</span> 
                            <span>{translate key="New products"}</span>
                        </li>
                    {elseif $body_class|strstr:"product_promo" && $category_name == ''}
                        <li class="bred-2 last">
                            <span class="raq">&raquo;</span> 
                            <span>{translate key="Promotions"}</span>
                        </li>
                    {elseif $body_class|strstr:"shop_links_list" && $category_name == ''}
                        <li class="bred-2 last">
                            <span class="raq">&raquo;</span> 
                            <span>{translate key="Links"}</span>
                        </li>
                    {/if}

                    {foreach from=$breadcrumbs->getBreadCrumbs() item=item name=bclist}
                        <li class="bred-{$smarty.foreach.bclist.iteration} {if $smarty.foreach.bclist.last}last{/if}" {if $item.url}itemscope itemtype="http://data-vocabulary.org/Breadcrumb"{/if}>
                            {if $item.url}<a href="{$item.url|escape}" itemprop="url">{/if}
                                <span class="raq">&raquo;</span>   
                                <span{if $item.url} itemprop="title"{/if}>{$item.name}</span>
                            {if $item.url}</a>{/if}
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}

    {dynamic}
        {include file='flash_messages.tpl'}
    {/dynamic}

    {dynamic}
        {if count($banners) > 0}
            <div class="banners">
                <div class="innerbanners container">
                    {foreach from=$banners item=banner}
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
            </div>
        {/if}
    {/dynamic}
        
    {if $boxes_header_side|@count > 0}
        <div class="top row">
            <div class="container">
                {dynamic}
                    {foreach from=$boxes_header_side item=v key=k}
                        {box file="../boxes/$v/box.tpl" box="$k"}
                    {/foreach}
                {/dynamic}
            </div>
        </div>
    {/if}