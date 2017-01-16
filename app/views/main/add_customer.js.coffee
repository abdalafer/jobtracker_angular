$('#newCustomerModal').modal('hide');
$('#customer_list_section').html("<%= escape_javascript render(:partial => 'customers_list', :locals => { :customers => @customers }) %>");