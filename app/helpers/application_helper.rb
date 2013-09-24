module ApplicationHelper

  def authenticate_and_login
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.password == params[:user][:password]
      login(@user)
      redirect_to home_url
    else
      redirect_to new_session_url
    end
  end

  def current_user
    if session[:session_token].nil?
      @current_user ||= User.find_by_username("guest");
    else
      @current_user ||= User.find_by_session_token(session[:session_token])
    end
  end

  def destroy_this(klass)
    @object = klass.find(params[:id])
    if @object
      #TODO: fail non-owned destroy more loudly
      @object.destroy if owned(@object)
      if klass == Question # may render the 'back' view nonexistant
        redirect_to home_url
      else
        redirect_to :back
      end
    else
      render_errors_of @object
    end
  end

  def enforce_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def home_url
    questions_url
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    token = SecureRandom.urlsafe_base64(16)
    user.session_token = token
    user.save
    session[:session_token] = token
  end

  def logout_current_user
    user = current_user
    if user
      user.session_token = SecureRandom.urlsafe_base64(14)
      user.save
    end
    session[:session_token] = "LOGGED_OUT"
  end

  def on_answer?
    @on_answer = params.has_key?(:answer_id)
  end

  def owned(object)
    current_user && current_user.id == object.user_id
  end
  
  def render_errors_of(object)
    render :json => object.errors.full_messages, status: 422
  end
  
  def render_markdown(markdown_from_db)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    unsanitized = @markdown.render(markdown_from_db)
    Sanitize.clean(unsanitized, Sanitize::Config::RELAXED)
  end
  
  # the purpose of this function is to display about the first two lines of
  # a question, compressed without linebreaks, while preserving formatting
  # such as bold, italic, and pre tags.
  def render_markdown_short(markdown_from_db)
    # first, render markdown
    markdown_long = render_markdown(markdown_from_db)
    # second, cut off, and close any tags which are thus left unclosed
    was_cutoff = markdown_long.length > 200
    markdown_long = Nokogiri::HTML::fragment(markdown_long.first(200)).to_xml
    #third, strip <p></p> <pre></pre> tags to eliminate linebreaks
    #redcarpet wraps in <pre><code> so code is still properly demarcated
    markdown_long.gsub!(/<(\/|)pre>/,"")
    markdown_long.gsub!(/<(\/|)p>/,"")
    
     markdown_long += " ..." if was_cutoff
     markdown_long
  end

  def set_context
    if on_answer?
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
    else
      @question = Question.find(params[:question_id])
    end
  end
  
  def user_vote_on(obj)
    return nil unless logged_in?
    votes = obj.votes
    idx = votes.index { |vote| vote.user_id == current_user.id }
    idx ? votes[idx] : nil
  end 

end
