                    <div class="box resetcss box_custom" id="{if $boxNs->$box_id->css}{$boxNs->$box_id->css|escape}{else}box_custom{$box_id|escape}{/if}">
                    {if 1 == $boxNs->$box_id->border}
                        {if $boxNs->$box_id->title}
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        {/if}
                        <div class="innerbox">
                    {/if}

                    {if 0 == $boxNs->$box_id->mode}
                        {$boxNs->$box_id->html}
                    {/if}

                    {if 1 == $boxNs->$box_id->mode}
                        {$boxNs->$box_id->text}
                    {/if}

                    {if 2 == $boxNs->$box_id->mode}
                        {if 'swf' == substr($boxNs->$box_id->img, -3)}
                            <!--[if !IE]> -->
                            <object type="application/x-shockwave-flash" data="{baseDir}/{$boxNs->$box_id->img}">
                                <param name="movie" value="{baseDir}/{$boxNs->$box_id->img}" />
                                <param name="loop" value="true" />
                                <param name="menu" value="false" />
                                <param name="wmode" value="transparent" />
                            </object>
                            <!-- <![endif]-->
                            <!--[if IE]>
                            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0">
                                <param name="movie" value="{baseDir}/{$boxNs->$box_id->img}" />
                                <param name="loop" value="true" />
                                <param name="menu" value="false" />
                                <param name="wmode" value="transparent" />
                            </object>
                            <![endif]-->
                        {else}
                            <img src="{baseDir}/{$boxNs->$box_id->img}" alt="">
                        {/if}
                    {/if}

                    {if 1 == $boxNs->$box_id->border}
                        </div>
                    {/if}
                    </div>
