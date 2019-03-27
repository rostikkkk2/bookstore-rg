$(document).on('turbolinks:load', function(){

  $('#hide_shipping_form').click(function(e){
    if (e.target.checked) {
      localStorage.checked = true;
      $('.shipping-form').css('display', 'none');
    }else {
      localStorage.checked = false;
      $('.shipping-form').slideDown(500);
    }
  });

  // if ($('#hide_shipping_form').checked == null) {
  //   console.log($('#hide_shipping_form').checked);
  //   // $('#hide_shipping_form').attr('checked', 'true');
  //   document.querySelector('#hide_shipping_form').checked = true;
  //   console.log($('#hide_shipping_form').checked);
  //
  // }
  // if (localStorage.checked == null) {
  //   console.log(2);
  //   localStorage.checked == 'false';
  // }

  document.querySelector('#hide_shipping_form').checked = set_storage_checked();

  function set_storage_checked() {
    if (!localStorage.checked || localStorage.checked == 'false') {
      $('.shipping-form').css('display', 'block');
      $('#hide_shipping_form').attr('checked', 'false');
      return false;
    }else {
      $('.shipping-form').css('display', 'none');
      $('#hide_shipping_form').attr('checked', 'true');
      return true;
    }
  }

});
