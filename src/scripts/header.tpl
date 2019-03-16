<!DOCTYPE html>
<!--[if lte IE 8]>     <html lang="{lang key='short'}" class="lt-ie8"> <![endif]-->
<!--[if IE 9]>         <html lang="{lang key='short'}" class="lt-ie8 lt-ie9"> <![endif]-->
<!--[if gt IE 9]><!--> <html {feature name="pwa"}data-pwa="1"{/feature} lang="{lang key='short'}"> <!--<![endif]-->
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <title>{$seo_title|escape}</title>
    <meta name="keywords" content="{$seo_keywords|escape}" />
    <meta name="description" content="{$seo_description|escape}" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
    <meta name="mobile-web-app-capable" content="yes">
    
    <link rel="home" href="{baseDir nonempty=1}" />
    <link rel="shortcut icon" href="{$path}images/favicon.png">
    {feature name="pwa"}
        <link rel="manifest" href="{baseDir}/public/manifest.json">
    {/feature}
    
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    <link rel="preconnect" href="//fonts.gstatic.com">

    {plugin module=shop template=pre-head}
    
    <link id="csslink" rel="stylesheet" type="text/css" href="{sfc type='css' id=$skin_id user=$user_css gallery=0 lang=$lang_full}" />
    
    <!-- template-styles-needle -->

    <script type="text/javascript" src="{baseDir}/public/scripts/fastdom.min.js"></script>
    <script type="text/javascript" src="{sfc type='js' id=$skin_id user=$user_js gallery=0 lang=$lang_full moo=0 jq=1 mainname='main-jq'}"></script>

    <!-- template-scripts-needle -->

    {if count($seo_links)}
        {foreach from=$seo_links item=v key=k}
            <link rel="{$k|escape}" href="{$v|escape}" />
        {/foreach}
    {/if}

    {if count($opengraph_header)}
        {foreach from=$opengraph_header item=v key=k}
            {if strlen($v)}
                <meta property="og:{$k|escape}" content="{$v|escape}" />
            {/if}
        {/foreach}
    {/if}
    
    {$snippet_head}
    
    {plugin module=shop template=post-head}
</head>
