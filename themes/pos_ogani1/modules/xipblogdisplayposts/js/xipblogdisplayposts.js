jQuery(document).ready(function($) {  
	var blog = $(".blog_slider");
		blog.owlCarousel({
		items : 1,
		slideSpeed: 1000,
		itemsDesktop : [1199,1],
		itemsDesktopSmall : [991,1],
		itemsTablet: [767,1],
		itemsMobile : [480,1],
		navigation:false,
	}); 
});