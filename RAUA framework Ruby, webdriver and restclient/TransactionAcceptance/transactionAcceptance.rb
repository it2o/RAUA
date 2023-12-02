require "rubygems"
require 'json'
require 'rest_client'
require 'roo'
require 'RubyXL'
require 'restforce'

$client = Restforce.new(oauth_token: '00D0Q00000018cL!AR8AQMuMrrBtl34Sp_5etzj8s_qZZagk4SeWadDguuz8BAjne.E0piMQi4EzOGMHLA9.dRt4Qj718Q1BSifv1VGjgKmLtnOq',
                           refresh_token: 'ReENoKQ1XEfy6l7jDhJj0uXJvOTO5I0fMCTpLgPfyuQ=',
                           instance_url: 'https://pwc-ptp--ptpfull.cs109.my.salesforce.com',
                           client_id: '3MVG9llQY5kM9T6ft1Y9n7M2VbQL5_MBbq3IQE0er10s4f8LyJU7RkNGj_LDnliXyjCCc9QSUMhJSI1O0BUh7',
                           client_secret: '88A834367B98398C0CE018627582A3F2CEBE7DE1EFFB0D890F1C34D7BA44B4FF',
                           authentication_callback: Proc.new {|x| Rails.logger.debug x.to_s},
                           api_version: '41.0')
def run_apis()
  begin
    $uri = "http://api.usmdm-stg.pwcinternal.com/USMDMMS/api/party/get"
    $request_string = "{\"getPartyDetailRequest\": { \"partyId\": \"\", \"PRID\": \"#{$PRID}\",  \"TPRID\": \"\", \"sourcePartyId\": \"\",\"sourcePRID\": \"\",  \"identifierType\": {  \"identifierTypeCode\": \"\", \"identifierValue\": \"\" } } }"
    #puts $request_string
    $response_string = RestClient.post $uri, $request_string, {content_type: :json, accept: :json}
    $response_string
    $hash = JSON.parse($response_string)
    response = $client.get('https://pwc-ptp--ptpfull.cs109.my.salesforce.com/services/apexrest/TransactionAcceptance/v1/' + $PRID)
    result = response.body
    $TransactionAcceptanceResult1 = ''
    $IndependenceResult1 = ''
    $LegalAndRegulatoryResult1 = ''
    $USMDMIndependenceStatus1 = ''
    $USMDMIndependenceRestrictions1 = ''
    $USMDMLegalAndRegulatoryRestrictionStatus1 = ''
    $USMDMLegalAndRegulatoryRestriction1 = ''

    #if result.StatusCode == '200'
      puts "SF api status code 200"
      usmdmResponseNode = result['USMDMResponse']
      $TransactionAcceptanceResult1 = result.TransactionAcceptanceResult
      $IndependenceResult1 = result.IndependenceResult
      $LegalAndRegulatoryResult1 = result.LegalAndRegulatoryResult 
      # $USMDMIndependenceStatus1 = usmdmResponseNode.independenceRestrictionStatus
      # p $USMDMIndependenceStatus1
      # $USMDMLegalAndRegulatoryRestrictionStatus1 = usmdmResponseNode.statusMessage
      # p $USMDMLegalAndRegulatoryRestrictionStatus1
   # end
    if $TransactionAcceptanceResult1.nil?
      $TransactionAcceptanceResult1 = "TransactionAcceptanceResult1 Status Code from SF = nil" 
    end
    if $IndependenceResult1.nil?
      $IndependenceResult1 = "IndependenceResult1 Status from SF = nil"
    end
    if $LegalAndRegulatoryResult1.nil?
      $LegalAndRegulatoryResult1 = "LegalAndRegulatoryResult1 Status From SF: nil"
    end
    if $USMDMIndependenceStatus1.nil?
      $USMDMIndependenceStatus1 = "USMDMIndependenceStatus1 Status From SF: nil"
    end
    if $USMDMIndependenceRestrictions1.nil?
      $USMDMIndependenceRestrictions1 = "USMDMIndependenceRestrictions1 status Message From SF: nil"
    end
    if $USMDMLegalAndRegulatoryStatus1.nil?
      $USMDMLegalAndRegulatoryStatus1 = "USMDMLegalAndRegulatoryStatus1 status Message From SF: nil"
    end
    if $USMDMLegalAndRegulatoryRestrictions1.nil?
      $USMDMLegalAndRegulatoryRestrictions1 = "USMDMLegalAndRegulatoryRestrictions1 status Message From SF: nil"
    end

    ############################################################  Nodes:    Response > Result > (serviceStatus, responseGetParty, )
    getPartyDetailResponseNode = $hash['getPartyDetailResponse']
    getPartyDetailResultNode = getPartyDetailResponseNode["getPartyDetailResult"]
    responseGetPartyNode = getPartyDetailResultNode["responseGetParty"]
    partyNode = responseGetPartyNode["party"]
    serviceStatusNode = getPartyDetailResultNode["serviceStatus"]
    overallStatusNode = serviceStatusNode["overallStatus"]
    overallStatusNodeString = overallStatusNode.to_json
    if overallStatusNodeString.include?("Success")
      partyName = partyNode["partyName"].to_json
      prid = partyNode['PRID']
      if nil != partyNode["independenceRestrictionStatus"]
        indstatus = partyNode["independenceRestrictionStatus"]["desc"].to_json  ##### Independence Restriction Status   (scope of service, Financial restriction, unrestricted, undetermined)
        if indstatus.include?("Unrestricted")
          status_independenceRestrictionStatus = "Unrestricted"
        end
        if indstatus.include?("Undetermined")
          status_independenceRestrictionStatus = "Undetermined"
        end
        if (indstatus.include?("Restricted"))
          status_independenceRestrictionStatus = "Restricted"
        end
      else
        status_independenceRestrictionStatus = "Nil "
      end

      if (nil != partyNode["indpRestrictions"])
        indpRestrictionsNode = partyNode["indpRestrictions"]
        indpRestrictionNode = indpRestrictionsNode["indpRestriction"]
        indpRestrictionNodeDes = Array[]
        begin
          if (indpRestrictionNode.kind_of?(Array))
            indpRestrictionNode.each do |item|
              indpRestrictionTypeNode = item["indpRestrictionType"]
              descNode = indpRestrictionTypeNode["desc"]
              indpRestrictionNodeDes.push(descNode.to_json)
            end
          else
            indpRestrictionNodeDes.push(indpRestrictionNode["indpRestrictionType"]["desc"].to_json)
          end
        rescue => e
          indpRestrictionNodeDes.push("")
        end

        financialInterest = indpRestrictionNodeDes.include?("\"Financial Interests\"")  
        scopeofservice = indpRestrictionNodeDes.include? ("\"Scope of Service\"")         ################## How come it's different from the above string

        if (financialInterest)
          status_financialInterest = "Restricted"
        else
          status_financialInterest = "Unrestricted"
        end
        if (scopeofservice)
          status_scopeofservice = "Restricted"
        else
          status_scopeofservice = "Unrestricted"
        end

      else
        status_financialInterest = "Unrestricted"
        status_scopeofservice = "Unrestricted"
      end
      legalAndRegulatoryRestrictionStatusNode = partyNode["legalAndRegulatoryRestrictionStatus"] ##### RPS/Legal and Regulatory Restrictions Status (Restricted-Sanctions, Restricted-NoSanctions, unrestricted)
      begin
        if (nil != partyNode["legalAndRegulatoryRestrictionStatus"])
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("No"))
            status_legalAndRegulatoryRestrictionStatus = "None"
          end
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("Restricted"))
            status_legalAndRegulatoryRestrictionStatus = "Restricted";
          end
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("Unrestricted"))
            status_legalAndRegulatoryRestrictionStatus = "Unrestricted";
          end
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("Undetermined"))
            status_legalAndRegulatoryRestrictionStatus = "Undetermined"
          end
        else
          status_legalAndRegulatoryRestrictionStatus = "Unrestricted"
        end
      rescue => e
        status_legalAndRegulatoryRestrictionStatus = "Unrestricted"
      end
      if (nil != partyNode["legalAndRegulatoryRestrictions"])
        ldes = partyNode["legalAndRegulatoryRestrictions"]["legalAndRegulatoryRestriction"].to_json
        legalAndRegulatoryRestrictionsNode = partyNode["legalAndRegulatoryRestrictions"]
        $LegalRegRestrictionNode = legalAndRegulatoryRestrictionsNode["legalAndRegulatoryRestriction"]
        $LegalRegRestrictionDes = Array[]
        begin
          if ($LegalRegRestrictionNode.kind_of?(Array))
            $LegalRegRestrictionNodeArrayNode = $LegalRegRestrictionNode
            $LegalRegRestrictionNodeArrayNode.each do |item|
              $LegalRegRestrictionTypeNode = item["legalAndRegulatoryRestrictionType"]
              $descNode = $LegalRegRestrictionTypeNode["desc"]
              $LegalRegRestrictionDes.push($descNode.to_json)
            end
          end
        rescue => e
          $LegalRegRestrictionDes.push("")    ################################################################################ Update Expected Results here ########################################
        end

        $Sanction = ldes.include?("Sanction")

        if ($Sanction)
          status_Sanction = "Restricted"
        else
          if (ldes.length() >= 1)
            status_Other = "Restricted"
          end
        end

      else
        status_Sanction = "Unrestricted"
        status_Other = "Unrestricted"
      end
    else
      partyName = ""
      prid = $PRID
      status_independenceRestrictionStatus = "Unrestricted"
      status_financialInterest = "Unrestricted"
      status_scopeofservice = "Unrestricted"
      status_legalAndRegulatoryRestrictionStatus = "Unrestricted"
      status_Sanction = "Unrestricted"
      status_Other = "Unrestricted"
      result = "Fail"
    end


    if status_scopeofservice.nil?
      status_scopeofservice = 'null'
    end
    if status_Sanction.nil?
      status_Sanction = 'null'
    end
    if overallStatusNodeString.nil?
      overallStatusNodeString = 'null'
    end
    if status_independenceRestrictionStatus.nil?
      status_independenceRestrictionStatus = 'null'
    end

    if (status_scopeofservice.upcase.eql?("YES"))
      result = "Fail"
    elsif (status_Sanction.upcase.eql?("YES"))
      result = "Fail"
      if (!overallStatusNodeString.to_json.include?("Success"))
        result = "Fail"
      end
    elsif (status_independenceRestrictionStatus.upcase.eql?("UND"))
      result = "SECONDARY INSPECTION"
    elsif (nil != status_legalAndRegulatoryRestrictionStatus and status_legalAndRegulatoryRestrictionStatus.upcase.eql?("UND"))
      result = "SECONDARY INSPECTION"
    else
      result = "Pass"
    end
    if status_legalAndRegulatoryRestrictionStatus.nil?
      status_legalAndRegulatoryRestrictionStatus = 'null'
    end
    data = [partyName, prid, status_independenceRestrictionStatus, status_scopeofservice, status_financialInterest, status_legalAndRegulatoryRestrictionStatus, status_Sanction, status_Other, result]

    p data
    p partyName
    p prid
    p status_independenceRestrictionStatus
    p status_scopeofservice
    p status_financialInterest
    p status_legalAndRegulatoryRestrictionStatus
    p status_Sanction
    p status_Other
    p $TransactionAcceptanceResult1
    p $IndependenceResult1
    p $LegalAndRegulatoryResult1

    workbook = RubyXL::Parser.parse("C:\\Users\\delzein001\\Desktop\\ruby.xlsx")
    worksheet = workbook[0]
    rows = worksheet.map {|row| row && row.cells.each {|cell| cell && cell.value != nil}}
    p last_row = rows.size
    last_column = rows.compact.max_by {|row| row.size}.size
    worksheet.add_cell(last_row, 0, partyName)
    worksheet.add_cell(last_row, 1, prid) #PRID
    worksheet.add_cell(last_row, 2, status_independenceRestrictionStatus) #Independence Restriction Status code
    worksheet.add_cell(last_row, 3, status_scopeofservice) #Independence Restriction: Desc - Scope of Service
    worksheet.add_cell(last_row, 4, status_financialInterest) #Independence Restriction: Financial Interest
    worksheet.add_cell(last_row, 5, status_legalAndRegulatoryRestrictionStatus) #Legal & Regulatory Restriction Status
    worksheet.add_cell(last_row, 6, status_Sanction) #Legal & Regulatory Restriction: Sanctions
    worksheet.add_cell(last_row, 7, status_Other) #Legal & Regulatory Restriction: <other>
    worksheet.add_cell(last_row, 8, $TransactionAcceptanceResult1) 
    worksheet.add_cell(last_row, 9, $IndependenceResult1) 
    worksheet.add_cell(last_row, 10, $LegalAndRegulatoryResult1) 
    worksheet.add_cell(last_row, 11, status_independenceRestrictionStatus) 
    worksheet.add_cell(last_row, 12, status_scopeofservice) 
    worksheet.add_cell(last_row, 13, status_legalAndRegulatoryRestrictionStatus) 
    worksheet.add_cell(last_row, 14, status_Sanction) 
    workbook.write("C:\\Users\\delzein001\\Desktop\\ruby.xlsx")
    p 'record created1'
  rescue => e      #/////////////////////////////////////////////////////////////////////////////////////////////////////////#####
    puts "FAILED.SF api status code is not 200. PRID: #{$PRID}"
    #File.write("C:\\Users\\delzein001\\Desktop\\failed.xlsx", $PRID)

    getPartyDetailResponseNode = $hash['getPartyDetailResponse']
    getPartyDetailResultNode = getPartyDetailResponseNode["getPartyDetailResult"]
    responseGetPartyNode = getPartyDetailResultNode["responseGetParty"]
    partyNode = responseGetPartyNode["party"]
    serviceStatusNode = getPartyDetailResultNode["serviceStatus"]
    overallStatusNode = serviceStatusNode["overallStatus"]
    overallStatusNodeString = overallStatusNode.to_json###########################??????? How come its not the top one
    if overallStatusNodeString.include?("Success")
      partyName = partyNode["partyName"].to_json
      prid = partyNode['PRID']
      if nil != partyNode["independenceRestrictionStatus"]
        indstatus = partyNode["independenceRestrictionStatus"]["desc"].to_json  ##### Independence Restriction Status   (scope of service, Financial restriction, unrestricted, undetermined)
        if indstatus.include?("Unrestricted")
          status_independenceRestrictionStatus = "indStatus: Unrestricted"
        end
        if indstatus.include?("Undetermined")
          status_independenceRestrictionStatus = "indStatus: Undetermined"
        end
        if (indstatus.include?("Restricted"))
          status_independenceRestrictionStatus = "indStatus: Restricted"
        end
      else
        status_independenceRestrictionStatus = "indStatus: Nil "
      end

      if (nil != partyNode["indpRestrictions"])
        indpRestrictionsNode = partyNode["indpRestrictions"]
        indpRestrictionNode = indpRestrictionsNode["indpRestriction"]
        indpRestrictionNodeDes = Array[]
        begin
          if (indpRestrictionNode.kind_of?(Array))
            indpRestrictionNode.each do |item|
              indpRestrictionTypeNode = item["indpRestrictionType"]
              descNode = indpRestrictionTypeNode["desc"]
              indpRestrictionNodeDes.push(descNode.to_json)
            end
          else
            indpRestrictionNodeDes.push(indpRestrictionNode["indpRestrictionType"]["desc"].to_json)
          end
        rescue => e
          indpRestrictionNodeDes.push("")
        end

        financialInterest = indpRestrictionNodeDes.include?("\"Financial Interests\"")  
        scopeofservice = indpRestrictionNodeDes.include? ("\"Scope of Service\"")         ################## How come it's different from the above string

        if (financialInterest)
          status_financialInterest = "finIntStatus: Yes"
        else
          status_financialInterest = "finIntStatus: No"
        end
        if (scopeofservice)
          status_scopeofservice = "scopeOfServiceStatus: Yes"
        else
          status_scopeofservice = "scopeOfServiceStatus: No"
        end

      else
        status_financialInterest = "finIntStatus: No"
        status_scopeofservice = "scopeOfServiceStatus: No"
      end
      legalAndRegulatoryRestrictionStatusNode = partyNode["legalAndRegulatoryRestrictionStatus"] ##### RPS/Legal and Regulatory Restrictions Status (Restricted-Sanctions, Restricted-NoSanctions, unrestricted)
      begin
        if (nil != partyNode["legalAndRegulatoryRestrictionStatus"])
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("No"))
            status_legalAndRegulatoryRestrictionStatus = "RPS/Legal and Regulatory Restrictions Status: No"
          end
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("Restricted"))
            status_legalAndRegulatoryRestrictionStatus = "RPS/Legal and Regulatory Restrictions Status: Restricted";
          end
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("Unrestricted"))
            status_legalAndRegulatoryRestrictionStatus = "RPS/Legal and Regulatory Restrictions Status: Unrestricted";
          end
          if (legalAndRegulatoryRestrictionStatusNode["desc"].to_json.include?("Undetermined"))
            status_legalAndRegulatoryRestrictionStatus = "RPS/Legal and Regulatory Restrictions Status: Undetermined"
          end
        else
          status_legalAndRegulatoryRestrictionStatus = "RPS/Legal and Regulatory Restrictions Status: Unrestricted"
        end
      rescue => e
        status_legalAndRegulatoryRestrictionStatus = "RPS/Legal and Regulatory Restrictions Status: Unrestricted"
      end
      if (nil != partyNode["legalAndRegulatoryRestrictions"])
        ldes = partyNode["legalAndRegulatoryRestrictions"]["legalAndRegulatoryRestriction"].to_json
        legalAndRegulatoryRestrictionsNode = partyNode["legalAndRegulatoryRestrictions"]
        $LegalRegRestrictionNode = legalAndRegulatoryRestrictionsNode["legalAndRegulatoryRestriction"]
        $LegalRegRestrictionDes = Array[]
        begin
          if ($LegalRegRestrictionNode.kind_of?(Array))
            $LegalRegRestrictionNodeArrayNode = $LegalRegRestrictionNode
            $LegalRegRestrictionNodeArrayNode.each do |item|
              $LegalRegRestrictionTypeNode = item["legalAndRegulatoryRestrictionType"]
              $descNode = $LegalRegRestrictionTypeNode["desc"]
              $LegalRegRestrictionDes.push($descNode.to_json)
            end
          end
        rescue => e
          $LegalRegRestrictionDes.push("")    ################################################################################ Update Expected Results here ########################################
        end

        $Sanction = ldes.include?("Sanction")

        if ($Sanction)
          status_Sanction = "Yes"
        else
          if (ldes.length() >= 1)
            status_Other = "Yes"
          end
        end

      else
        status_Sanction = "No"
        status_Other = "No"
      end
    else
      partyName = ""
      prid = $PRID
      status_independenceRestrictionStatus = "No"
      status_financialInterest = "No"
      status_scopeofservice = "No"
      status_legalAndRegulatoryRestrictionStatus = "No"
      status_Sanction = "No"
      status_Other = "No"
      result = "Fail"
    end


    if status_scopeofservice.nil?
      status_scopeofservice = ''
    end
    if status_Sanction.nil?
      status_Sanction = ''
    end
    if overallStatusNodeString.nil?
      overallStatusNodeString = ''
    end
    if status_independenceRestrictionStatus.nil?
      status_independenceRestrictionStatus = ''
    end

    if (status_scopeofservice.upcase.eql?("YES"))
      result = "Fail"
    elsif (status_Sanction.upcase.eql?("YES"))
      result = "Fail"
      if (!overallStatusNodeString.to_json.include?("Success"))
        result = "Fail"
      end
    elsif (status_independenceRestrictionStatus.upcase.eql?("UND"))
      result = "SECONDARY INSPECTION"
    elsif (nil != status_legalAndRegulatoryRestrictionStatus and status_legalAndRegulatoryRestrictionStatus.upcase.eql?("UND"))
      result = "SECONDARY INSPECTION"
    else
      result = "Pass"
    end
    if status_legalAndRegulatoryRestrictionStatus.nil?
      status_legalAndRegulatoryRestrictionStatus = ''
    end
    data = [partyName, prid, status_independenceRestrictionStatus, status_scopeofservice, status_financialInterest, status_legalAndRegulatoryRestrictionStatus, status_Sanction, status_Other, result]

    p data

    workbook = RubyXL::Parser.parse("C:\\Users\\delzein001\\Desktop\\ruby.xlsx")
    worksheet = workbook[0]
    p rows = worksheet.map {|row| row && row.cells.each {|cell| cell && cell.value != nil}}
    p last_row = rows.size
    last_column = rows.compact.max_by {|row| row.size}.size
    worksheet.add_cell(last_row, 0, partyName)
    worksheet.add_cell(last_row, 1, prid) #PRID
    worksheet.add_cell(last_row, 2, status_independenceRestrictionStatus) #Independence Restriction Status code
    worksheet.add_cell(last_row, 3, status_scopeofservice) #Independence Restriction: Desc - Scope of Service
    worksheet.add_cell(last_row, 4, status_financialInterest) #Independence Restriction: Financial Interest
    worksheet.add_cell(last_row, 5, status_legalAndRegulatoryRestrictionStatus) #Legal & Regulatory Restriction Status
    worksheet.add_cell(last_row, 6, status_Sanction) #Legal & Regulatory Restriction: Sanctions
    worksheet.add_cell(last_row, 7, status_Other) #Legal & Regulatory Restriction: <other>
    worksheet.add_cell(last_row, 8, 'api response code is 500') 
    worksheet.add_cell(last_row, 9, 'api response code is 500') 
    worksheet.add_cell(last_row, 10,'api response code is 500') 
    worksheet.add_cell(last_row, 11,'api response code is 500') 
    worksheet.add_cell(last_row, 12,'api response code is 500') 
    worksheet.add_cell(last_row, 13,'api response code is 500') 
    worksheet.add_cell(last_row, 14,'api response code is 500') 
    workbook.write("C:\\Users\\delzein001\\Desktop\\ruby.xlsx")
    p 'record created2'


  end
end


def apiIterator()
  #oo = Roo::Excelx.new("C:\\Users\\delzein001\\Desktop\\New Ventures_All_Test Data_09-17-2019.xlsx")
  oo = Roo::Excelx.new("C:\\Users\\delzein001\\Desktop\\New Ventures_Independece_Test Data_09-17-2019.xlsx")
  lastRow = oo.last_row
  2.upto(2) do |line|
    $TPRID = oo.cell(line, 'A')
    $partyName = oo.cell(line, 'B')
    $partyType = oo.cell(line, 'C')
    $IndependenceRestrictionFlag = oo.cell(line, 'D')
    $IndependenceRestrictionTypeStandard = oo.cell(line, 'E')
    $PRID = oo.cell(line, 'F')
    $cesID = oo.cell(line, 'G')
    $duns = oo.cell(line, 'H')
    $address1 = oo.cell(line, 'I')
    $address2 = oo.cell(line, 'J')
    $city = oo.cell(line, 'K')
    $state = oo.cell(line, 'L')
    $country = oo.cell(line, 'M')
    $postalCode = oo.cell(line, 'N')
    run_apis()
  end
end

apiIterator
