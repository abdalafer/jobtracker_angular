module MainHelper
  def state_pill(item_state)
    output = []
    output << "<span class='label label-"

    case item_state
      when 'created'
        output << 'default'
      when 'started'
        output << 'success'
      when 'finished'
        output << 'finished'
    end

    output << "'>#{item_state}</span>"

    output.join('').html_safe
  end

  def item_count(item)
    item.count if item.present?
  end

  def delete_job_task_button(job_uuid, task_uuid)
    output = []
    output << '<div class="task_delete_button">'
    output << button_to('X', "/job/#{job_uuid}/task/#{task_uuid}", class: 'btn btn-default delete_item_button', remote: true, method: :delete)
    output << ' </div>'

    output.join('').html_safe
  end
end
