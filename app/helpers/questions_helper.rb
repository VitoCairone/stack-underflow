module QuestionsHelper
 
  def accept_block_class(answer)
    best_id = @question.best_answer_id
    if !(best_id == -1 || best_id.nil?)
      best_id == answer.id ? "accepted-block" : "accept-block-dummy"
    else
      owned(@question) ? "accept-block" : "accept-block-dummy"
    end
  end

end
