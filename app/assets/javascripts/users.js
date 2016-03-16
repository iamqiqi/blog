// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

	var followlist = [];
	$('.follow').each(function() {
		var thisid = $(this).attr('id');
		if ($.inArray(thisid, followlist) < 0) {
			followlist.push(thisid);
		} else {
			$(this).remove(); // delete the order record
		}
	});

	var commentlist = [];
	$('.new_comment').each(function() {
		var thisid = $(this).attr('id');
		if ($.inArray(thisid, commentlist) < 0) {
			commentlist.push(thisid);
		} else {
			$(this).remove();
		}
	});
});
