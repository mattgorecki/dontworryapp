jQuery.fn.exists = function(){return this.length>0;}

jQuery(document).ready(function($) {

 // $.backstretch([
    // "dontworry-lowres50%.jpg"
	// ], {duration: 3000, fade: 750});


  if ($('#as').exists()) {
    $('#as').autosize();  
  }

  if ($('#app-wraper').exists()) {
    $('#app-wraper').popover('show');
    console.log('working');
  }
              
  


});


