                    <div class="box" id="box_loyalty">
                        <div class="boxhead">
                            <h3>
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1" >
                                {translate key="Exchangeable products in the loyalty program"}
                            </h3>
                        </div>

                        <div class="innerbox">
                            <span class="user_points">{translate key="Your points: %s" p1=$user_points}</span>
                            <span class="get_more_points tooltip_pointer" title="loyalty_msg">{translate key="How to gain more points"}</span>
                            
                            {if count($loyalty_msgs)}
                                <label class="tooltip indent" id="loyalty_msg">
                                    {foreach from=$loyalty_msgs item=msg}
                                    <p class="title check">{$msg.title|escape}</p>
                                    <p>{$msg.text}</p>
                                    {/foreach}
                                </label>
                            {/if}

                            <form class="loyalty_filter row" method="post" action="{route key='search'}">
                                <fieldset>
                                    <b>{translate key='View'}:</b>
                                    <input type="radio" class="gotourl" name="loylaty_filter" value="{route key='loyaltyList' filter=0}" id="loylaty_filter0"{if 0 == (int) $loyalty_filter} checked="checked"{/if} />
                                    <label for="loylaty_filter0">{translate key='all products'}</label>
                                    <input type="radio" class="gotourl" name="loylaty_filter" value="{route key='loyaltyList' filter=1}" id="loylaty_filter1"{if 1 == (int) $loyalty_filter} checked="checked"{/if} />
                                    <label for="loylaty_filter1">{translate key='available for me'}</label>
                                </fieldset>
                            </form>
                        </div>
                    </div>
