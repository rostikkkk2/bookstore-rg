class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment_form = CommentForm.new(comments_form_params)
    return redirect_to request.referrer if @comment_form.save

    flash[:error] = @comment_form.errors.full_messages.to_sentence
    redirect_to request.referrer
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end
end
