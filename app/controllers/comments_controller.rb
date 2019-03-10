class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment_form = CommentForm.new(comments_form_params)
    show_errors_comment(@comment_form) unless @comment_form.save
    redirect_to request.referrer
  end

  def show_errors_comment(form)
    flash[:error] = form.errors.full_messages.to_sentence
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end
end
