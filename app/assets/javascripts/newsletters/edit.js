jQuery.fn.product_autocomplete = function(){
  $(this).autocomplete("/admin/products.json?authenticity_token=" + $('meta[name=csrf-token]').attr("content"), {
      parse: prep_product_autocomplete_data,
      formatItem: function(item) {
        return format_product_autocomplete(item);
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

var uploadify_script_data = {};

function get_uploadify_script_data(){
	var ad = uploadify_script_data;
	ad['[image][name]'] = $("#image_name").val();
	ad['[image][href]'] = $("#image_href").val();
	return ad;
};

$(document).ready(function(){

  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var csrf_token = $('meta[name=csrf-token]').attr('content');
  uploadify_script_data[csrf_token] = encodeURI(encodeURI(csrf_param));
  uploadify_script_data[csrf_param] = encodeURI(encodeURIComponent(csrf_token));
  uploadify_script_data[app_key] = encodeURIComponent(app_cookie);
  
  $("#add_product_value").product_autocomplete();
  
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

  $('#select_image').uploadify({
    'uploader'  : '/assets/uploadify/uploadify.swf',
    'script'    : '/admin/newsletters/'+newsletter_id+'/add_image',
    'cancelImg' : '/assets/uploadify/cancel.png',
    'multi'     : true,
    'onError'   : function (event,ID,fileObj,errorObj) {
      alert(errorObj.type + ' Error: ' + errorObj.info);
    },
    'onComplete': function (event, ID, fileObj, response, data) {
      preview_newsletter();
      $('#module_list').replaceWith(response);
      init_module_list();
    }
  });
  $("#add_image").click(function(e){
	uploadify_script_data['[image][name]'] = $("#image_name").val();
	uploadify_script_data['[image][href]'] = $("#image_href").val();
    $('#select_image').uploadifySettings('scriptData', uploadify_script_data);
    $('#select_image').uploadifyUpload();
    e.preventDefault();
  });
  
  $("#add_copy").click(function(e){
    
    $.ajax({
      url: '/admin/newsletters/'+newsletter_id+'/new_copy',
      success: function(data, textStatus, jqXHR){
        openFormDiologe(data);
      },
      dataType: "text",
      beforeSend: function(xhr, settings)
      {
        xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
      }
    });
    
    e.preventDefault();
    
  });
  
  $("#add_ruler").click(function(e){
    add_module('hr');
    e.preventDefault();
  });
  
  $("#add_header").click(function(e){
    add_module('h2', $("#add_header_value").val());
    e.preventDefault();
  });
  
  $("#add_product").click(function(e){
    add_module('product', $("#add_product_value").val(), $("#add_product_id").val());
    e.preventDefault();
  });

  init_module_list();
  
  $('#remote-diologe').dialog({
      autoOpen: false,
      width: 800,
      modal: true
  });
  
});

function add_module(name, value, id)
{
  posts = 'module[newsletter_id]='+newsletter_id+'&module[module_name]='+name;
  if(value != undefined)
    posts = posts+'&module[module_value]='+encodeURI(value);
  if(id != undefined)
    posts = posts+'&module[module_id]='+id;
    
  jQuery.post( '/admin/newsletters/add_module?newsletter_id='+newsletter_id, posts,function(data, status, xhr){
    preview_newsletter();
    $('#module_list').replaceWith(data);
    init_module_list();
  });
}

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
  
  $("#module_list .module_copy").dblclick(function(event){
  	var copy_id = $(this).data('module-id');
  	$.ajax({
      url: '/admin/newsletters/'+newsletter_id+'/edit_copy/'+copy_id,
      success: function(data, textStatus, jqXHR){
        openFormDiologe(data);
      },
      dataType: "text",
      beforeSend: function(xhr, settings)
      {
        xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
      }
    });
  });
}

function openFormDiologe(data){
  
  $('#remote-diologe').html(data);
  $('#remote-diologe').dialog("option", "title", $('#remote-diologe h1').html());
  $('#remote-diologe h1').remove();
  
  $('#remote-diologe form[data-remote="true"]').bind('ajax:complete', function(evt, xhr, status){
    $('#remote-diologe').dialog("close");
    preview_newsletter();
    $('#module_list').replaceWith(xhr.responseText);
    init_module_list();
  });
  
  $('#remote-diologe').dialog("open");
}
