using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class SudokuSubDelegate extends Ui.BehaviorDelegate{

var sudokuView;
var currentState;
var currPicker;
var sudokuObj;

    function initialize(currState) {
       currentState = currState;
       sudokuView=currentState.getSodukoObj();
       currPicker= currentState.getCurrSelector();
       BehaviorDelegate.initialize();
       
    }

     function onTap(evt) {
       	var cord = evt.getCoordinates();
       	sudokuObj= currentState.getSodukoObj();
       	var selectedGrid = sudokuObj.getGrid(cord[0], cord[1]);
       	var gridXY = sudokuObj.getGridXY(selectedGrid);
       	currentState.setCurrZoomGrid(selectedGrid);
       	//var pointA = gridXY.substring(0,1);
    	//var pointB = gridXY.substring(1,2);
       	currentState.setCurrZoomPointA(gridXY.substring(0,1));
    	currentState.setCurrZoomPointB(gridXY.substring(1,2));
    	
    	// setting Zoom view for input.
    	var sudoKuZoomView = new SudokuZoomView(currentState);
    	currentState.setSodukoZoomObj(sudoKuZoomView);
    	Ui.pushView(sudoKuZoomView,new SudokuZoomDelegate(currentState) , Ui.SLIDE_UP);
        return true;
    }
    
    function onHold(evt){
    	var cord = evt.getCoordinates();
       	sudokuObj = currentState.getSodukoObj();
       	var selectedGrid = sudokuObj.getGrid(cord[0], cord[1]);
       	var gridXY = sudokuObj.getGridXY(selectedGrid);
        sudokuView.updateGrid(currentState.getCurrGrid(),gridXY.substring(0,1).toNumber() ,gridXY.substring(1,2).toNumber(), 0);	
    	currentState.getSodukoSubObj().requestUpdate();
       	return true;
    }
    
    function onBack() {
     	Ui.popView(Ui.SLIDE_DOWN);
        return true;
    }

   
}