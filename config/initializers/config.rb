file = 'config/currency_api_service.yml'
if File.exists? file
  CURRENCY_API_SERVICE = YAML.load_file file
end