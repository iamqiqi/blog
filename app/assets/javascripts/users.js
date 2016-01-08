// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$('#edit_bio_link').click(function() {
		$('#bio').hide();
		$('#edit_bio_link').hide();
		$('#edit_bio_form').removeClass('hidden');
	});

	// $('#edit_bio_link').click(function() {
	// 	$('#edit_bio_link').hide;
	// });
});
