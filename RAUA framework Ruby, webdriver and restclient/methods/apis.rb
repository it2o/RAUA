require "rubygems" 
require 'json'
require 'rest_client' 
require 'roo'

def run_apis()
    begin
    puts "run_api's"
      $uri = "http://api.usmdm-stg.pwcinternal.com/USMDMMS/api/party/get"
      puts $PRID
      $request_string = "{\"getPartyDetailRequest\": { \"partyId\": \"\", \"PRID\": \"#{$PRID}\",  \"TPRID\": \"\", \"sourcePartyId\": \"\",\"sourcePRID\": \"\",  \"identifierType\": {  \"identifierTypeCode\": \"\", \"identifierValue\": \"\" } } }"
      # this is my request body that I want to pass
      puts $request_string
      puts "here"
      #puts $request_json = JSON.parse($request_string)
      # then I want to call the POST using the restclient. So I pass the URL, then I pass the request body, but it keeps failing - I am not sure why?? let me comment it out
      # and run it again 
      $response_string = RestClient.post $uri, $request_string, {content_type: :json, accept: :json}
      puts $response_string
      puts $hash = JSON.parse($response_string)
      puts restrictionTypeCode = $hash.first['restriction'].first['restrictionTypeCode'] # this code allow me to parse for certain tags - it works 
      
    rescue => e   
      puts"api failed"
     end
end


def apiIterator()
  puts "apiIterator"
  oo = Roo::Excelx.new("C:\\Users\\delzein001\\Desktop\\New Ventures_Independece_Test Data_09-17-2019.xlsx")
  lastRow = oo.last_row 
  2.upto(2) do |line|
    $TPRID        = oo.cell(line,'A')
    $partyName    = oo.cell(line,'B')
    $partyType    = oo.cell(line,'C')
    $IndependenceRestrictionFlag   = oo.cell(line,'D')
    $IndependenceRestrictionTypeStandard    = oo.cell(line,'E')
    $PRID  = oo.cell(line,'F')
    $cesID  = oo.cell(line,'G')
    $duns  = oo.cell(line,'H')
    $address1  = oo.cell(line,'I')
    $address2  = oo.cell(line,'J')
    $city  = oo.cell(line,'K')
    $state  = oo.cell(line,'L')
    $country  = oo.cell(line,'M')
    $postalCode  = oo.cell(line,'N')
   run_apis()
  end
end
apiIterator

