$('#job_tasks_list_section').html("<%= escape_javascript render(:partial => 'job_task_list', :locals => { :tasks => @tasks }) %>");
$('#started_tab').click();