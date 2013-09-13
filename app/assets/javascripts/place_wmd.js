$(document).ready(function() {
  
  if ($(".wmd-input").length === 0) {
    return;
  }
  
	//Runs the primary (i.e., non-comment) WMD on the page
	(function () {
	    var converter = Markdown.getSanitizingConverter();

			//fenced block-quote ("""  """) plugin
	    converter.hooks.chain("preBlockGamut", function (text, rbg) {
	        return text.replace(/^ {0,3}""" *\n((?:.*?\n)+?) {0,3}""" *$/gm, function (whole, inner) {
	            return "<blockquote>" + rbg(inner) + "</blockquote>\n";
	        });
	    });

	    var editor = new Markdown.Editor(converter);

	    editor.run();
	})();
	
	//This block sets up the submit action for the Index page's WMD
	$('#new_question_button').on("click", function(event) {
		event.preventDefault();
    
    if (g_current_user_id === -1) {
      alert("Only logged in users can submit questions.");
      return;
    }
    
		var converter = Markdown.getSanitizingConverter();

		//this is not adequate for production of a real app
		//instead, store markup and convert on render,
		//or use ruby to convert and sanitize in the controller
		var user_text = converter.makeHtml($("#wmd-input").val());

		//send only a unique list of tags when tags are redundant
		//TODO: make redundant tags unselectable on the UI side
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
		
	//This block sets up the submit for a New Answer from the Question Show page
	$('#new_answer_button').on("click", function(event) {
		event.preventDefault();
    
    if (g_current_user_id === -1) {
      alert("Only logged in users can submit answers.");
      return;
    }
    
		var converter = Markdown.getSanitizingConverter();

		//this is not adequate for production of a real app
		//instead, store markup and convert on render,
		//or use ruby to convert and sanitize in the controller
		var user_text = converter.makeHtml($("#wmd-input").val());

		var data = {
			answer: {
				body: user_text
			}
		}

		$.ajax({
			url: $(event.target).data("action"),
			type: "POST",
			data: data,
			success: function() {
				//console.log("AJAX request sent.")
				document.location.reload(true);
			}
		});
	});
	
	//This block sets up the on-demand creation of comment WMDs when clicking
	//comment links
	$('.comment-link').on("click", function (event) {
		event.preventDefault();
    
    if (g_current_user_id === -1) {
      alert("Only logged in users can submit comments.");
      return;
    }
    
		var suffix = "-" + this.id;
		console.log(suffix);
		$cell = $(event.target).closest("td");
		post_url = $(event.target).data("action");
		if ($cell.hasClass("open-comment")) {
			return;
		}
		$cell.addClass("open-comment");
		
		//TODO: replace this in-place string construction with a template
	  var wmd_html_str = '<div class="answer-page-wmd"><br>'
						+ '<div class="wmd-panel submit-button">'
						+ '<button id="new_comment_button">'
						+ 'Submit Comments</button></div><div class="wmd-panel">'
						+ '<div id="wmd-button-bar' + suffix + '"></div>'
						+ '<textarea class="wmd-input wmd-shorty" id="wmd-input' + suffix + '">'
						+ '</textarea></div><div class="wmd-panel" id="preview-label">'
						+ 'Preview: </div><div id="wmd-preview' + suffix + '"'
						+ ' class="wmd-panel wmd-preview">'
						+ '</div></div>';
						
		$cell.append(wmd_html_str);
		
		//The id suffix is what allows the new editor to be linked to particular
		//DOM elements, so that the preview rendering occurs in the right place
		//and doesn't interfere with other WMDs on the same page.
		(function () {
		    var converter = Markdown.getSanitizingConverter();

				//fenced block-quote ("""  """) plugin
		    converter.hooks.chain("preBlockGamut", function (text, rbg) {
		        return text.replace(/^ {0,3}""" *\n((?:.*?\n)+?) {0,3}""" *$/gm, function (whole, inner) {
		            return "<blockquote>" + rbg(inner) + "</blockquote>\n";
		        });
		    });

		    var editor = new Markdown.Editor(converter, suffix);

		    editor.run();
		})();
		
		$('#new_comment_button').on("click", function(event) {
			console.log("!");
			event.preventDefault();
      
      //there is no anonymous user hook here because anonymous users cannot
      //make a comments editor display
      
			var converter = Markdown.getSanitizingConverter();

			//this is not adequate for production of a real app
			//instead, store markup and convert on render,
			//or use ruby to convert and sanitize in the controller
			var user_text = converter.makeHtml($("#wmd-input" + suffix).val());

			var data = {
				comment: {
					body: user_text
				}
			}

			$.ajax({
				url: post_url,
				type: "POST",
				data: data,
				success: function() {
					//console.log("AJAX request sent.")
					document.location.reload(true);
				}
			});
		});
	})
});