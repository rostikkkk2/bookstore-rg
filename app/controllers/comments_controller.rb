class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    comment_service = CommentService.new(comments_form_params)
    @comment_form = comment_service.comment_form
    if comment_service.save_comment
      flash[:success] = t('book_page.comment.success_add_comment')
    else
      flash[:error] = @comment_form.errors.full_messages.to_sentence
    end
    redirect_to book_path(params[:current_book])
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end
end
