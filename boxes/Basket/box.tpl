                    <div class="box" id="box_basket">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            <div class="arrow"><a href="{route key='basket'}" title="{translate key='Cart'}" rel="nofollow"><img src="{baseDir}/public/images/1px.gif" alt="" class="px1"></a></div>
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            <p class="products"><span>{translate key="products"}:</span> <em>{$user->basket->countProducts()}</em></p>
                            <p class="sum"><span>{translate key="value"}:</span> <em>{currency value=$user->basket->sumProducts()}</em></p>
                            <p class="basket"><a href="{route key='basket'}" title="{translate key='Cart'}" rel="nofollow">{translate key="go to cart"}</a></p>
                        </div>
                    </div>
