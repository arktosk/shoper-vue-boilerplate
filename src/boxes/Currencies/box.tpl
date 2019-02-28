                    <div class="box" id="box_currencies">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if  $boxNs->$box_id->format == 1}
                            <label class="singleselect" for="box_currencies_select">{translate key="Select a currency"}</label>
                            <select class="singleselect gotourl" id="box_currencies_select">
                                {foreach from=$boxNs->$box_id->list item=desc key=cur}
                                <option{if $cur == $boxNs->$box_id->currency} selected="selected"{/if
                                    } value="?currency={$cur|escape}">{$desc|escape}</option>
                                {/foreach}
                            </select>
                            {elseif  $boxNs->$box_id->format == 2}
                            <ul class="listwithicons">
                                {foreach from=$boxNs->$box_id->list item=desc key=cur}
                                <li{if $cur == $boxNs->$box_id->currency} class="selected"{/if
                                    }><a href="?currency={$cur|escape}" title="{$desc|escape}" class="{$cur|escape}">
                                        <!-- <img src="{baseDir}/public/images/{$cur|escape}.png" alt=""> -->
                                        <span>{$desc|escape}</span>
                                        </a>
                                </li>
                                {/foreach}
                            </ul>
                            {/if}
                        </div>
                    </div>
