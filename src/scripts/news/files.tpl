{if $can_download !== false && $article_files !== false && $article_files|count > 0}
    <div class="box row tab" id="box_articlefiles">
        <div class="boxhead tab-head">
            <h3>
                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                {translate key="Files"} ({$article->files|count})
            </h3>
        </div>

        <ul class="innerbox tab-content tab-files">
            {foreach from=$article->files item=file name=list}
                <li class="articlefile" id="file{$file->file_id}">
                    <a href="{route key='newsDownload' fileId=$file->file_id fileName=$file->name}" target="_blank" rel="noopener">{$file->name|escape}</a>
                    <p>{$file->description|escape}</p>
                </li>
            {/foreach}
        </ul>
    </div>
{/if}