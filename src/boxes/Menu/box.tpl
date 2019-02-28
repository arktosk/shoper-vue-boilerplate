                    <div class="box" id="box_menu">
                        <div class="large standard boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if 1 == $boxNs->$box_id->format}
                            <ul class="standard">
                            {else}
                            <ul class="folded">
                            {/if}
                                {$boxNs->$box_id->list}
                                {if 1 == $boxNs->$box_id->link_news}<li id="category_novelties"><a href="{$boxNs->$box_id->url_new}" title="{translate key='New products'}" class="novelties"><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{translate key="New products"}</a></li>{/if}
                                {if 1 == $boxNs->$box_id->link_promotions}<li id="category_promo"><a href="{$boxNs->$box_id->url_promotions}" title="{translate key='Products on sale'}" class="promo"><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{translate key="Products on sale"}</a></li>{/if}
                            </ul>
                        </div>
                    </div>
