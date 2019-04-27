class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    comment_service = CommentService.new(comments_form_params)
    @comment_form = comment_service.comment_form
    flash[:error] = @comment_form.errors.full_messages.to_sentence unless comment_service.save_comment
    redirect_to book_path(params[:current_book])
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end
end
