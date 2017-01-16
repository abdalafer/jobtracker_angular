$('#newCustomerJobModal').modal('hide');
$('#jobs_list_section').html("<%= escape_javascript render(:partial => 'jobs_list', :locals => { :jobs => @jobs }) %>");