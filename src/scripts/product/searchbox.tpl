    <div class="box{if is_object($products) && $products->getCurrentItemCount() > 0} folden{/if}" id="box_productsearch">
        <div class="boxhead">
            <span>
                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                {translate key="Product search"}
            </span>
        </div>

        <div class="innerbox">
            <form class="formprotect" method="post" action="{route key='search'}">
                <fieldset>
                    {include file='formantispam.tpl'}
                    <input type="hidden" name="ProductFilter" value="1">
                    <div class="row">
                        <div class="name f-row">
                            <div class="name-label f-grid-4">
                                <label for="search1">{translate key="Name or description"}:</label>
                            </div>

                            <div class="f-grid-8">
                                <input id="search1" class="{if $data_error.search}error{/if}" type="text" name="search" value="{$data.search|escape}" placeholder="" size="30">
                                {if $data_error.search}
                                    <ul class="error">
                                        {foreach from=$data_error.search item=err_text}
                                            <li>{$err_text|escape}</li>
                                        {/foreach}
                                    </ul>
                                {/if}
                            </div>
                        </div>

                        {if $filter_price}
                            <div class="price f-row">
                                <div class="price-label f-grid-4">
                                    <label for="search2">{translate key="Price"}:</label>
                                </div>

                                <div class="f-grid-8">
                                    <input id="search2" type="text" name="pricefrom" value="{$data.pricefrom|escape}" class="short">
                                    -
                                   <input type="text" name="priceto" value="{$data.priceto|escape}" class="short">
                                </div>
                            </div>
                        {/if}

                        {if $filter_producer}
                            <div class="manufacturer f-row">
                                <div class="manufacturer-label f-grid-4">
                                    <label for="search3">{translate key="Vendor"}:</label>
                                </div>

                                <div class="f-grid-8">
                                    <select name="producer" id="search3">
                                        <option></option>
                                        {foreach from=$producers item=producer_name key=producer_id}
                                            <option {if $producer_id == $data.producer}selected="selected" {/if}value="{$producer_id|escape}">{$producer_name|escape}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        {/if}

                        <div class="category f-row">
                            <div class="category-label f-grid-4">
                                <label for="search4">{translate key="Category"}:</label>
                            </div>

                            <div class="f-grid-8">
                                <select name="category" id="search4">
                                    <option></option>
                                    {foreach from=$categories item=category}
                                        <option {if $category->category->category_id == $data.category}selected="selected" {/if
                                        }value="{$category->category->category_id|escape}">
                                            {$category->translation->name|escape}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        {if $filter_promotion}
                            <div class="promotion f-row">
                                <div class="promotion-label f-grid-4">
                                    <label for="search5">{translate key="Only On Sale products"}</label>
                                </div>

                                <div class="f-grid-8">
                                    <span class="checkbox-wrap">
                                        <input type="checkbox" value="1" name="promotion" id="search5"{if 1 == $data.promotion} checked="checked"{/if}>
                                        <label for="search5"></label>
                                    </span>
                                </div>
                            </div>
                        {/if}
                    </div>

                    <div class="f-row">
                        <div class="f-grid-4"></div>

                        <div class="buttons f-grid-8">
                            <button type="submit" class="btn btn-red search">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                <span>{translate key="Search"}</span>
                            </button>
                            <button type="reset" class="reset">
                                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                                <span>{translate key="Clean the filter"}</span>
                            </button>
                        </div>
                    </div>

                    {if $view}
                        <input type="hidden" name="view" value="{$view|escape}">
                    {/if}
                </fieldset>
            </form>
        </div>
    </div>
