json.profile do
    json.type @user.roles.first.name
    json.email @user.email
    json.amount @user.amount
end