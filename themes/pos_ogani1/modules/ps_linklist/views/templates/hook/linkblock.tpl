{foreach $linkBlocks as $linkBlock}
<div class="footer_block col-xs-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 wrapper">
  <h3 class="footer_header">{$linkBlock.title}</h3>
  {assign var=_expand_id value=10|mt_rand:100000}
  <ul class="footer_list toggle-footer" id="footer_sub_menu_{$_expand_id}">
	{foreach $linkBlock.links as $link}
	  <li>
		<a
			id="{$link.id}-{$linkBlock.id}"
			class="{$link.class}"
			href="{$link.url}"
			title="{$link.description}">
		  {$link.title}
		</a>
	  </li>
	{/foreach}
  </ul>
</div>
{/foreach}