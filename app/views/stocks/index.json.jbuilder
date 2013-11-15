json.array!(@stocks) do |stock|
  json.extract! stock, :stock_id, :name, :title, :author, :code, :resource, :date
  json.url stock_url(stock, format: :json)
end
