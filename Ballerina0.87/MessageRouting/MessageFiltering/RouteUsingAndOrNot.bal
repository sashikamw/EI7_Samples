package MessageRouting.MessageFiltering;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.jsons;
import Endpoints as endpoints;
import ballerina.lang.strings;

@http:BasePath{value: "/routeusingandornot"}
service UseAndOrNotService {

    @http:POST{}
    resource UseAndOrNotResource (message m) {
	http:ClientConnector jsonEP = create http:ClientConnector(endpoints:jsonEPurl);
        json jsonMsg = messages:getJsonPayload(m);
        string requesturl = http:getRequestURL(m);
        string urlexists = strings:contains(requesturl, "routeusingandor");
	    string exchange = messages:getHeader(m, "exchange");
	    string requestor = messages:getHeader(m, "requestor");
        float price = (float) jsons:getString(jsonMsg, "$.Stocks[0].price");
        string stockvalue = jsons:getString(jsonMsg, "$.Stocks[0].symbol");
	    
	    messages:setStringPayload( m, stockvalue);
        message response = {};
        
        // If requestor not euqal "Peter" then process the message 
        if (requestor != "Peter" ) {
            
            // If stock url contains "routeusingandor" AND stockvalue = "IBM" 
            if (urlexists == "true" && stockvalue == "IBM" ) {
                
        	    // Verify whether price >= 180 OR exchange = "nasdaq"
        	    if (price >= 180.00 || exchange == "nasdaq" ){
        	        response = http:ClientConnector.post(jsonEP, "/", m);
        	    } else {
                    string errorpayload = "Message do not meet the filter criteria";
                    messages:setStringPayload(response, errorpayload);
                }
            }
	        else {
                string errorpayload = "Message do not meet the filter criteria";
                messages:setStringPayload(response, errorpayload);
            }
            
        } else {
            string errorpayload = "You do not have permission to execute";
            messages:setStringPayload(response, errorpayload);
        }
        	
        reply response;
        
    }
    
}
