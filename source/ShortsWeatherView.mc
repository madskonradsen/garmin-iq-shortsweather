import Toybox.Graphics;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Weather;
import Toybox.Lang;

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
        var weatherState = ShortsWeatherService.getWeatherState();

        var answerText = findDrawableById("answer") as Text;

        answerText.setText(weatherState.answer);
        answerText.setColor(weatherState.answerColor);

        if(weatherState.temperature != null) {
            System.println("LOL");
            System.println(weatherState.temperature);
            System.println(weatherState.reason);
            // Show current temp
            var reasonText = findDrawableById("reason") as Text;
            reasonText.setText(weatherState.reason); 
        }
    }

}
