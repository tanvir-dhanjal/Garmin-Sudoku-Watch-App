using Toybox.Lang as Lang;

class State{
var currVal;
var currGrid;
var level;
var currZoomPointA;
var currZoomPointB;
var currSelector=2;
var sodukoZoomObj;
var sodukoSubObj;
var sodukoObj;
var currZoomGrid;
var validationZoom;
var holesleft;

	function getHolesLeft(){
    	return holesleft;
    }
	function setHolesLeft(holeRemaining){
    	holesleft = holeRemaining;
    }
	function getValidationZoom(){
    	return validationZoom;
    }
	function setValidationZoom(validZoom){
    	validationZoom = validZoom;
    }
    function getLevel(){
    	return level;
    }
	function setLevel(gameLevel){
    	level = gameLevel;
    }
	function getCurrSelector(){
    	return currSelector;
    }
	function setCurrSelector(currSel){
    	currSelector = currSel;
    }
    
    function getSodukoZoomObj(){
    	return sodukoZoomObj;
    }
	function setSodukoZoomObj(obj){
    	sodukoZoomObj = obj;
    }    

    function getSodukoObj(){
    	return sodukoObj;
    }
	function setSodukoObj(obj){
    	sodukoObj = obj;
    }    
    
    function getSodukoSubObj(){
    	return sodukoSubObj;
    }
	function setSodukoSubObj(obj){
    	sodukoSubObj = obj;
    }    
    
    function getCurrGrid(){
    	return currGrid;
    }
	function setCurrGrid(currentGrid){
    	currGrid = currentGrid;
    }         

    function getCurrZoomGrid(){
    	return currZoomGrid;
    }
	function setCurrZoomGrid(currentZoomGrid){
    	currZoomGrid = currentZoomGrid;
    }    
    
    function getCurrZoomPointA(){
    	return currZoomPointA.toNumber();
    }
	function setCurrZoomPointA(curZoomPointA){
    	currZoomPointA = curZoomPointA;
    } 
    
    function getCurrZoomPointB(){
    	return currZoomPointB.toNumber();
    }
	function setCurrZoomPointB(curZoomPointB){
    	currZoomPointB = curZoomPointB;
    }    
    

}