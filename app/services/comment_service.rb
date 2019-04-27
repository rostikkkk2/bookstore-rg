class CommentService
  attr_reader :comment_form

  def initialize(comments_form_params)
    @comment_form = CommentForm.new(comments_form_params)
  end

  def save_comment
    create_comment if comment_form.valid?
  end

  private

  def create_comment
    comment = Comment.new(comment_form.attributes.without(:current_book, :current_user))
    comment.user_id = comment_form.current_user
    comment.book_id = comment_form.current_book
    comment.save
  end
end
