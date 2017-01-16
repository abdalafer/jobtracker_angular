$('#job_task_details').html("<%= escape_javascript render(:partial => 'task_detail_modal', :locals => { :tasks => @job_task }) %>");
$('#jobTaskDetailsModal').modal('show')