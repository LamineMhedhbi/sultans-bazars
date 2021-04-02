{if count($products) > 0 && $products != null}
<div class="pos_special_product">
	<div class="container">
		<div class="pos_content">
			{$rows= $config['POS_HOME_SPECIAL_ROWS']}
			<div class="specialSlide">
				{foreach from=$products item=product name=myLoop}
					{if $smarty.foreach.myLoop.index % $rows == 0 || $smarty.foreach.myLoop.first }
					<div class="item-product">
					{/if}			
					<article class="js-product-miniature item_in" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
						<div class="img_block">
							{block name='product_thumbnail'}
							  <a href="{$product.url}" class="thumbnail product-thumbnail">
								<img
								  src = "{$product.cover.bySize.home_default.url}"
								  alt = "{$product.cover.legend}"
								  data-full-size-image-url = "{$product.cover.large.url}"
								>
							  </a>
							{/block}
							<!-- {block name='product_flags'}
							  <ul class="product-flag">
								{foreach from=$product.flags item=flag}
									{if $flag.type == "discount"}
										{continue}
									{/if}
									<li class="{$flag.type}"><span>{$flag.label}</span></li>
								{/foreach}
							  </ul>
							{/block} -->
							<div class="block-inner">
								<a href="#" class="quick-view" data-link-action="quickview"><i class="icon-eye icons"></i><!-- {l s='Quick view' mod='posspecialproducts'} --></a>
							</div>
							<div class="countdown">
								{hook h='timecountdown' product=$product }
								<span 	id="future_date_{$product.id_category_default}_{$product.id_product}"
								class="id_countdown"></span>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="product_desc">
							<div class="pos_title">
								<span class="title-top">{l s='Daily' mod='posspecialproducts'}</span>
								<h2>{l s='Deals' mod='posspecialproducts'}</h2>
							</div>
						   {if isset($product.id_manufacturer)}
							<div class="manufacturer"><a href="{$link->getManufacturerLink($product.id_manufacturer)}">{$product.manufacturer_name|strip_tags:'UTF-8'|escape:'html':'UTF-8'}</a></div>
							{/if}
						  {block name='product_name'}
							<h4><a href="{$product.url}" title="{$product.name}" itemprop="name" class="product_name">{$product.name}</a></h4>
						  {/block}
						  {capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
							{if $smarty.capture.displayProductListReviews}
								<div class="hook-reviews">
								{hook h='displayProductListReviews' product=$product}
								</div>
							{/if}
						  {block name='product_price_and_shipping'}
							{if $product.show_price}
							  <div class="product-price-and-shipping">
								{if $product.has_discount}
								  {hook h='displayProductPriceBlock' product=$product type="old_price"}

								  <span class="regular-price">{$product.regular_price}</span>
								 <!--  {if $product.discount_type === 'percentage'}
									<span class="discount-percentage">{$product.discount_percentage}</span>
								  {/if} -->
								{/if}

								{hook h='displayProductPriceBlock' product=$product type="before_price"}

								<span itemprop="price" class="price">{$product.price}</span>

								{hook h='displayProductPriceBlock' product=$product type='unit_price'}

								{hook h='displayProductPriceBlock' product=$product type='weight'}
							  </div>
							{/if}
						  {/block}
							{block name='product_description_short'}
								<div class="product-desc" itemprop="description">{$product.description_short nofilter}</div>
							{/block}
							<div class="cart">
								{include file='catalog/_partials/customize/button-cart.tpl' product=$product}
							</div>
						</div>
					</article>
					
					{if $smarty.foreach.myLoop.iteration % $rows == 0 || $smarty.foreach.myLoop.last  }
					</div>
					{/if}
				{/foreach}
			</div>
		</div>
	</div>
</div>	
{/if}