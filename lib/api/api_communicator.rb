class ApiCommunicator
  # return a hash of spells
  # TODO: move API key to separate file...
  def get_spells
    response_string = RestClient.get("https://www.potterapi.com/v1/spells?key=$2a$10$eokIo6OAspmz.pVOZVouRekEERvDpUyM1bn2DxGVhKYNsIxasY7xW")
    JSON.parse(response_string)
  end

end
