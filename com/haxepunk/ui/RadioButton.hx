package com.haxepunk.ui;

import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

class RadioButton extends ToggleButton
{
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Checkbox", id:String = "radio", checked:Bool = false, width:Int = 100, active:Bool = true)
	{
		_align = TextFormatAlign.LEFT;
		_button_name = id;
		addButton();
		
		super(x, y, text, width, 0, checked, active);
		this.width = this.height = 16;
		
		normal = new Image(_skin, new Rectangle(0, 64, 16, 16));
		hover = new Image(_skin, new Rectangle(16, 64, 16, 16));
		down = new Image(_skin, new Rectangle(32, 64, 16, 16));
		hoverDown = new Image(_skin, new Rectangle(48, 64, 16, 16));
		inactive = new Image(_skin, new Rectangle(64, 64, 16, 16));
		inactiveDown = new Image(_skin, new Rectangle(80, 64, 16, 16));
	}
	
	private function addButton()
	{
		var buttons:Array<RadioButton> = _buttons.get(_button_name);
		if (buttons == null)
		{
			buttons = new Array<RadioButton>();
			buttons.push(this);
			_buttons.set(_button_name, buttons);
		}
		else
		{
			buttons.push(this);
		}
	}
	
	override private function set_checked(value:Bool):Bool
	{
		if (value)
		{
			var buttons:Array<RadioButton> = _buttons.get(_button_name);
			var button:RadioButton;
			for (button in buttons)
			{
				if (button != this)
					button._checked = false;
			}
		}
		return super.set_checked(value);
	}
	
	override private function setX(value:Float):Float
	{
		label.x = value + width + padding;
		_x = value;
		return _x;
	}
	
	private var _button_name:String;
	private static var _buttons:Map<String, Array<RadioButton>> = new Map<String, Array<RadioButton>>();
	
}
