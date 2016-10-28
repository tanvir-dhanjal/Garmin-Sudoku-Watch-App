//@CopyRight

using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;


class MainGrid{

	hidden var pointA;
	hidden var pointB;
	hidden var arrayX;
	hidden var arrayY;
	
	function initialize( PointA, PointB, ArrayX, ArrayY )
    {
    	pointA = PointA;
    	pointB = PointB;
    	arrayX = ArrayX;
    	arrayY = ArrayY;
    }
    function getPointA(){
    	return pointA;
    }
    
    function getPointB(){
    	return pointB;
    }
    
    function getArrayX(){
    	return arrayX;
    }
    
    function getArrayY(){
    	return arrayY;
    }
}

