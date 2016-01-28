// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$('#edit_bio_link').click(function() {
		$('#bio').hide();
		$('#edit_bio_link').hide();
		$('#edit_bio_form').removeClass('hidden');
	});

	$('.menu-item').click(function() {
		$('.menu-item').removeClass('active');
		$(this).addClass('active');
		//$('.content').load('/_account_settings.js');
	});
});
