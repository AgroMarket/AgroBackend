json.tasks do
    json.array! @tasks do |task|
        json.id task.id
        json.user task.user
        json.ask task.ask
        json.status task.status
    end
end