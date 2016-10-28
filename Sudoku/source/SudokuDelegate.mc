using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class SudokuDelegate extends Ui.BehaviorDelegate {
var sudokuView;
var currState;
    function initialize(curState) {
    	currState= curState;
    	sudokuView = currState.getSodukoObj();
        BehaviorDelegate.initialize();
    }

    function onTap(evt) {
    	var cord = evt.getCoordinates();
    	var grid = sudokuView.getGrid(cord[0],cord[1]);
    	var sudoKuSubView = new SudokuSubView(currState);
    	currState.setSodukoSubObj(sudoKuSubView);
    	currState.setCurrGrid(grid);
        Ui.pushView(sudoKuSubView,new SudokuSubDelegate(currState) , Ui.SLIDE_UP);
        return true;
    }
    
    function onBack(){
    	Sys.exit();
    }


}

