json.array!(@products) do |product|
  json.extract! product, :f_name, :l_name, :company, :address1, :address2, :city, :state, :country, :zip, :phone
  json.url product_url(product, format: :json)
end
