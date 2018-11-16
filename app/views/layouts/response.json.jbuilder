json.status @status
json.message @message
json.result @result, partial: @view, as: :category
json.error @error ||= nil