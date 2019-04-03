$(document).on('turbolinks:load', function(){
  $('.minus-book-cart').click(function(e){
    var current_book = $(this).parents('.input-group');
    update_quantity_book_cart('minus', current_book);
  });

  $('.plus-book-cart').click(function(e){
    var current_book = $(this).parents('.input-group');
    update_quantity_book_cart('plus', current_book);
  });

  function update_quantity_book_cart(sign, current_book) {
    var count_books = $('.cart-book-quantity').val();
    var book_id = $(current_book).find('.book-cart-id').val();

    if (sign == 'plus') {
      $.ajax({
        type: "PUT",
        url: "/line_items/" + book_id,
        data: { quantity_books: count_books, plus: true }
      });
    }else {
      $.ajax({
        type: "PUT",
        url: "/line_items/" + book_id,
        data: { quantity_books: count_books, minus: true }
      });
    }

  }

})
