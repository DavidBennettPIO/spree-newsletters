jQuery.fn.product_autocomplete = function(){
  $(this).autocomplete("/admin/products.json?authenticity_token=" + $('meta[name=csrf-token]').attr("content"), {
      parse: prep_autocomplete_data,
      formatItem: function(item) {
        return format_autocomplete(item);
      }
    }).result(function(event, data, formatted) {
      if (data){
        if(data['variant']==undefined){
          // product
          $('#add_variant_id').val(data['product']['master']['id']);
          $('#add_product_id').val(data['product']['id']);
        }else{
          // variant
          $('#add_variant_id').val(data['variant']['id']);
          $('#add_product_id').val(data['id']);
        }
      }
    });
}

$(document).ready(function(){
  
  $("#add_product_name").product_autocomplete();
  
  $('form').bind('ajax:success',function(data, status, xhr){
    preview_newsletter();
    $('#module_list').replaceWith(data);
    init_module_list();
  });
  
  $("#trash").droppable({
    accept: "#module_list > li",
    activeClass: "ui-state-highlight",
    drop: function( event, ui ) {
      if (!confirm('Are you sure you would like to remove this module?')) return false;
      ui.draggable.remove();
      jQuery.post( '/admin/newsletters/remove_module?newsletter_id='+newsletter_id, ui.draggable.attr('id').replace('_', '='),function(data, status, xhr){
        preview_newsletter();
        $('#module_list').replaceWith(data);
        init_module_list();
      });
    }
  });

  init_module_list();
});

function preview_newsletter()
{
  document.getElementById('newsletter-preview').contentDocument.location.reload(true);
}

function init_module_list()
{
  $('#module_list').sortable({
    update: function(){
      jQuery.post( '/admin/newsletters/sort?newsletter_id='+newsletter_id, $('#module_list').sortable('serialize'),function(){
        preview_newsletter();
      });
     }
  });
  
  
}
