// Reset the state of the submit button
$(document).ready(function() {
  
  $('input[type=submit][data-onsubmit-value]').each(function(i, button){
    $(button).val($(button).data('offsubmit-value')).removeClass('disabled');
  });
  
  $('form').on('submit', function(event){
    var button = $('input[type=submit][data-onsubmit-value]', event.target);
    button.val(button.data('onsubmit-value')).addClass('disabled');
  });
  
});