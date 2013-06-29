package com.haxepunk.ui;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

import com.haxepunk.graphics.Image;

/**
 * @author PigMess
 */

class TextField extends TextArea
{	
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 30, text:String = "")
	{
		super(x, y, width, height, text);
		_textField.multiline = false;
		_textField.wordWrap = false;
	}
}
