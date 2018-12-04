json.profile do
  json.role producer.type
  json.id producer.id
  json.brand producer.producer_brand ? producer.producer_brand : "Укажите название Вашей компании"
  json.address producer.producer_address
  json.phome producer.producer_phone
  json.inn producer.producer_inn ? producer.producer_inn : "Укажите Ваш ИНН"
  json.descripion producer.producer_description ? producer.producer_description : "Расскажите нам о себе :)"
  json.amount producer.amount
  json.logo url_for(producer.producer_logo)
  json.sertificates do
    json.array! do
    end
  end
  json.link producer_path producer.id
end