package MessageRouting.MessageFiltering;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.xmls;
import ballerina.lang.system;

@http:BasePath{value: "/defaultStockQuote"}
service defaultStockQuote {

    @http:POST{}
    resource stocks(message m) {
	string stock = messages:getStringPayload(m);
        system:println("defaultStockQuote = " + stock);
        message response = {};
        xml payload = `<DefaultstockQuoteResponse>
        <symbol>test</symbol>
        <price>170.00</price>
        <volume>20</volume>
        </DefaultstockQuoteResponse>`;
        xmls:set(payload,"//DefaultstockQuoteResponse/symbol/text()",stock);
        messages:setXmlPayload(response, payload);
        reply response;
    }
}
