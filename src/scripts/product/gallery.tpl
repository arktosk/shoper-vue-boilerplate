<div class="productimg f-grid-6">
    <div class="mainimg productdetailsimgsize row">
        {if count($galleryGfxs)}
            {assign var=img value=$galleryGfxs.0}
        {/if}
        {if 1 == count($galleryGfxs)}
            <a id="prodimg{$img->getIdentifier()}" data-gallery-list="{$product->translation->name|escape}" data-gallery="true" href="{imageUrl type='productGfx' image=$img->gfx->unic_name}" title="{$img->translation->name|escape}">
                <img class="photo {if 1 == (int) $skin_settings->productdetails->productzoom}innerzoom {elseif 2 == (int) $skin_settings->productdetails->productzoom}outerzoom {/if
                            }" src="{imageUrl type='productGfx' width=$skin_settings->img->big height=$skin_settings->img->big image=$img->gfx->unic_name}" alt="{$img->translation->name|escape}">
            </a>
        {else}
            <img class="photo {if 1 == (int) $skin_settings->productdetails->productzoom}innerzoom {elseif 2 == (int) $skin_settings->productdetails->productzoom}outerzoom {/if
                            }productimg{if $product->defaultStock->mainImageId()} gallery_{$product->defaultStock->mainImageId()}{/if}" src="{imageUrl
                                type='productGfx' width=$skin_settings->img->big height=$skin_settings->img->big image=$product->defaultStock->mainImageName() overlay=1}" alt="{$img->translation->name|escape}" />
        {/if}

        {if $product->specialOffer || $product->isNew()}
            <ul class="tags">
                {if $product->specialOffer}
                    <li class="promo">{translate key="on sale tag"}</li>
                {/if}
                {if $product->isNew()}
                    <li class="new">{translate key="new product tag"}</li>
                {/if}
            </ul>
        {/if}
    </div>
        
    <div class="smallgallery row">
        {if count($galleryGfxs) > 1 && 0 == (int) $skin_settings->productdetails->miniaturesposition}
            <div class="innersmallgallery">
                <ul class="r--l-flex r--l-flex-wrap">
                    {foreach from=$galleryGfxs item=img}
                        {assign var=imgId value=$img->getIdentifier()}
                        <li class="r--l-flex r--l-flex-vcenter">
                            <a id="prodimg{$img->getIdentifier()}" data-gallery-list="{$product->translation->name|escape}" data-gallery="true" href="{imageUrl type='productGfx' image=$img->gfx->unic_name}" title="{$img->translation->name|escape}" class="gallery{if $img->getIdentifier() == $product->defaultStock->mainImageId()} current{/if}">
                                <img src="{imageUrl type='productGfx' width=$skin_settings->img->mini height=$skin_settings->img->mini
                                image=$img->gfx->unic_name}" alt="{$img->translation->name|escape}" data-img-name="{imageUrl type='productGfx' width=$skin_settings->img->big height=$skin_settings->img->big image=$img->gfx->unic_name}">
                            </a>
                        </li>
                    {/foreach}
                </ul>

                <nav class="hide">
                    <span class="smallgallery-left none"></span>
                    <span class="smallgallery-right"></span>
                </nav>
            </div>
        {/if}
    </div>
</div>