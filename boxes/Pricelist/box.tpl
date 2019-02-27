{if true == $boxNs->$box_id->show_me}
                    <div class="box" id="box_pricelist">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if  $boxNs->$box_id->format == 1}
                            <div class="row">
                                <ul class="icons">
                                    {if 1 == $boxNs->$box_id->html}
                                    <li class="html">
                                        <a href="{$boxNs->$box_id->html_link|escape}" title="{translate key='Pricelist in HTML format'}" class=" html">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="HTML"}</span>
                                        </a>
                                    </li>
                                    {/if}
                                    {if 1 == $boxNs->$box_id->xls}
                                        <li class="excel">
                                            <a href="{$boxNs->$box_id->xls_link|escape}" title="{translate key='Pricelist in Excel format'}" class=" excel">
                                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                                <span>{translate key="XLS"}</span>
                                            </a>
                                        </li>
                                    {/if}
                                </ul>
                            </div>
                            {elseif  $boxNs->$box_id->format == 2}
                            <ul class="listwithicons">
                                {if 1 == $boxNs->$box_id->html}
                                    <li class="html">
                                        <a href="{$boxNs->$box_id->html_link|escape}" title="{translate key='Pricelist in HTML format'}" class=" html">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="HTML"}</span>
                                        </a>
                                    </li>
                                {/if}
                                {if 1 == $boxNs->$box_id->xls}
                                    <li class="excel">
                                        <a href="{$boxNs->$box_id->xls_link|escape}" title="{translate key='Pricelist in Excel format'}" class=" excel">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="Excel"}</span>
                                        </a>
                                    </li>
                                {/if}
                            </ul>
                            {/if}
                        </div>
                    </div>
{/if}
