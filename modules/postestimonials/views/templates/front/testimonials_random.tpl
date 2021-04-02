{if $testimonials}
<div class="testimonials_container">
	<div class="container">
		<div class="block_content">
			<div class="testimonialsSlide">
			  {foreach from=$testimonials name=myLoop item=testimonial}
				{if $testimonial.active == 1}
					{if $smarty.foreach.myLoop.index % 1 == 0 || $smarty.foreach.myLoop.first }
					<div class="item-testimonials">
					{/if}	
						<div class="item">
							<div class="content_test">
								<p class="des_testimonial">{$testimonial.content|escape:'html':'UTF-8'}</p>
							</div>
							<div class="content_author">
								{if in_array($testimonial.media_type,$arr_img_type)}
									<div class="img">
										<img src="{$mediaUrl}{$testimonial.media}" alt="Image Testimonial">
									</div>
								{/if}
								<span class="des_namepost">{$testimonial.name_post}</span>
							</div>
						</div>
					{if $smarty.foreach.myLoop.iteration % 1 == 0 || $smarty.foreach.myLoop.last  }
					</div>
					{/if}
				{/if}
			  {/foreach}
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		var testi = $(".testimonialsSlide");
		testi.owlCarousel({
			singleItem : true,
			autoPlay :  false,
			stopOnHover: true,
		});
	});
</script>
 {/if}