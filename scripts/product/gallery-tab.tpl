{if count($galleryGfxs) > 1 && 1 == (int) $skin_settings->productdetails->miniaturesposition}
    <div class="box row tab" id="box_productgallery">
        <div class="boxhead tab-head">
            <h3>
                <img src="{baseDir}/public/images/1px.gif" alt="" class="px1">
                {translate key="Product gallery"}
            </h3>
        </div>

        <div class="innerbox tab-content">
            <div class="gallery f-row">
                {foreach from=$galleryGfxs item=img name=list}
                    <div class="f-grid-4">
                        <a id="prodimg{$img->getIdentifier()}" data-gallery="true" data-gallery-list="{$product->translation->name|escape}" href="{imageUrl type='productGfx' image=$img->gfx->unic_name}" title="{$img->translation->name|escape}" class="gallery-img">
                            <img src="{imageUrl width=$skin_settings->img->small height=$skin_settings->img->small type='productGfx' image=$img->gfx->unic_name}" alt="{$img->translation->name|escape}">
                        </a>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{/if}