// Reset the state of the submit button
$(document).ready(function() {
  
  $('input[type=submit][data-loading-text]').each(function(i, button){
    $(button).button('reset');
  });
  
  $('form').on('submit', function(event){
    $('input[type=submit][data-loading-text]', event.target).button('loading');
  });
  
});