jQuery(document).ready(function($) {  
	if(POS_HOME_SPECIAL_PAGINATION==null || POS_HOME_SPECIAL_PAGINATION =="") {POS_HOME_SPECIAL_PAGINATION = false} else { POS_HOME_SPECIAL_PAGINATION = true}
	if(POS_HOME_SPECIAL_NAV==null || POS_HOME_SPECIAL_NAV =="") {POS_HOME_SPECIAL_NAV = false} else {POS_HOME_SPECIAL_NAV = true}
	var owl = $(".specialSlide");
		owl.owlCarousel({
		items :POS_HOME_SPECIAL_ITEMS,
		slideSpeed: POS_HOME_SPECIAL_SPEED,
		pagination :POS_HOME_SPECIAL_PAGINATION,
		navigation :POS_HOME_SPECIAL_NAV,
		itemsDesktop : [1199,1],
		itemsDesktopSmall : [991,1],
		itemsTablet: [767,1],
		itemsMobile : [479,1]
	});
});