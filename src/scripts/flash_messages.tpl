{dynamic}
    {if $flash_messages.error|@count > 0 || $flash_messages.warning|@count > 0 || $flash_messages.info|@count > 0 || $flash_messages.success|@count > 0}
        <div class="container">
            {foreach from=$flash_messages.error item=item key=k}
                {if $data_error.user|@count == 0 && $data_error.comment|@count == 0}
                    <div class="alert-error alert">
                        <button type="button" class="close icon-remove" >
                            <span>{translate key="close"}</span>
                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                        </button>
                        <div class="row">
                            <p>{$item.message}</p>
                        </div>
                    </div>
                {/if}
            {/foreach}

            {foreach from=$flash_messages.warning item=item key=k}
                <div class="alert-warning alert">
                    <button type="button" class="close icon-remove" >
                        <span>{translate key="close"}</span>
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </button>
                    <div class="row">
                        <p>{$item.message}</p>
                    </div>
                </div>
            {/foreach}

            {foreach from=$flash_messages.info item=item key=k}
                <div class="alert-info alert">
                    <button type="button" class="close icon-remove" >
                        <span>{translate key="close"}</span>
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </button>
                    <div class="row">
                        <p>{$item.message}</p>
                    </div>
                </div>
            {/foreach}
            
            {foreach from=$flash_messages.success item=item key=k}
                <div class="alert-success alert">
                    <button type="button" class="close icon-remove" >
                        <span>{translate key="close"}</span>
                        <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                    </button>
                    <div class="row">
                        <p>{$item.message}</p>
                    </div>
                </div>
            {/foreach}
        </div>
    {/if}
{/dynamic}
