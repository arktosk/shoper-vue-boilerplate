                    <div class="box" id="box_statistics">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {foreach from=$boxNs->$box_id->stats item=val key=label}
                            <div class="f-row">        
                                <div class="f-grid-6"><img src="{baseDir}/public/images/1px.gif" alt="" class="px1"> {$label|escape}:</div><div class="f-grid-6">{$val|escape}</div>
                            </div>
                            {/foreach}
                        </div>
                    </div>
