                    <div class="box" id="box_search">
                        <div class="boxhead">
                            <span><img src="{baseDir}/public/images/1px.gif" alt="" class="px1">{$boxNs->$box_id->title|escape}</span>
                        </div>
                        <div class="innerbox">
                            {if $boxNs->$box_id->text}<h5 class="boxintro">{$boxNs->$box_id->text}</h5>{/if}
                            
                            {if $searchWithSuggest == false}
                                <form action="{route key='search'}" method="post">
                                    <fieldset>
                                        {include file='formantispam.tpl'}
                                        <input type="text" name="search" placeholder="{translate key='search in the store...'}" value="" class="search-input">
                                        <button class="btn btn-red" type="submit">
                                            <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                            <span>{translate key='Search'}</span>
                                        </button>
                                        {if 1 == $boxNs->$box_id->extended}
                                        <a class="advanced-search" href="{route key='search'}" title="{translate key='Go to advanced search'}">{translate key="advanced search"}</a>
                                        {/if}
                                    </fieldset>
                                </form>
                            {else}
                                {include file="search.tpl"}
                            {/if}
                        </div>
                    </div>
