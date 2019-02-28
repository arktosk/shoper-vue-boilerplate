{include file='header.tpl'}
<body class="off">
    <div class="main">
        <div class="box unibox" id="box_shopoff">
            <div class="innerbox">
                {if $msg}
                    <p>{$msg|escape|nl2br}</p>
                {else}
                    <p>{translate key='Store has been temporarily disabled by the administrator.'}</p>
                {/if}
            </div>
        </div>
    </div>
</body>
</html>
