require "rubygems"
require 'json'
require 'rest_client'
require 'roo'
require 'RubyXL'
require 'restforce'

$client = Restforce.new(oauth_token: '00D0Q00000018cL!AR8AQJfAVUcL9vj5Cb4vWGC0lYe56kMvegAswgt27kgeZiM6HTnRtlW7RvqXMhdNe9LQg6zu0NJi69gr8LdCii01SOBFZ3ER',
                           refresh_token: 'ReENoKQ1XEfy6l7jDhJj0uXJvOTO5I0fMCTpLgPfyuQ=',
                           #instance_url: 'https://pwc-ptp--ptpfull.cs109.my.salesforce.com',
                           instance_url: 'pwccrm.ptp.pwc.myshn.net',
                           client_id: '3MVG9llQY5kM9T6ft1Y9n7M2VbQL5_MBbq3IQE0er10s4f8LyJU7RkNGj_LDnliXyjCCc9QSUMhJSI1O0BUh7',
                           client_secret: '88A834367B98398C0CE018627582A3F2CEBE7DE1EFFB0D890F1C34D7BA44B4FF',
                           authentication_callback: Proc.new {|x| Rails.logger.debug x.to_s},
                           api_version: '41.0')


 response = $client.get('https://pwccrm.ptp.pwc.myshn.net/services/apexrest/TransactionAcceptance/v1/' + $PRID)
 result = response.body