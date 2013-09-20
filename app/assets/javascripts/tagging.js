$(document).ready(function () {
  //This causes no tag to be selected by default in the tag lists
  $(".question-tag-select").prop("selectedIndex", -1);

  //This unhides subsequent tag selectors when a tag is selected.
  //TODO: Allow 'closing' of tag selectors
  //TODO: Don't display options in later tag selectors
  //      which were already chosen
  $(".question-tag-select").on("change", function() {
  	var my_number = this.id.slice(-1);
  	next_number = parseInt(my_number) + 1;
  	$next_el = $("#question-tag-ids-" + next_number);
    console.log($next_el);
  	$next_el.removeClass("hidden");
  });
});