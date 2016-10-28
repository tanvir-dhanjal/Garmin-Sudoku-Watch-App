using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Math as ma;
using Toybox.Timer as tim;
class SudokuView extends Ui.View {

	var matrix;
	var SQUARE=16;
	var xConst=22;
	var yConst=16;
	var matrixObject = {};
	var matrixArray = new [9];
	var matrixArrayBoolean = new [9];
	var validRowInsert = {};
	var validColumnInsert = {}; 
	var shallInsert;
	var stateObj;
	var matrixVal;
	var checkMatrix;
	var matrixKey;
	var mKey;
	var searchedObj;
	
	 function initialize(currState) {
    	matrix = new Rez.Drawables.SudokuBase();
    	currState.setHolesLeft(81-currState.getLevel());
    	stateObj = currState;
    	initializeSudoku(currState.getLevel());
	 }
    
    //Load the initial Sudoku.
    function initializeSudoku(level){
    	matrixArray[0] = [1,2,3,4,5,6,7,8,9];
    	matrixArray[1] = [4,5,6,7,8,9,1,2,3];
    	matrixArray[2] = [7,8,9,1,2,3,4,5,6];
    	matrixArray[3] = [2,3,4,5,6,7,8,9,1];
    	matrixArray[4] = [5,6,7,8,9,1,2,3,4];
    	matrixArray[5] = [8,9,1,2,3,4,5,6,7];
    	matrixArray[6] = [3,4,5,6,7,8,9,1,2];
    	matrixArray[7] = [6,7,8,9,1,2,3,4,5];
    	matrixArray[8] = [9,1,2,3,4,5,6,7,8];
		
		matrixArrayBoolean[0] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[1] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[2] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[3] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[4] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[5] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[6] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[7] =[1,1,1,1,1,1,1,1,1];
		matrixArrayBoolean[8] =[1,1,1,1,1,1,1,1,1];
		
        //Make rows and columsn shuffle
		loadSudoku();
    	makeHoles(level);
    	populateValidate();
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
    	if(stateObj.getHolesLeft() == 0){
    		Ui.pushView(new WinGame(),new WinGameDelegate() , Ui.SLIDE_UP);
    	}
        matrix.draw(dc);
        var startX =3;
        var startY =2;
        var gridNumber =0;
        var gridObj;
        
        for(var l=0 ; l < 3 ; l++){
        	for(var i=0 ; i < 3 ; i++){
        		gridNumber++;
        		for(var j=0 ; j < 3 ; j++){
        			for(var k=0 ; k < 3 ; k++){
        				gridObj = new MainGrid((startX+(k*xConst)),(startY+(j *yConst)),(j+(l*3)),(k+(i *3)));
        				matrixKey = (gridNumber*100) + (j*10) +  k;
        				matrixObject.put(matrixKey, gridObj);
        				matrixVal = getGridVal(gridNumber,j,k);
        				checkMatrix = checkSystemCell(gridNumber,j,k);
        				if(matrixVal!= null && checkMatrix == true){
        		 			dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_WHITE);
        					dc.drawText(13+(22*k)+(66*i),(16*j)+(48*l),  Gfx.FONT_XTINY ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        					dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_LT_GRAY);
        				}
        				else if (matrixVal!= null && checkMatrix == false){
        		 			dc.setColor( Gfx.COLOR_DK_GRAY,Gfx.COLOR_WHITE);
        					dc.drawText(13+(22*k)+(66*i),(16*j)+(48*l),  Gfx.FONT_XTINY ,matrixVal, Gfx.TEXT_JUSTIFY_CENTER);
        					dc.setColor( Gfx.COLOR_RED,Gfx.COLOR_LT_GRAY);
        				}
        			}
        		}
        		startX = startX + (SQUARE*3);
        	}
        	startY = startY + (SQUARE*3);
        	startX=0;
        }
        
        //Draw boundries
        for(var i = 0;i<10;i++){
        	if(i%3 ==0){
        		dc.setColor( Gfx.COLOR_BLACK,Gfx.COLOR_LT_GRAY);
        		}
        	else{
        		dc.setColor( Gfx.COLOR_YELLOW,Gfx.COLOR_LT_GRAY);
        	}	
        	dc.drawLine(3, 2+(yConst*i), 201,2+ (yConst*i));
        	dc.drawLine(3+(xConst*i),2,3+(xConst*i),146);
        }
    }
    
    function getGrid(x,y){
    	if(x>0  && x<69  && y>0  && y < 48){
    			return 1;
    	}
    	if(x>69 && x<125  && y>0  && y < 48){
    			return 2;
    		}
    	if(x>125 && x<198 && y>0  && y < 48){
    			return 3;
    		}
    	if(x>0  && x<48  && y>48 && y < 96){
    			return 4;
    		}
    	if(x>69 && x<125  && y>48  && y < 96){
    			return 5;
    		}
    	if(x>125 && x<198 && y>48  && y < 96){
    			return 6;
    		}
    	if(x>0  && x<69  && y>96 && y < 144){
    			return 7;
    		}
    	if(x>69 && x<125  && y>96 && y < 144){
    			return 8;
    		}
     	if(x>125 && x<198 && y>96 && y < 144){
    			return 9;    			
    		}
    	return 0;	
    }

	function getGridXY(grid){
    	if(grid == 1){
    			return "00";
    	}
    	else if(grid == 2){
    			return "01";
    	} 
    	else if(grid == 3){
    			return "02";
    	} 
    	else if(grid == 4){
    			return "10";
    	} 
    	else if(grid == 5){
    			return "11";
    	} 
    	else if(grid == 6){
    			return "12";
    	} 
    	else if(grid == 7){
    			return "20";
    	} 
    	else if(grid == 8){
    			return "21";
    	} 
    	else if(grid == 9){
    			return "22";
    	}  
    	return "-1";	
    }
	
	function updateGrid(grid,cellX,cellY,val){
		var mKey = (grid*100) + (cellX*10) +  cellY;
		var searchedObj;
		searchedObj = matrixObject.get(mKey);
	    if(val > 0 ){
	    	matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()]= val.toNumber();
	    	stateObj.setHolesLeft(stateObj.getHolesLeft()+1);
	    	if(!matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()].equals("") && matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()]>=0){
					if(validRowInsert.get(searchedObj.getArrayX().toNumber())!=null){
						var str = validRowInsert.get(searchedObj.getArrayX().toNumber());
						validRowInsert.put(searchedObj.getArrayX().toNumber(),str + matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()].toString());
					}
					else{
						validRowInsert.put(searchedObj.getArrayX().toNumber(), matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()].toString());
					}	
					
					if(validColumnInsert.get(searchedObj.getArrayY().toNumber())!=null){
						var str = validColumnInsert.get(searchedObj.getArrayY().toNumber());
						validColumnInsert.put(searchedObj.getArrayY().toNumber(),str + matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()].toString());
					}
					else{
						validColumnInsert.put(searchedObj.getArrayY().toNumber(), matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()].toString());
					}	
				}
		}
		else{
			if(!matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY()].toString().equals("")){
				var value = matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()];
				var colStr = validColumnInsert.get(searchedObj.getArrayY().toNumber());
				var rowStr = validRowInsert.get(searchedObj.getArrayX().toNumber());
				if(colStr.find(value.toString())!= null){
					if(colStr.length() ==1){
						validColumnInsert.put(searchedObj.getArrayY().toNumber(),"");
					}
					else{
						var finalColStr =  colStr.substring(0,colStr.find(value.toString())) + colStr.substring(colStr.find(value.toString())+1 ,colStr.length()); 
						validColumnInsert.put(searchedObj.getArrayY().toNumber(),finalColStr );
					}
				}

				
			}
		    matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()]= "";
		    stateObj.setHolesLeft(stateObj.getHolesLeft()-1);
		}
				
	}
	
	function checkSystemCell(grid,cellX,cellY){
		var mKey = (grid*100) + (cellX*10) +  cellY;
		var searchedObj;
		searchedObj = matrixObject.get(mKey);
	    if(matrixArrayBoolean[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()] == 0){
	    	return false;
	    }
	    return true;
	}
	
	function checkColumnGrid(grid,cellX,cellY,val){
		mKey = (grid*100) + (cellX*10) +  cellY;
		searchedObj = matrixObject.get(mKey);
		
		if(validColumnInsert.get(searchedObj.getArrayY().toNumber())!=null){
			var str = validColumnInsert.get(searchedObj.getArrayY().toNumber());
			if(str.find(val.toString())!= null){
				return false;
			}
		}
		return true;
	}
	
	function checkRowGrid(grid,cellX,cellY,val){
		mKey = (grid*100) + (cellX*10) +  cellY;
		searchedObj = matrixObject.get(mKey);
		
		if(validRowInsert.get(searchedObj.getArrayX().toNumber())!=null){
			var str = validRowInsert.get(searchedObj.getArrayX().toNumber());
			if(str.find(val.toString())!= null){
				return false;
			}
		}
		return true;
	}
	
	function populateValidate(){
		for(var i=0;i<9;i++){
			for(var j=0;j<9;j++)
			{
				if(!matrixArray[i][j].equals("") && matrixArray[i][j]>=0){
					if(validRowInsert.get(i)!=null){
						var str = validRowInsert.get(i);
						validRowInsert.put(i,str + matrixArray[i][j].toString());
					}
					else{
						validRowInsert.put(i, matrixArray[i][j].toString());
					}	
					
					if(validColumnInsert.get(j)!=null){
						var str = validColumnInsert.get(j);
						validColumnInsert.put(j,str + matrixArray[i][j].toString());
					}
					else{
						validColumnInsert.put(j, matrixArray[i][j].toString());
					}	
				}
			}
		}
	}
	

	
	function getGridVal(grid,cellX,cellY){
		mKey = (grid*100) + (cellX*10) +  cellY;
		searchedObj = matrixObject.get(mKey);
		var res ; 
		res = matrixArray[searchedObj.getArrayX().toNumber()][searchedObj.getArrayY().toNumber()];
	    return res;
	}
	
	function getGridMap(gridKey){
		searchedObj = matrixObject.get(gridKey);
		var response = new [2];
		response[0] = searchedObj.getPointA();
		response[1]= searchedObj.getPointB();
		return response;
	}
	
	function loadSudoku(){
	    // Timer Object to start timer so that we can get random numbers to dig holes in Matrix.
        var timer = new tim.Timer();
        timer.start( method(:done), 5000, true );
        var clockTime;
        var remainingIteration=10;
        var lastRandom = 0;
		var randomNumber;
		var matrixArrayTemp;
		var swap = 0; // 0 means swap rows;
		while(remainingIteration > 0){
			for(var i=0;i<9;i++){
				for(var j=0;j<9;j++)
				{
					if(remainingIteration <=0) {
						timer.stop();
						return;
					}
				
					clockTime = Sys.getTimer(); 
					ma.srand(clockTime.toNumber());
					// Generating random number with by seeding it with current timer.
					randomNumber = (ma.rand()*((i+1)*(j+1)))%10;
					if(randomNumber<0){randomNumber=randomNumber*-1;}
					if(randomNumber == 0 && swap == 0 ){
						swap = 1; // 1 means swap columns
						continue;
					}
					if(randomNumber == 0 && swap == 1 ){
						swap = 0 ;// 1 means swap columns
						continue;
					}
					
					// shuffle rows
					if(swap == 0 && lastRandom != randomNumber){
						if(randomNumber <= 3){
							if(randomNumber == 1){
								// if last random value greater than 5 then swap row 1 with row 2 else with row 3
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[0];
									matrixArray[0]=matrixArray[1];
									matrixArray[1]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[0];
									matrixArray[0]=matrixArray[2];
									matrixArray[2]=matrixArrayTemp;
									remainingIteration--;
								}
							}
							else if(randomNumber == 2){
								// if last random value greater than 5 then swap row 2 with row 1 else with row 3
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[1];
									matrixArray[1]=matrixArray[0];
									matrixArray[0]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[1];
									matrixArray[1]=matrixArray[2];
									matrixArray[2]=matrixArrayTemp;
									remainingIteration--;
								}
							}
							else{
								// if last random value greater than 5 then swap row 3 with row 1 else with row 2
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[2];
									matrixArray[2]=matrixArray[0];
									matrixArray[0]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[2];
									matrixArray[2]=matrixArray[1];
									matrixArray[1]=matrixArrayTemp;
									remainingIteration--;
								}
							}
						}
						else if (randomNumber <= 6 && randomNumber > 3){
							if(randomNumber == 4){
								// if last random value greater than 5 then swap row 4 with row 5 else with row 6
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[3];
									matrixArray[3]=matrixArray[4];
									matrixArray[4]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[3];
									matrixArray[3]=matrixArray[5];
									matrixArray[5]=matrixArrayTemp;
									remainingIteration--;
								}
							}
							else if(randomNumber == 5){
								// if last random value greater than 5 then swap row 5 with row 4 else with row 6
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[4];
									matrixArray[4]=matrixArray[3];
									matrixArray[3]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[4];
									matrixArray[4]=matrixArray[5];
									matrixArray[5]=matrixArrayTemp;
									remainingIteration--;
								}
							}
							else{
								// if last random value greater than 5 then swap row 6 with row 4 else with row 5
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[5];
									matrixArray[5]=matrixArray[3];
									matrixArray[3]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[5];
									matrixArray[5]=matrixArray[4];
									matrixArray[4]=matrixArrayTemp;
									remainingIteration--;
								}
							}
						}
						else{
							if(randomNumber == 7){
								// if last random value greater than 5 then swap row 7 with row 8 else with row 9
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[6];
									matrixArray[6]=matrixArray[7];
									matrixArray[7]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[6];
									matrixArray[6]=matrixArray[8];
									matrixArray[8]=matrixArrayTemp;
									remainingIteration--;
								}
							}
							else if(randomNumber == 8){
								// if last random value greater than 5 then swap row 8 with row 7 else with row 9
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[7];
									matrixArray[7]=matrixArray[6];
									matrixArray[6]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[7];
									matrixArray[7]=matrixArray[8];
									matrixArray[8]=matrixArrayTemp;
									remainingIteration--;
								}
							}
							else{
								// if last random value greater than 5 then swap row 9 with row 7 else with row 8
								if(lastRandom>5){
									matrixArrayTemp = matrixArray[8];
									matrixArray[8]=matrixArray[6];
									matrixArray[6]=matrixArrayTemp;
									remainingIteration--;
								}
								else{
									matrixArrayTemp = matrixArray[8];
									matrixArray[8]=matrixArray[7];
									matrixArray[7]=matrixArrayTemp;
									remainingIteration--;
								}
							}
						}
					}
					// shuffle columns
					if(swap == 1 && lastRandom != randomNumber){
						if(randomNumber <= 3){
							if(randomNumber == 1){
								// if last random value greater than 5 then swap row 1 with row 2 else with row 3
								if(lastRandom>5){
									swapColumns(0,1);
									remainingIteration--;
								}
								else{
									swapColumns(0,2);
									remainingIteration--;
								}
							}
							else if(randomNumber == 2){
								// if last random value greater than 5 then swap row 2 with row 1 else with row 3
								if(lastRandom>5){
									swapColumns(1,0);
									remainingIteration--;
								}
								else{
									swapColumns(1,2);
									remainingIteration--;
								}
							}
							else{
								// if last random value greater than 5 then swap row 3 with row 1 else with row 2
								if(lastRandom>5){
									swapColumns(2,0);
									remainingIteration--;
								}
								else{
									swapColumns(2,1);
									remainingIteration--;
								}
							}
						}
						else if (randomNumber <= 6 && randomNumber > 3){
							if(randomNumber == 4){
								// if last random value greater than 5 then swap row 4 with row 5 else with row 6
								if(lastRandom>5){
									swapColumns(3,4);
									remainingIteration--;
								}
								else{
									swapColumns(3,5);
									remainingIteration--;
								}
							}
							else if(randomNumber == 5){
								// if last random value greater than 5 then swap row 5 with row 4 else with row 6
								if(lastRandom>5){
									swapColumns(4,3);
									remainingIteration--;
								}
								else{
									swapColumns(4,5);
									remainingIteration--;
								}
							}
							else{
								// if last random value greater than 5 then swap row 6 with row 4 else with row 5
								if(lastRandom>5){
									swapColumns(5,3);
									remainingIteration--;
								}
								else{
									swapColumns(5,4);
									remainingIteration--;
								}
							}
						}
						else{
							if(randomNumber == 7){
								// if last random value greater than 5 then swap row 7 with row 8 else with row 9
								if(lastRandom>5){
									swapColumns(6,7);
									remainingIteration--;
								}
								else{
									swapColumns(6,8);
									remainingIteration--;
								}
							}
							else if(randomNumber == 8){
								// if last random value greater than 5 then swap row 8 with row 7 else with row 9
								if(lastRandom>5){
									swapColumns(7,6);
									remainingIteration--;
								}
								else{
									swapColumns(7,8);
									remainingIteration--;
								}
							}
							else{
								// if last random value greater than 5 then swap row 9 with row 7 else with row 8
								if(lastRandom>5){
									swapColumns(8,6);
									remainingIteration--;
								}
								else{
									swapColumns(8,7);
									remainingIteration--;
								}
							}
						}
					}
					
				}
			}
		}
		timer.stop();
	}
	
	
	function makeHoles(holesToMake)
	{
	    // Timer Object to start timer so that we can get random numbers to dig holes in Matrix.
        var timer = new tim.Timer();
        timer.start( method(:done), 5000, true );
        
		var clockTime;
		var remainingHoles = holesToMake;
		var lastRandom = 0;
		var randomNumber;
		while(remainingHoles>0){
		
			for(var i=0;i<9;i++){
				for(var j=0;j<9;j++)
				{
					if(remainingHoles <=0) {
						timer.stop();
						return;
					}
					clockTime = Sys.getTimer(); 
					ma.srand(clockTime.toNumber());
					// Generating random number with by seeding it with current timer.
					randomNumber = (ma.rand()*((i+1)*(j+1)))%10;
					if(randomNumber<0){randomNumber=randomNumber*-1;}
					
					if(randomNumber.toNumber() > lastRandom.toNumber()  && remainingHoles > 0 && !matrixArray[i][j].equals(""))
					{
						matrixArray[i][j] = "";
						matrixArrayBoolean[i][j]=0;
						remainingHoles--;
					}
					lastRandom=randomNumber;
				}
			}
		}
		timer.stop();
	}
	
	// Dummy call back function needed for timer boject
	function done(){
	}
	
	// Util function to swap 2 columns in a array
	function swapColumns(col1,col2){
		for(var j=0;j<9;j++){
			var temp = matrixArray[j][col1];
			matrixArray[j][col1]=matrixArray[j][col2];
			matrixArray[j][col2]=temp;
		}
	}
	
	
	
    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}

