using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class SudokuZoomView extends Ui.View {

	var zoom;
	var upIcon,downIcon;
	var inputNumber=1;
	var currentSelector;
	var sudoKuView;
	var zoomMatrixObject = {};
    function initialize(currSel) {
    	zoom = new Rez.Drawables.SudokuBase();
    	currentSelector= currSel;
    	upIcon = Ui.loadResource(Rez.Drawables.upButton);
    	downIcon = Ui.loadResource(Rez.Drawables.downButton);
    	sudoKuView = currentSelector.getSodukoObj();
    	
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
        zoom.draw(dc);
        
        //Draw boundries
        for(var i = 0;i<4;i++){
        	dc.setColor( Gfx.COLOR_BLACK,Gfx.COLOR_LT_GRAY);
        	dc.drawLine(0, 48*i, 144, 48*i);
        	dc.drawLine(48*i,0,48*i,144);
        }
        
        var grid= currentSelector.getCurrGrid();
        for(var l=0 ; l < 3 ; l++){
        	for(var k=0 ; k < 3 ; k++){
        		var matrixVal = sudoKuView.getGridVal(grid,l,k);
        		var checkMatrix = sudoKuView.checkSystemCell(grid,l,k);
        		if(matrixVal!= null && checkMatrix == false){
        			zoomMatrixObject.put(matrixVal,1);
        		 	dc.setColor( Gfx.COLOR_DK_GRAY,Gfx.COLOR_WHITE);
        			dc.drawText(22+(48*k),12+(48*l),  Gfx.FONT_NUMBER_MILD ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        		}
        		else if(matrixVal!= null && checkMatrix == true){
        			zoomMatrixObject.put(matrixVal,1);
        		 	dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_WHITE);
        			dc.drawText(22+(48*k),12+(48*l),  Gfx.FONT_NUMBER_MILD ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        		}
        	}
        }
        
        //Set Zoom Matrci to Keep track of validation.
        currentSelector.setValidationZoom(zoomMatrixObject);
        
        dc.drawBitmap(152,2, upIcon);
        dc.drawBitmap(152,98, downIcon );
        dc.setColor( Gfx.COLOR_BLACK,Gfx.COLOR_WHITE);
        dc.drawText(173,55,  Gfx.FONT_NUMBER_HOT ,currentSelector.getCurrSelector(), Gfx.TEXT_JUSTIFY_CENTER);
        if(currentSelector.getCurrZoomGrid()!= null){
        	dc.setColor( Gfx.COLOR_LT_GRAY,Gfx.COLOR_WHITE);
        	var x = currentSelector.getCurrZoomPointA();
        	var y = currentSelector.getCurrZoomPointB();
        	dc.fillRectangle((48 * y.toNumber())+1,(48 * x.toNumber())+1,47,47);
        	var matrixVal = sudoKuView.getGridVal(currentSelector.getCurrGrid(),x,y);
        	var checkMatrix = sudoKuView.checkSystemCell(currentSelector.getCurrGrid(),x,y);
        		if(matrixVal!= null && checkMatrix == true){
        		 	dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_LT_GRAY);
        			dc.drawText(22+(48*y),12+(48*x),  Gfx.FONT_NUMBER_MILD ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        		 }
        		 else if(matrixVal!= null && checkMatrix == false){
        		 	dc.setColor( Gfx.COLOR_DK_GRAY,Gfx.COLOR_LT_GRAY);
        			dc.drawText(22+(48*y),12+(48*x),  Gfx.FONT_NUMBER_MILD ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        		 }
        	
       		dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_WHITE);
        }
    }
  


    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}
