// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function initCategories() {
	jQuery('.city h3').toggle(
		function() {
			jQuery(this).next("ul").show('fast');
			jQuery(this).addClass('on');
			return false;
		},
		function() {
			jQuery(this).next("ul").hide('fast');
			jQuery(this).removeClass('on');
			return false;
		}
	);
	jQuery('.city h3').hover(
		function() {
			jQuery(this).parent().addClass("js-hover");
			return false;
		},
		function(argument) {
			jQuery(this).parent().removeClass("js-hover");
			return false;
		}
	);
}

function initAutocompleteSearch(){
  jQuery.ajaxSetup({'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  })
  jQuery("#q").autocomplete('/searches.js',{highlight:false,  mustMatch : false});
  jQuery("#q").autocomplete('/searches',  function(event, data, formatted){ if (data) document.location.href = '/searches/' + data[1]; },{highlight:false});
}

jQuery(document).ready(
       function() {
         jQuery("body").addClass("jsenabled");
         initCategories();
				 initAutocompleteSearch();
			}
)

