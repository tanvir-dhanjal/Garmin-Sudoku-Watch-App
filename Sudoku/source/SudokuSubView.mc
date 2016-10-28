using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class SudokuSubView extends Ui.View {

	var sub;
	var currentSelector;
	var xConst=22;
	var yConst=16;
	var sudoKuView;
	
    function initialize(currSel) {
    	sub = new Rez.Drawables.SudokuBase();
    	currentSelector= currSel;
    	sudoKuView = currentSelector.getSodukoObj();
    }

    //! Load your resources here
    function onLayout(dc) {
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        sub.draw(dc);
        
        //Draw boundries
        for(var i = 0;i<4;i++){
        	dc.setColor( Gfx.COLOR_BLACK,Gfx.COLOR_LT_GRAY);
        	dc.drawLine(3, 2+(yConst*i*3), 201,2+ (yConst*i*3));
        	dc.drawLine(3+(xConst*i*3),2,3+(xConst*i*3),146);
        }
        
        var grid= currentSelector.getCurrGrid();
        for(var l=0 ; l < 3 ; l++){
        	for(var k=0 ; k < 3 ; k++){
        		var matrixVal = sudoKuView.getGridVal(grid,l,k);
        		var checkMatrix = sudoKuView.checkSystemCell(grid,l,k);
        		if(matrixVal!= null && checkMatrix == false){
        		 	dc.setColor( Gfx.COLOR_DK_GRAY,Gfx.COLOR_WHITE);
        			dc.drawText(33+(66*k),12+(48*l),  Gfx.FONT_NUMBER_MILD ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        		}
        		
        		if(matrixVal!= null && checkMatrix == true){
        		 	dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_WHITE);
        			dc.drawText(33+(66*k),12+(48*l),  Gfx.FONT_NUMBER_MILD ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        		}
        		
        	}
        }
        
    }
  


    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}
