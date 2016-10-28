using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MainScreenDelegate extends  Ui.BehaviorDelegate
{
	var currSel = new State(); 
    function initialize() {
    	}

	function onTap(evt) {
       	var cord = evt.getCoordinates();
       	touchedOn(cord[0],cord[1]);
       	
    	var sudokuView = new SudokuView(currSel);
    	currSel.setSodukoObj(sudokuView);
    	Ui.pushView( sudokuView, new SudokuDelegate(currSel), SLIDE_IMMEDIATE );
    	
        return true;
    }
    function touchedOn(x,y)
    {
        if( y < 49 ) {
            currSel.setLevel(35);
        }
        else if( y >= 49 && y < 98) {
        	 currSel.setLevel(50);
        }
        else{
        	currSel.setLevel(65);
        }
    }
    

}