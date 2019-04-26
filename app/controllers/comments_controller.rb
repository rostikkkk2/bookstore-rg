class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment_form = CommentForm.new(comments_form_params)
    flash[:error] = @comment_form.errors.full_messages.to_sentence unless @comment_form.save
    redirect_to book_path(params[:current_book])
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end
end
