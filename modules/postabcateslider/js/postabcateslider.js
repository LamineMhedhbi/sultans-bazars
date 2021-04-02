$(document).ready(function() {
	var $tabcateSlideConf = $('.tab-category-container-slider');
	var items       = $tabcateSlideConf.attr('data-items');
	var speed     	= $tabcateSlideConf.attr('data-speed');
	var autoPlay    = $tabcateSlideConf.attr('data-autoplay');
	var time    	= $tabcateSlideConf.attr('data-time');
	var arrow       = $tabcateSlideConf.attr('data-arrow');
	var pagination  = $tabcateSlideConf.attr('data-pagination');
	var move        = $tabcateSlideConf.attr('data-move');
	var pausehover  = $tabcateSlideConf.attr('data-pausehover');
	var md          = $tabcateSlideConf.attr('data-md');
	var sm          = $tabcateSlideConf.attr('data-sm');
	var xs          = $tabcateSlideConf.attr('data-xs');
	var xxs         = $tabcateSlideConf.attr('data-xxs');
	
	if(autoPlay==1) {
		if(time){
			autoPlay = time;
		}else{
			autoPlay = '3000';
		}
	}else{
		autoPlay = false;
	}
	if(pausehover){pausehover = true}else{pausehover=false}
	if(move){move = true}else{move=false}
	if(arrow){arrow =true}else{arrow=false}
	if(pagination==1){pagination = true}else{pagination=false}

	var tabcateSlide = $(".tab-category-container-slider .productTabCategorySlider");
	tabcateSlide.owlCarousel({
		items :items,
		itemsDesktop : [1199,md],
		itemsDesktopSmall : [991,sm],
		itemsTablet: [767,xs],
		itemsMobile : [480,xxs],
		autoPlay : autoPlay ,
		speed: speed,
		stopOnHover: pausehover,
		addClassActive: true,
		scrollPerPage: move,
		navigation : arrow,
		pagination : pagination,
	});
	
	$(".tab_category").hide();
	$(".tab_category:first").show(); 

	$("ul.tab_cates li").click(function() {
		$("ul.tab_cates li").removeClass("active");
		$(this).addClass("active");
		$(".tab_category").hide();
		var activeTab = $(this).attr("rel"); 
		$("#"+activeTab).fadeIn().addClass("animatetab");  
	});
});

