{assign var=fs value=$user->basket->methodForFreeShipping()}
{if $fs}
                    <div class="box" id="box_freeshipping">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            <div class="arrow"><img src="{baseDir}/public/images/1px.gif" alt="" class="px1"></div>
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if 0 == $user->basket->count()}
                                {translate key='Free shipping (%s) on orders of %s and more.' p1=$fs->translation->name currency1=$fs->shipping->free_shipping format=true}
                            {else}
                                {assign var=freeshipping_sum value=$user->basket->sumProducts()}
                                {if $freeshipping_sum > $fs->shipping->free_shipping}
                                    {translate key='Order higher than %s - you get a free shipping (%s).' currency1=$fs->shipping->free_shipping p1=$fs->translation->name format=true}
                                {elseif $freeshipping_sum == $fs->shipping->free_shipping}
                                    {translate key='Order for %s - you get a free shipping (%s).' currency1=$fs->shipping->free_shipping p1=$fs->translation->name format=true}
                                {else}
                                    {assign var=freeshipping_sum_left value=$fs->shipping->free_shipping-$freeshipping_sum}
                                    {translate key='You need another %s for free shipping (%s).' currency1=$freeshipping_sum_left p1=$fs->translation->name format=true}
                                {/if}
                            {/if}
                        </div>
                    </div>
{/if}
