{if $boxNs->$box_id->poll}
                    <div class="box" id="box_polls">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            <div class="question row">{$boxNs->$box_id->poll->poll->question|escape}</div>
                            {if true == $boxNs->$box_id->can_vote}
                            <form action="{route key='pollvote' pollId=$boxNs->$box_id->poll->getIdentifier()}" method="post" class="row">
                                <fieldset>
                                    <ul>
                                    {foreach from=$boxNs->$box_id->poll->answers item=answer}
                                        <li>
                                            <input type="radio" name="vote" value="{$answer->answer_id|escape}" id="pollvote_{$answer->answer_id|escape}" />
                                            <label for="pollvote_{$answer->answer_id|escape}">{$answer->answer|escape}</label>
                                        </li>
                                    {/foreach}
                                    </ul>
                                    <input type="hidden" name="redirect" value="{$request_uri|escape}">
                                    <div class="bottombuttons">
                                        <button class="btn" type="submit">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key='Vote'}</span>
                                        </button>
                                    </div>
                                </fieldset>
                            </form>
                            {else}
                            <dl class="row">
                            {foreach from=$boxNs->$box_id->poll->getAnswersDescending() item=answer}
                                <dt{if $boxNs->$box_id->vote == $answer.answer_id} class="voted"{/if}>{$answer.answer|escape}</dt>
                                <dd>
                                    <span class="percentage">{$answer.percent|escape}%</span>
                                    <div class="bar"><div class="filling{* animate*}" style="width: {$answer.percent|escape}%;"></div></div>
                                </dd>
                            {/foreach}
                            </dl>
                            <div class="votecount row">{translate key="Total votes"}: {$boxNs->$box_id->poll->totalVotes()|escape}</div>
                            {/if}
                        </div>
                    </div>
{/if}
