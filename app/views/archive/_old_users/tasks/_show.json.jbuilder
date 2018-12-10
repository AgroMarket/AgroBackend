json.task do
    json.id @task.id
    json.ask @task.ask
    json.user @task.user
    json.status @task.status
end