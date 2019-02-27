                    <div class="box" id="box_languages">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if  $boxNs->$box_id->format == 1}
                            <label class="singleselect" for="box_languages_select">{translate key="Select a language"}</label>
                            <select class="singleselect gotourl" id="box_languages_select">
                                {foreach from=$boxNs->$box_id->list item=language}
                                <option{if $language->name == $boxNs->$box_id->language} selected="selected"{/if} value="{$language->url}">{$language->title|escape}</option>
                                {/foreach}
                            </select>
                            {elseif  $boxNs->$box_id->format == 2}
                            <ul class="listwithicons">
                                {foreach from=$boxNs->$box_id->list item=language}
                                <li{if $language->name == $boxNs->$box_id->language} class="selected"{/if}>
                                    <a href="{$language->url}" title="{$language->title|escape}" class="spanhover">
                                        <img src="{baseDir}/public/flags/{$language->name|escape}.png" alt="">
                                        <span>{$language->title|escape}</span>
                                    </a>
                                </li>
                                {/foreach}
                            </ul>
                            {elseif  $boxNs->$box_id->format == 3}
                            <div class="floatcenterwrap row">
                                <ul class="icons floatcenter">
                                    {foreach from=$boxNs->$box_id->list item=language}
                                    <li{if $language->name == $boxNs->$box_id->language} class="selected"{/if}>
                                        <a href="{$language->url}" title="{$language->title|escape}" class="{$language->name|escape}">
                                            <img src="{baseDir}/public/flags/{flagName id=$language->locale_id}.png" alt="{$language->title|escape}">
                                        </a>
                                    </li>
                                    {/foreach}
                                </ul>
                            </div>
                            {/if}
                        </div>
                    </div>
