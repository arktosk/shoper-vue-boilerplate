{if true == $boxNs->$box_id->show_me}
                    <div class="box" id="box_productfilter">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape} {$boxNs->$box_id->layout_type}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            <form class="formprotect" method="post" action="{url}">
                                <fieldset>
                                    {include file='formantispam.tpl'}
                                    <input type="hidden" name="ProductFilter" value="1" >
                                    <div class="pricegroup">
                                    {strip}
                                        <span class="pricelabel">{translate key='Price'}:</span>
                                        <div class="shaded_inputwrap pricefrom">
                                            <input type="text" name="pricefrom" value="{$productfilter_from|escape}" class="shaded_text short" >
                                        </div>
                                        <span class="divide">&divide;</span>
                                        <div class="shaded_inputwrap priceto">
                                            <input type="text" name="priceto" value="{$productfilter_to|escape}" class="shaded_text short" >
                                        </div>
                                    {/strip}
                                    </div>

                                    {if count($boxNs->$box_id->producers) > 0}
                                    <div class="producergroup">
                                        <label for="selectproducer" class="producer">{translate key='Vendor'}:</label>
                                        <select name="producer" id="selectproducer">
                                            <option></option>
                                            {foreach from=$boxNs->$box_id->producers item=producer_name key=producer_id}
                                                <option {if $producer_id == $productfilter_producer}selected="selected" {/if}value="{$producer_id|escape}">{$producer_name|escape}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    {/if}

                                    <div class="promogroup">
                                        <input type="checkbox" value="1" name="promotion" id="filter_promotion" {if 1 == $productfilter_promotion} checked="checked"{/if}>
                                        <label for="filter_promotion">{translate key="Only On Sale products"}</label>
                                    </div>

                                    <div class="buttons row">
                                        <button type="submit" class="btn filter">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="Filter"}</span>
                                        </button>
                                        <button type="submit" class="btn clearbutton resetsubmit">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="Clean the filter"}</span>
                                        </button>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
{/if}
