This is one of my RESTful API scripts that do the following:
1- I define my parameters in run_apis().
2- I run an iterator function to construct my api call parameters (uses an excel sheet to feed the parameters)
3- Save and parse the response body and response code into global variables.
3- Manipulate and sort the data, I normally start by testing any response code that is other than 200 


require "rubygems"
require 'json'
require 'rest_client'
require 'roo'
require 'RubyXL'
require 'restforce'

# Sales Force Api call 
$client = Restforce.new(oauth_token: '00D0Q00000018cL!AR8AQJfAVUcL9vj5Cb4vWGC0lYe56kMvegAswgt27kgeZiM6HTnRtlW7RvqXMhdNe9LQg6zu0NJi69gr8LdCii01SOBFZ3ER',
                           refresh_token: 'ReENoKQ1XEfy6l7jDhJj0uXJvOTO5I0fMCTpLgPfyuQ=',
                           instance_url: 'https:ptpfull.cs109.my.salesforce.com',
                           client_id: '3MVG9llQY5kM9T6ft1Y9n7M2VbQL5_MBbq3IQE0er10s4f8LyJU7RkNGj_LDnliXyjCCc9QSUMhJSI1O0BUh7',
                           client_secret: '88A834367B98398C0CE018627582A3F2CEBE7DE1EFFB0D890F1C34D7BA44B4FF',
                           authentication_callback: Proc.new {|x| Rails.logger.debug x.to_s},
                           api_version: '41.0')

def run_apis()
  begin
    #$uri = "http://api.usmdm-stg.xxx.com/USMDMMS/api/party/get"
    $uri = "https://apim.xxx.com/USMDMMS/api/party/get"
    $request_string = "{\"getPartyDetailRequest\": { \"partyId\": \"\", \"PRID\": \"\",  \"TPRID\": \"\", \"sourcePartyId\": \"\",\"sourcePRID\": \"#{$PRID}\",  \"identifierType\": {  \"identifierTypeCode\": \"\", \"identifierValue\": \"\" } } }"
    $response_string = RestClient.post $uri, $request_string, :content_type => :json, :accept => :json, :'APIKey' => "l7xxe432691b415b4806b90c938e7d66f9c9", :'APIKeySecret' => "7981c79fc887416a8d66d5a029fe2ba5"#{content_type: :json, accept: :json}
    p $responseCode = $response_string.code
    p $responseBody = $response_string.body
   
    #$hash = JSON.parse($response_string)

    workbook = RubyXL::Parser.parse("C:\\Users\\delzein001\\Desktop\\apiAlive2.xlsx")
    worksheet = workbook[0]
    rows = worksheet.map {|row| row && row.cells.each {|cell| cell && cell.value != nil}}
    p last_row = rows.size
    last_column = rows.compact.max_by {|row| row.size}.size
    #worksheet.add_cell(last_row, 0, $partyName)
    #worksheet.add_cell(last_row, 1, $PRID) 
    worksheet.add_cell(last_row, 3, $responseBody) 
    workbook.write("C:\\Users\\delzein001\\Desktop\\apiAlive2.xlsx")
    p 'record created1'
  rescue => e      
    puts "FAILED.SF api status code is not 200. PRID: #{$PRID}"
  end
end


def apiIterator()
  oo = Roo::Excelx.new("C:\\Users\\delzein001\\Desktop\\SF_Apis.xlsx")
  lastRow = oo.last_row
  2.upto(3) do |line|
    $partyName = oo.cell(line, 'A')
    $PRID = oo.cell(line, 'B')
    run_apis()
  end
end

apiIterator
