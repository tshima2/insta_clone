$(function () {
    $('.isg_feed_show_menu').click(function(e) {

	let HEADER_HEIGHT=0;
	let HEADER_MARGIN=10;
	let TEXTAREA_HEIGHT=144;
	let TEXTAREA_MARGIN=10;
	
        //console.log(e.originalEvent);
        
        let ul=$(this).next('ul');
        let top=e.originalEvent.pageY-(HEADER_HEIGHT-HEADER_MARGIN)-(TEXTAREA_HEIGHT-TEXTAREA_MARGIN);
        let right=96;
        ul.css('top', top);
        ul.css('right', right);        
        ul.slideToggle();        
    });

    
});
