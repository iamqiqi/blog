// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$(document).on('click', '#edit_bio_link', function() {
		$('#bio').hide();
		$('#edit_bio_link').hide();
		$('#edit_bio_form').removeClass('hidden');
	});

	var followlist = [];
	$('.follow').each(function() {
		var thisid = $(this).attr('id');
		if ($.inArray(thisid, followlist) < 0) {
			followlist.push(thisid);
			console.log(followlist);
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
