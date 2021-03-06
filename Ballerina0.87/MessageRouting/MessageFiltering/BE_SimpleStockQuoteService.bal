package MessageRouting.MessageFiltering;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.xmls;
import ballerina.lang.system;

@http:BasePath{value: "/simpleStockQuote"}
service simpleStockQuote {


    @http:POST{}
    resource stocks(message m) {
        string stock = messages:getStringPayload(m);
        system:println("simpleStockQuote = " + stock);
        message response = {};
        xml payload = `<stockQuoteResponse>
        <symbol>test</symbol>
        <price>170.00</price>
        <volume>20</volume>
        </stockQuoteResponse>`;
        xmls:set(payload,"//stockQuoteResponse/symbol/text()",stock);
        messages:setXmlPayload(response, payload);
        reply response;
    }
}
