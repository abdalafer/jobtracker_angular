$('#customerDetailModal').modal('hide');
#$('#customer_detail_section').html("<%= escape_javascript render(:partial => 'customer_detail_modal', :locals => { :customers => @customer }) %>");