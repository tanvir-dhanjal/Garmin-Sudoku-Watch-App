using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class MainScreen extends Ui.View {
var base;

    function initialize() {
    	base = new Rez.Drawables.SudokuBase();
    	
    }

    //! Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
        
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        base.draw(dc);
        
        //Draw boundries
        for(var i = 1;i<3;i++){
        	dc.setColor( Gfx.COLOR_BLACK,Gfx.COLOR_LT_GRAY);
        	dc.drawLine(0, 49*i, 205, 49*i);
        }
        dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_WHITE);
        dc.drawText(100,15,  Gfx.FONT_MEDIUM ,"Easy", Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(100,60,  Gfx.FONT_MEDIUM ,"Medium", Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(100,105,  Gfx.FONT_MEDIUM ,"Hard", Gfx.TEXT_JUSTIFY_CENTER);
    }
  


    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}
