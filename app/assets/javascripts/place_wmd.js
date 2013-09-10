$(document).ready(function() {
	
	(function () {
	    var converter1 = Markdown.getSanitizingConverter();

			//fenced block-quote ("""  """) plugin
	    converter1.hooks.chain("preBlockGamut", function (text, rbg) {
	        return text.replace(/^ {0,3}""" *\n((?:.*?\n)+?) {0,3}""" *$/gm, function (whole, inner) {
	            return "<blockquote>" + rbg(inner) + "</blockquote>\n";
	        });
	    });

	    var editor1 = new Markdown.Editor(converter1);

	    editor1.run();
	})();
	
	$('#new_question_button').on("click", function(event) {
		event.preventDefault();
		var converter = Markdown.getSanitizingConverter();

		var user_text = converter.makeHtml($("#wmd-input").val());

		//send only a unique list of tags when tags are redundant
		//TODO: make redundant tags unselectable
		var tag_ids_arr = [];
		for (var i = 0; i <= 4; i++) {
			var tag_id = $("#question-tag-ids-" + i).val();
			var is_unique = true;
			for (var j = 0; j < i && is_unique; j++) {
				if (tag_ids_arr[j] === tag_id) {
					is_unique = false;
				}
			}
			if (tag_id && is_unique) {
				tag_ids_arr.push(tag_id);
			}
		}

		//this is not adequate for production
		//instead, store markup and convert on render,
		//or use ruby to convert and sanitize in the controller
		var data = {
			question: {
				title: $("#question_title").val() || "(no title)",
				body: user_text,
				tag_ids: tag_ids_arr
			}
		}

		$.ajax({
			url: $(event.target).data("action"),
			type: "POST",
			data: data,
			success: function() {
				console.log("AJAX request sent.")
				document.location.reload(true);
			}
		});
	});
	
	$(".question-tag-select").prop("selectedIndex", -1);

	//This unhides subsequent tag selectors when a tag is selected.
	//TODO: Allow 'closing' of tag selectors
	//TODO: Don't display options in later tag selectors
	//      which were already chosen
	$(".question-tag-select").on("change", function() {
		var my_number = this.id.slice(-1);
		my_number = parseInt(my_number) + 1;
		$my_el = $("#question-tag-ids-" + my_number);
		$my_el.removeClass("hidden");
	});
});