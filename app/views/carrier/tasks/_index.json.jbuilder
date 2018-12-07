json.tasks_count current_user.tasks.size
json.tasks do
    json.array! @tasks, partial: 'carrier/tasks/task', as: :task
end
json.pagination @pagination