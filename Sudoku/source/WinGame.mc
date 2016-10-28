using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class WinGame extends Ui.View {
var base;

    function initialize() {
    	Sys.println("Loading Application");
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
        dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_WHITE);
        dc.drawText(100,60,  Gfx.FONT_MEDIUM ,"You Won!!", Gfx.TEXT_JUSTIFY_CENTER);
    }
  


    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}


class WinGameDelegate extends Ui.BehaviorDelegate {

    function initialize() {
    }

    function onTap(evt) {
  		Sys.exit();
    }
    
    function onMenu() {
  		Sys.exit();
    }
    
    function onBack(){
    	Sys.exit();
    }


}

