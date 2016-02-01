// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$(document).on('click', '#edit_bio_link', function() {
		$('#bio').hide();
		$('#edit_bio_link').hide();
		$('#edit_bio_form').removeClass('hidden');
	});
});
