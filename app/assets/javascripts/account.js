$(document).on('turbolinks:load', function(){
  $('.drop-account-checkbox').click(function(e){
    var attribute_checked = $('.drop-account-checkbox')[0].hasAttribute('checked');
    if (attribute_checked) {
      $('.submit-drop-account').attr('disabled', 'true');
      $('.drop-account-checkbox')[0].removeAttribute('checked');
    }else {
      $('.submit-drop-account')[0].removeAttribute('disabled');
      $('.drop-account-checkbox').attr('checked', 'true');
    }
  });
})
