class CommentsController < ApplicationController

  def create
    @comment_form = CommentForm.new(comments_form_params)
    if @comment_form.save
      redirect_to book_path(params[:current_book])
    else
      # @errors_comments = @comment_form.errors.messages
      # render comment_errors: @comment_form.errors.messages
    end
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end

end
