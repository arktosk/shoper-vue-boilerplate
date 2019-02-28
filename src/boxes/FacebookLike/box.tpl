{if $boxNs->$box_id->pageid > 0}
                    <div class="box {$boxNs->$box_id->format|escape}" id="box_facebooklike">
                        <script type="text/javascript">
                            $(document).ready(function() {literal}{{/literal}
                                w = $('#box_facebooklike').width();
                                h = {if 1 == (int) $boxNs->$box_id->stream}600{else}300{/if};
                                $('#box_facebooklike').html('<iframe class="facebook fb_likebox" ' +
                                'src="https://www.facebook.com/plugins/likebox.php?href=' +
                                escape('http://www.facebook.com/profile.php?id={$boxNs->$box_id->pageid|escape}') +
                                '&amp;width=' + w + '&amp;colorscheme={$boxNs->$box_id->format|escape}' +
                                '&amp;show_faces=true&amp;stream={if 1 == (int) $boxNs->$box_id->stream}true{else}false{/if}' +
                                '&amp;header=true&amp;height=' + h + '&amp;font=tahoma&amp;locale={lang key='long'}" ' +
                                'scrolling="no" frameborder="0" style="border:none; overflow: hidden; width: ' + w +
                                'px; height:' + h + 'px;" allowTransparency="true"></iframe>');
                            {literal}}{/literal});
                        </script>
                    </div>
{/if}
