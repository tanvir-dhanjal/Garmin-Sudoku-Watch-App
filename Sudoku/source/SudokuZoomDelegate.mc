using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Attention as Attention;

class SudokuZoomDelegate extends Ui.BehaviorDelegate{

var sudokuView;
var currentState;
var currPicker;
var sudokuZoomViewObj;

    function initialize(currState) {
       currentState = currState;
       sudokuView=currentState.getSodukoObj();
       currPicker= currentState.getCurrSelector();
       BehaviorDelegate.initialize();
       
    }

     function onTap(evt) {
       	var cord = evt.getCoordinates();
       	var side = getSideGrid(cord[0], cord[1]);
       	sudokuZoomViewObj= currentState.getSodukoZoomObj();
		if(side == 11 || side ==13){
       		if(side ==11){
       			if(currPicker<9){
       				currPicker = currPicker + 1;
       			}
       		}
       		if(side ==13){
       			if(currPicker>1){
       				currPicker = currPicker - 1;
       			}
       		}
      
       		currentState.setCurrSelector(currPicker);
       		sudokuZoomViewObj.requestUpdate();
       		return true;
       	}
       	else if(side == 12){
       		if(currentState.getCurrGrid()!= null){
       			var zoomMap = currentState.getValidationZoom();
       			
       			if(zoomMap.get(currentState.getCurrSelector())== null)
       			{
       				if(sudokuView.checkRowGrid(currentState.getCurrGrid(), currentState.getCurrZoomPointA(),currentState.getCurrZoomPointB(), currentState.getCurrSelector())){
       					if(sudokuView.checkColumnGrid(currentState.getCurrGrid(), currentState.getCurrZoomPointA(),currentState.getCurrZoomPointB(), currentState.getCurrSelector())){
       						if(!sudokuView.checkSystemCell(currentState.getCurrGrid(), currentState.getCurrZoomPointA(),currentState.getCurrZoomPointB())){
       							sudokuView.updateGrid(currentState.getCurrGrid(), currentState.getCurrZoomPointA(),currentState.getCurrZoomPointB(), currentState.getCurrSelector());	
       							Ui.popView(Ui.SLIDE_DOWN);
       						}
       						else{
       			  				wrongInputAlert();
        						Ui.requestUpdate();
        						return true;
       						}
       					}
       					else{
       			  			wrongInputAlert();
        					Ui.requestUpdate();
        					return true;
       					}
       				}
       				else{
       			  		wrongInputAlert();
        				Ui.requestUpdate();
        				return true;
       				}
       			}
       			else{
       			  	wrongInputAlert();
        			Ui.requestUpdate();
        			return true;
       			}

       		}
       		return true;
       	}
       	else{
    		
    		return true;
		}
        return true;
    }

	function wrongInputAlert(){
		var vibrateData = [
                        new Attention.VibeProfile(  25, 100 ),
                        new Attention.VibeProfile(  50, 100 ),
                        new Attention.VibeProfile(  75, 100 ),
                        new Attention.VibeProfile( 100, 100 ),
                        new Attention.VibeProfile(  75, 100 ),
                        new Attention.VibeProfile(  50, 100 ),
                        new Attention.VibeProfile(  25, 100 )
                      ];
       			
       Attention.vibrate( vibrateData );
	}
	
    function getSideGrid(x,y){
		if(x>144 && y>0  && y <= 48){
    			return 11;
    	}
    	if(x>144 && y>48  && y <= 96){
    			return 12;
    	}
    	if(x>144 && y>96  && y <= 144){
    			return 13;
    	}
    	return 14;
	}

}