import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Timer;

(:glance)
class ShortsWeatherGlanceView extends WatchUi.GlanceView {
    hidden var timer;
    hidden var mainview;
    hidden var requested = false;

    function initialize() {
        GlanceView.initialize();
        timer = new Timer.Timer();
    }

    function onShow() {
        // Refresh the glance view based on elapsed time
        timer.start( method(:onTimer), 300*1000, true);
    }

    function onHide() {
        timer.stop();
    }

    function onTimer() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        var weatherState = ShortsWeatherService.getWeatherState();

		dc.setColor(weatherState.answerColor, Graphics.COLOR_TRANSPARENT);
		dc.drawText(0, dc.getHeight() / 2, Graphics.FONT_TINY, weatherState.answer, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        if(weatherState.temperature != null) {
            dc.clear();
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		    dc.drawText(dc.getWidth() - 5, dc.getHeight() / 2, Graphics.FONT_TINY, weatherState.reason, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
}