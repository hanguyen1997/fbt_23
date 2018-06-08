$(document).ready(function() {
  $('#price, #quantity').change(function(){
    var grandTotal = Number($('#price').val()) * Number($('#quantity').val());
    grandTotal = '$' + grandTotal.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    $('#total').empty();
    $('#total').append(grandTotal);
  });

  $('#submit-rating').on('change', function () {
    $('.hidden-submit').submit();
  });
});
