import Toybox.WatchUi;
import Toybox.Weather;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Lang;

const INTEGER_FORMAT = "%d";

(:glance)
class ShortsWeatherService {

    function initialize() {
    }

    static function getWeatherState() {
        if (!(Toybox has :Weather && Toybox.Weather has :getCurrentConditions)) {
            // For debugging purposes as this should never happen on the supported devices
            System.println("The device doesn't support Weather");
        }

        var currentConditions = Toybox.Weather.getCurrentConditions();

        var weatherState = new WeatherState();

        // If we don't have weather data available
        if (currentConditions == null || currentConditions.temperature == null) {
            weatherState.answer = WatchUi.loadResource($.Rez.Strings.NoWeatherData) as String;
            weatherState.answerColor = Graphics.COLOR_YELLOW;
        // Set answer
        } else if (currentConditions.temperature >= 17) {
            weatherState.answer = WatchUi.loadResource($.Rez.Strings.Yes) as String;
            weatherState.answerColor = Graphics.COLOR_GREEN;
            weatherState.reason = getReason(currentConditions);
            weatherState.temperature = currentConditions.temperature;
        } else {
            weatherState.answer = WatchUi.loadResource($.Rez.Strings.No) as String;
            weatherState.answerColor = Graphics.COLOR_RED;
            weatherState.reason = getReason(currentConditions);
            weatherState.temperature = currentConditions.temperature;
        }

        return weatherState;
    }

    private static function getReason(currentConditions) {
        // Find current temp
        var temperature = currentConditions.temperature;

        if (System.getDeviceSettings().temperatureUnits == System.UNIT_STATUTE) {
            temperature = (temperature * (9.0 / 5)) + 32;
        }

        return temperature.format(INTEGER_FORMAT) + "°";
    }
}

(:glance)
class WeatherState {
    function initialize() {
    }

    public var answer;
    public var answerColor;
    public var reason;
    public var temperature = null;
}