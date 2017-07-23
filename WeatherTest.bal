import ballerina.net.http;
import ballerina.lang.system;
import ballerina.lang.messages;

connector Accwether(string locationcode ) {
    http:ClientConnector weatherEP = create http:ClientConnector("http://dataservice.accuweather.com");

    action getweather(Accwether accwether, string msg)(message ) {
        message request = {};
        string apikey="";
        string weatherPath = "/currentconditions/v1/" + locationcode +".json?apikey=HYbrYjfzFP5vAqA3P3V8DbvQf0i0EmAP";
        message response = http:ClientConnector.get(weatherEP, weatherPath, request);

        json jsonRequest = messages:getJsonPayload(response);

        var weatherText,_=(string) jsonRequest[0].WeatherText;
        var DateTime,_=(string) jsonRequest[0].LocalObservationDateTime;
        var Temperature,_= (float)jsonRequest[0].Temperature.Metric.Value;
        var Unit,_=(string) jsonRequest[0].Temperature.Metric.Unit;

        system:println("Your current location has "+Temperature+""+Unit+" of temperature!");
        system:println("Weather is "+weatherText);

            if(weatherText=="Sunny")
            {
            system:println("Bring a hat or a cap with you!");
            }
            else if(weatherText=="Rain")
            {
            system:println("Bring an umbrella with you!");
            }
            else if(weatherText=="Snow")
            {
            system:println("Make sure to wear a switer!");
            }
            else if(weatherText=="T-Storms")
            {
            system:println("Don't go out!");
            }
            else
            {
            system:println("Engage your daily routine!");
            }
        return response;
    }
}


function main(string[] args) {
    Accwether getwheather = create Accwether("335315");
    Accwether.getweather(getwheather, "test");
}