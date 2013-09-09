window.StackUnderflow = $.extend(window.StackUnderflow || {}, {
	handleVote: function (event, for_top, type_str) {		
		var $target = $(event.target);
		var qblock = $target.closest(".vote-cell");
		var	rblock = qblock.find(".vote-block-ctr")
		var targ_id = parseInt(qblock.data("id"));
		var $vblock = $target.closest(".vote-block");
		var extant_vote_id = $vblock.data("id");
		
		var base_clas_str = null;
		var selected_class_str = null;
		var $opposite = null;
		var ratingChange = null;
		
		if (for_top) {
			base_class_str = "vote-block-top";
			selected_class_str = "my-vote-top";
			opp_class_str = "vote-block-bot"
			opp_class_selected_str = "my-vote-bot"
			ratingChange = 1;
		} else {
			base_class_str = "vote-block-bot";
			selected_class_str = "my-vote-bot";
			opp_class_str = "vote-block-top";
			opp_class_selected_str = "my-vote-top";
			ratingChange = -1;
		}
		
		var $opposite = $vblock.find("." + opp_class_str);
		
		if ($target.hasClass(selected_class_str)) {
			//clicking on an existing vote to revoke it
		
			$.ajax({
			    url: type_str + '/' + targ_id + '/votes/' + extant_vote_id,
			    type: 'DELETE',
			});
			rblock.text(parseInt(rblock.text()) - ratingChange);
			$vblock.data("id", -1);
			$target.removeClass(selected_class_str);
		} else if ($opposite.hasClass(opp_class_selected_str)) {
			//clicking on a vote when the opposite vote is currently set
		
			//first, remove the vote of the opposite type
			$.ajax({
			    url: type_str + '/' + targ_id + '/votes/' + extant_vote_id,
			    type: 'DELETE'
			});
			$opposite.removeClass(opp_class_selected_str);
		
			//then, add the vote of this type
			$target.addClass(selected_class_str);
			$.post(
	 			type_str + "/" + targ_id + "/votes",
	 			{ 
					is_up: for_top
				},
				function (response) {
					$vblock.data("id", response.id);
				}	
	 		);
		
			//finally apply the rating change
			rblock.text(parseInt(rblock.text()) + (ratingChange * 2));
		
		} else {
			//clicing on a vote when the matter is unvoted; create a vote
		
			$target.addClass(selected_class_str);
			rblock.text(parseInt(rblock.text()) + ratingChange);
			$.post(
	 			type_str + '/' + targ_id + "/votes",
	 			{
					is_up: for_top
				},
				function (response) {
					$vblock.data("id", response.id);
				}
	 		);
		}
	} // end handleVote function
}); //end StackUnderflow assign/extend

$(document).ready(function () {
	//var SO = window.StackUnderflow;
	
	$(".index-question-block .vote-block-top").on("click", function (event) {
		window.StackUnderflow.handleVote(event, true, "questions");
	});
	$(".index-question-block .vote-block-bot").on("click", function (event) {
		window.StackUnderflow.handleVote(event, false, "questions");
	})
	
	$(".show-answer-container .vote-block-top").on("click", function (event) {
		window.StackUnderflow.handleVote(event, true, "../answers");
	});
	$(".show-answer-container .vote-block-bot").on("click", function (event) {
		window.StackUnderflow.handleVote(event, false, "../answers");
	})
	
}); //end doc-ready function