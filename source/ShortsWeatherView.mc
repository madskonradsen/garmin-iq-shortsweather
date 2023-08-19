import Toybox.Graphics;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Weather;
import Toybox.Lang;

const INTEGER_FORMAT = "%d";

class ShortsWeatherView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        drawWeather();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function drawWeather() {
        if (!(Toybox has :Weather && Toybox.Weather has :getCurrentConditions)) {
            // For debugging purposes as this should never happen on the supported devices
            System.println("The device doesn't support Weather");
            return;
        }
        var currentConditions = Toybox.Weather.getCurrentConditions();

        var answerText = findDrawableById("answer") as Text;

        // If we don't have weather data available
        if (currentConditions == null || currentConditions.temperature == null) {
            answerText.setText(WatchUi.loadResource($.Rez.Strings.NoWeatherData) as String);
            answerText.setColor(Graphics.COLOR_YELLOW);
            return;
        }

        // Set answer
        if (currentConditions.temperature >= 17) {
            answerText.setText(WatchUi.loadResource($.Rez.Strings.Yes) as String);
            answerText.setColor(Graphics.COLOR_GREEN);
        } else {
            answerText.setText(WatchUi.loadResource($.Rez.Strings.No) as String);
            answerText.setColor(Graphics.COLOR_RED);
        }

        // Show current temp
        var reasonText = findDrawableById("reason") as Text;
        var temperature = currentConditions.temperature;

        if (System.getDeviceSettings().temperatureUnits == System.UNIT_STATUTE) {
            temperature = (temperature * (9.0 / 5)) + 32;
        }

        temperature = temperature.format(INTEGER_FORMAT) + "°";

        reasonText.setText(temperature); 
    }

}
