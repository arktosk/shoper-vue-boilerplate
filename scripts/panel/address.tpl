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

                    {if $articles && count($articles) > 0}
                        {include file='news/listofarticles.tpl'}
                    {/if}

                    <div class="box" id="box_addresses">
                        <div class="boxhead">
                            <span>{translate key="List of addresses"}</span>
                        </div>

                        <div class="innerbox">
                            {if count($user->user->addresses) > 0}
                                <ul class="addresses">
                                    {foreach from=$user->user->addresses item=address name=list}
                                        {assign var=address value=$address->address}
                                        <li class="{if $smarty.foreach.list.index % 2}odd{else}even{/if}">
                                            {if $address->firstname || $address->lastname}
                                                <p class="name">
                                                    {if $address->firstname}
                                                        {$address->firstname|escape} 
                                                    {/if}
                                                    {if $address->lastname}
                                                        {$address->lastname|escape}
                                                    {/if}
                                                </p>
                                            {/if}

                                            {if $address->company_name}
                                                <p class="company">{$address->company_name|escape}</p>
                                            {/if}

                                            {if $address->tax_id}
                                                <p class="nip">{translate key='Tax ID'}: {$address->tax_id|escape}</p>
                                            {/if}

                                            {if $address->pesel}
                                                <p class="pesel">{translate key='Personal Identification Number'}: {$address->pesel|escape}</p>
                                            {/if}

                                            {if $address->street_1}
                                                <p class="address">{$address->street_1|escape}</p>
                                            {/if}

                                            {if $address->zip_code || $address->city}
                                                <p class="city">
                                                    {if $address->zip_code}
                                                        {$address->zip_code|escape}, 
                                                    {/if}
                                                    {if $address->city}
                                                        {$address->city|escape}
                                                    {/if}
                                                </p>
                                            {/if}

                                            {if $address->state}
                                                <p class="state">{$address->state|escape}</p>
                                            {/if}

                                            {if $address->country}
                                                <p class="country">{$address->country|escape}</p>
                                            {/if}

                                            {if $address->phone}
                                                <p class="phone">{$address->phone|escape}</p>
                                            {/if}

                                            <div class="links">
                                                <a href="{route key='panelAddressEdit' addressId=$address->address_book_id}" class="edit btn spanhover">
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                    <span>{translate key='edit'}</span>
                                                </a>

                                                <a href="{route key='panelAddressRemove' addressId=$address->address_book_id}" class="remove btn spanhover titlequestion" title="{translate key='Are you sure you want to remove the address: %s, %s %s?' p1=$address->street_1|escape p2=$address->zip_code|escape p3=$address->city|escape}">
                                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                    <span>{translate key='remove'}</span>
                                                </a>

                                                {if 0 == $address->default}
                                                    <a href="{route key='panelAddressDefault' addressId=$address->address_book_id}" class="default spanhover btn">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                        <span>{translate key='set as billing address'}</span>
                                                    </a>
                                                {else}
                                                    <em class="default">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                        <span>{translate key='default billing address'}</span>
                                                    </em>
                                                {/if}
                                                
                                                {if 0 == $address->shipping_default}
                                                    <a href="{route key='panelAddressShipping' addressId=$address->address_book_id}" class="shipping spanhover btn">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                        <span>{translate key='set as delivery address'}</span>
                                                    </a>
                                                {else}
                                                    <em class="shipping">
                                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                                        <span>{translate key='default delivery address'}</span>
                                                    </em>
                                                {/if}
                                            </div>
                                        </li>
                                    {/foreach}
                                </ul>
                            {/if}

                            <a class="add btn-red spanhover btn" href="{route key='panelAddressEdit'}">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                <span>{translate key='Add an address'}</span>
                            </a>
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
