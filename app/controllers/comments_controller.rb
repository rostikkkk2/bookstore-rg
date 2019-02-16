class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment_form = CommentForm.new(comments_form_params)
    if @comment_form.save
      redirect_to request.referrer
    else
      # @current_book = Book.all.find_by(id: params[:current_book].to_i)
      # @presenter = CurrentBookPresenter.new(current_book: @current_book).attach_controller(self)
      # @comment_presenter = CommentPresenter.new(current_book: @current_book).attach_controller(self)
      # @comment_errors = @comment_form.errors.messages
      # render template: '/books/show'
      flash[:error] = @comment_form.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  private

  def comments_form_params
    params.permit(:title, :text_comment, :rating, :current_user, :current_book)
  end

end
