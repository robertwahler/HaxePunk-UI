package com.haxepunk.ui;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;
import flash.text.TextFormat;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Stamp;

/**
 * @author PigMess
 * @author Rolpege
 */

class Label extends Control
{
	public static var defaultSize:Float = 16;
	public static var defaultColor:Int = 0xff33cc;
	public static var defaultBackgroundColor:Int = 0x202020;
	public static var defaultBackground:Bool = false;
	
	public function new(text:String = "", x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0, ?align:TextFormatAlign)
	{
		_format = new TextFormat("default", Label.defaultSize, Label.defaultColor);
		
		if (align == null)
		{
			if (width == 0)
				_format.align = TextFormatAlign.LEFT;
			else
				_format.align = TextFormatAlign.CENTER;
		}
		else _format.align = align;
		
		_textField = new TextField();
		this.text = text;
		_textField.selectable = false;
		_textField.embedFonts = true;
		if (width != 0) _textField.width = width;
		if (height != 0) _textField.height = height;
		_textField.backgroundColor = Label.defaultBackgroundColor;
		_textField.background = Label.defaultBackground;
		_textField.maxChars = 0;
		_textField.useRichTextClipboard = true;
		_textField.wordWrap = false;
		_textField.multiline = false;
		_textField.x = x;
		_textField.y = y;
		
		if (width == 0) width = Std.int(_textField.textWidth + 4);
		if (height == 0) height = Std.int(_textField.textHeight + 4);
		
		super(x, y, width, height);
		
		_textField.width = width; // have to reset the width so everything shows...
		_renderRect = new Rectangle(0, 0, width, height);
		_textBuffer = new BitmapData(width, height, true, 0x00000000);
		graphic = new Stamp(_textBuffer);
	}
	
	override public function render()
	{
		super.render();
		
		_textBuffer.fillRect(_renderRect, _textField.background ? _textField.backgroundColor : 0x00000000);
		_textBuffer.draw(_textField);
	}
	
	public var text(get_text, set_text):String;
	private function get_text():String { return _textField.text; }
	private function set_text(value:String):String {
		var color = _textField.textColor;
		_textField.text = value;
		_textField.setTextFormat(_format);
		_textField.textColor = color;
		return value;
	}
	
	public var color(get_color, set_color):Int;
	private function get_color():Int { return _textField.textColor; }
	private function set_color(value:Int):Int {
		_textField.textColor = value;
		return value;
	}
	
	public var backgroundColor(get_backgroundColor, set_backgroundColor):Int;
	private function get_backgroundColor():Int { return _textField.backgroundColor; }
	private function set_backgroundColor(value:Int):Int {
		_textField.backgroundColor = value;
		return value;
	}
	
	public var length(get_length, null):Int;
	private function get_length():Int { return _textField.length; }
	
	public var size(get_size, set_size):Dynamic;
	private function get_size():Dynamic { return _textField.defaultTextFormat.size; }
	private function set_size(value:Dynamic):Dynamic {
		_textField.defaultTextFormat.size = value;
		return value;
	}
	
	public var font(get_font, set_font):String;
	private function get_font():String { return _textField.defaultTextFormat.font; }
	private function set_font(value:String):String {
		_textField.defaultTextFormat.font = value;
		return value;
	}
	
	public var background(get_background, set_background):Bool;
	private function get_background():Bool { return _textField.background; }
	private function set_background(value:Bool):Bool {
		_textField.background = value;
		return value;
	}

	private var _textField:TextField;
	private var _renderRect:Rectangle;
	private var _textBuffer:BitmapData;
	private var _format:TextFormat;
}
