<div class="box" id="box_article_calendar">
    <div class="boxhead">
        <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
    </div>
    <div class="innerbox">
        {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
        <table class="calendar">
            <thead>
                <tr>
                    <td>{dayOfWeek value=0}</td>
                    <td>{dayOfWeek value=1}</td>
                    <td>{dayOfWeek value=2}</td>
                    <td>{dayOfWeek value=3}</td>
                    <td>{dayOfWeek value=4}</td>
                    <td>{dayOfWeek value=5}</td>
                    <td>{dayOfWeek value=6}</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    {dynamic}
                        {assign var="dayOfWeek" value=$boxNs->$box_id->dayOfWeek}
                        {assign var="days" value=$boxNs->$box_id->days->toArray()}

                        {if $boxNs->$box_id->dayOfWeek > 0}
                            <td colspan="{$dayOfWeek}"></td>
                        {/if}

                        {section name=list start=1 loop=$boxNs->$box_id->numberDays+1}
                            {if $dayOfWeek == 7}
                                {assign var="dayOfWeek" value="0"}
                                </tr><tr>
                            {/if}
                            <td {if $smarty.section.list.index|in_array:$days} class="focused"{/if}>
                                {if $smarty.section.list.index|in_array:$days}
                                    <a href="{route function='newsListDate' key='' newsYear=$boxNs->$box_id->year newsMonth=$boxNs->$box_id->month newsDay=$smarty.section.list.index}">{$smarty.section.list.index}</a>
                                {else}
                                    {$smarty.section.list.index}
                                {/if}
                            </td>
                            {assign var="dayOfWeek" value=$dayOfWeek+1}
                        {/section}

                        {if $dayOfWeek != 7}
                            <td colspan="{7 - $dayOfWeek}"></td>
                        {/if}
                    {/dynamic}
                </tr>
            </tbody>
        </table>
                
        {dynamic}
            <nav class="calendar-nav">
                <a class="calendar-nav-prev" href="{route function='newsListDate' key='' newsYear=$boxNs->$box_id->prevYear newsMonth=$boxNs->$box_id->prevMonth}">&laquo; {date value=$boxNs->$box_id->prevTime format='MMM yyyy'}</a>
                {if $boxNs->$box_id->nextYear}
                    <a class="calendar-nav-next" href="{route function='newsListDate' key='' newsYear=$boxNs->$box_id->nextYear newsMonth=$boxNs->$box_id->nextMonth}">{date value=$boxNs->$box_id->nextTime format='MMM yyyy'} &raquo;</a>
                {/if}
            </nav>
        {/dynamic}
    </div>
</div>
