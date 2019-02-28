                    <div class="box" id="box_loginsmall">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            {if false == $user_logged}
                            <form action="{route key='login' full=true ssl=true}" method="post">
                                <fieldset>
                                    {include file='formantispam.tpl'}
                                    <div class="row login-inputs">
                                    <label for="mail_input">{translate key="E-mail"}:</label>
                                    <input type="text" name="mail" class="mail" id="mail_input">
                                    <label for="pass_input">{translate key="Password"}:</label>
                                    <input type="password" name="pass" class="pass" id="pass_input">
                                    </div>

                                    {$boxNs->$box_id->recaptcha}

                                    <div class="row">
                                        <button type="submit" class="btn login">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="Sign in"}</span>
                                        </button>
                                    </div>
                                    <a href="{$boxNs->$box_id->passlink}" class="remind row">
                                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                        <span>{translate key="Forgot your password?"}</span>
                                    </a>
                                    {if $enable_register}
                                        <a href="{$boxNs->$box_id->reglink}" class="register row">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key="Create an account"}</span>
                                        </a>
                                    {/if}
                                </fieldset>
                            </form>
                            {else}
                                <p class="hello row">{translate key="Hello"} <b>{$user->user->getName()|escape}</b></p>
                                <a href="{route key='panel'}" title="My account" class="myaccount btn btn-red row">
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                    <span>{translate key="My account"}</span>
                                </a>
                                <a href="{route key='logout'}" title="Sign out" class="logout btn row">
                                    <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                    <span>{translate key="Sign out"}</span>
                                </a>
                            {/if}
                        </div>
                    </div>
