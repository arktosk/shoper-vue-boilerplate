            <div class="submenu level{$level}">
                <ul class="level{$level}">
                    {foreach from=$headermenu_categories item=cat}
                        <li class="{if count($cat->getActiveLangChildrenList())}parent{/if}" id="hcategory_{$cat->getIdentifier()|escape}">
                            <h3>
                                <a href="{route function='category' key=$cat->getIdentifier() categoryName=$cat->translation->name categoryId=$cat->getIdentifier() view=$view resetparams=true}"
                                    title="{$cat->translation->name|escape}" id="headercategory{$cat->getIdentifier()}" class="spanhover">
                                    <span>{$cat->translation->name|escape}</span>
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" />
                                </a>
                            </h3>
                            
                            {if count($cat->getActiveLangChildrenList())}
                                {assign var=uplevel value=$level+1}
                                {include file='headermenu.tpl' level=$uplevel headermenu_categories=$cat->getActiveLangChildrenList()}
                            {/if}
                        </li>
                    {/foreach}
                </ul>
            </div>
