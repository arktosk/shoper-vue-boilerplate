<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
    <body>
        <div class="ask-for-product" {if $mail_send != true}data-header-title="{translate key='ask about product'}:"{/if}>
            {dynamic}
                {include file='flash_messages.tpl'}
            {/dynamic}

            {if true == $mail_send}
                {literal}
                    <script>
                        shoper.ajaxlayer.modal.callbacks.close = function() {
                            setTimeout(function() {
                                this.destroyModal.bind(this)
                                location.reload();
                            }.bind(shoper.ajaxlayer.modal), 600);
                        }
                    </script>
                {/literal}
            {else}
                <form method="post" action="{route key='productQuestion' productId=$productId}" class="multirow">
                    <fieldset>
                        {include file='formantispam.tpl'}

                        <div class="edition-form-field">
                            <label for="question_name">
                                <em class="color">*</em>
                                {translate key='Your name'}:
                            </label>
                            <input type="text" name="name" id="question_name" size="40" value="{$data.name|escape}" class="{if $data_error.name}error{/if}">
                        </div>

                        {if $data_error.name}
                            <ul class="row error">
                                {foreach from=$data_error.name item=err_text}
                                    <li>{$err_text|escape}</li>
                                {/foreach}
                            </ul>
                        {/if}

                        <div class="edition-form-field">
                            <label for="question_mail">
                                <em class="color">*</em>
                                {translate key='Your e-mail address'}:
                            </label>
                            <input type="text" name="mail" id="question_mail" size="40" value="{$data.mail|escape}" class="{if $data_error.mail}error{/if}">
                        </div>

                        {if $data_error.mail}
                            <ul class="row error">
                                {foreach from=$data_error.mail item=err_text}
                                    <li>{$err_text|escape}</li>
                                {/foreach}
                            </ul>
                        {/if}

                        <div class="edition-form-field">
                            <label for="question_text">
                                <em class="color">*</em>
                                {translate key='Question'}:
                            </label>
                            <textarea name="question" id="question_text" rows="5" cols="40" class="{if $data_error.question}error{/if}">{$data.question|escape}</textarea>
                        </div>
                        
                        {if $data_error.question}
                            <ul class="row error">
                                {foreach from=$data_error.question item=err_text}
                                    <li>{$err_text|escape}</li>
                                {/foreach}
                            </ul>
                        {/if}

                        {if $recaptcha}
                            <div data-recaptcha-mode="{$recaptchaMode|escape}" data-recaptcha-key="{$recaptchaSitekey|escape}" id="ask-recaptcha"></div>
                        {/if}

                        
                        <label>{translate key='The reply will be sent to your e-mail address.'}</label>

                        <div>
                            <span><em class="color">*</em> - {translate key="Field mandatory"}</span>
                        </div>

                        <div class="row">
                            <button type="submit" class="btn">
                                <img src="{baseDir}/public/images/1px.gif" alt="{translate key='Send'}" class="px1">
                                <span>{translate key='Send'}</span>
                            </button>
                        </div>
                    </fieldset>
                </form>
            {/if}
        </div>
    </body>
    <script>
        shoper.selectorFunctions.flashmessageclose.domready.call(null, $('.alert .close'));
    </script>
</html>
