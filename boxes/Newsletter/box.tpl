                    <div class="box" id="box_newsletter">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            <form action="{route key='newsletterSign' full=true ssl=true}" method="post">
                                <fieldset>
                                    {include file='formantispam.tpl'}
                                    <input type="text" name="email" value=""  placeholder="{translate key='Enter your e-mail address'}" class="newsletter-input">
                                    <button type="submit" class="btn btn-red">
                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                        <span>{translate key="Subscribe"}</span>
                                    </button>

                                    {$boxNs->$box_id->recaptcha}
                                </fieldset>
                            </form>
                        </div>
                    </div>
