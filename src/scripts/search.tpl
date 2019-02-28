
<form data-product-view-type="{$view|escape}" data-search-promotions-route="{route key="promotions"}" data-base-dir="{baseDir}" class="js__search search search-form" action="{route key='search'}" method="post">
    {include file="formantispam.tpl"}
    <div class="search-input search__input-area r--l-flex r--l-flex-vcenter">
        <div class="search__input-area-item">
            <span class="js__search-clear-btn search__btn icon icon-close search__icon none" role="button" aria-label="clear search input"></span>
            <img class="search__loader none" src="{baseDir}/public/images/loader.svg">
        </div>
        
        <div class="search__input-area-item search__input-area-item_grow">
            <input class="search__input" name="search" type="search" autocomplete="off" placeholder="{translate key='Search'}">
        </div>

        <div class="search__input-area-item">
            <span class="js__search-close-btn icon icon-back" role="button" aria-label="close search"></span>
            <button type="button" class="js__search-submit-btn search-btn search__input-area-item btn btn-red search__btn-search r--l-flex r--l-flex-vcenter r--l-flex-hcenter">
                <span class="fa fa-search search__icon_size-l"></span>
            </button>
        </div>
    </div>

    <div class="search__content"></div>
    
    <input type="hidden" class="js__search-settings" value="{$searchFrontSettings|@json_encode|@base64_encode}">
</form>