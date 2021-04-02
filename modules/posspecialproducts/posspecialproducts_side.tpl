{if count($products) > 0 && $products != null}
	<div class="product_container">
		<div class="pos_special_product_side">
			<div class="header_title">
				<h3>{l s='On sale' mod='posspecialproducts'}</h3>
			</div>
			<div class="product_side">
			<div class="row">
				{$rows= $config['POS_HOME_SPECIAL_ROWS']}
				<div class="specialSlide_side">
					{foreach from=$products item=product name=myLoop}
						{if $smarty.foreach.myLoop.index % 3 == 0 || $smarty.foreach.myLoop.first }
							<div class="item_out">
						{/if}
							<div class="item">
								<article class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
									<div class="img_block">
										{block name='product_thumbnail'}
										  <a href="{$product.url}" class="thumbnail product-thumbnail">
											<img
											  src = "{$product.cover.bySize.side_default.url}"
											  alt = "{$product.cover.legend}"
											  data-full-size-image-url = "{$product.cover.large.url}"
											>
										  </a>
										{/block}
									</div>
									<div class="product_desc">
									  {block name='product_name'}
										<a href="{$product.url}" title="{$product.name}" itemprop="name" class="product_name">{$product.name}</a>
									  {/block}
									  {block name='product_price_and_shipping'}
										{if $product.show_price}
										  <div class="product-price-and-shipping">
											{if $product.has_discount}
											  {hook h='displayProductPriceBlock' product=$product type="old_price"}

											  <span class="regular-price">{$product.regular_price}</span>
											  {if $product.discount_type === 'percentage'}
												<span class="discount-percentage">{$product.discount_percentage}</span>
											  {/if}
											{/if}

											{hook h='displayProductPriceBlock' product=$product type="before_price"}

											<span itemprop="price" class="price">{$product.price}</span>

											{hook h='displayProductPriceBlock' product=$product type='unit_price'}

											{hook h='displayProductPriceBlock' product=$product type='weight'}
										  </div>
										{/if}
									  {/block}
									</div>
								</article>
							</div>
						{if $smarty.foreach.myLoop.iteration % 3 == 0 || $smarty.foreach.myLoop.last  }
							</div>
						{/if}
					{/foreach}
				</div>
			</div>
			</div>
		</div>
	</div>
{/if}