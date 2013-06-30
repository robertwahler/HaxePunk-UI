package com.haxepunk.ui;

import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;

/**
 * A checkbox control.
 *
 * @author Valentin LEMIERE
 */
class CheckBox extends ToggleButton
{	
	/**
	 * Constructor.
	 *
	 * @param	x					The position on the X axis.
	 * @param	y					The position on the Y axis.
	 * @param	text				The text to the associated label.
	 * @param	checked				If the checkbox is checked.
	 * @param	enabled				If the control is enabled.
	 * @param	redirectLabelClick	Should the label redirect it's clicks to the checkbox.
	 */
	public function new (x:Float = 0, y:Float = 0, text:String = "Checkbox", checked:Bool = false, enabled:Bool = true, redirectLabelClick:Bool = false)
	{
		super(x, y, text, checked, active);
		this.width = this.height = 16;
		
		this.label.redirectClick = redirectLabelClick;
		
		var skin = Window.skin;
		
		normal = new Image(skin, new Rectangle(0, 48, 16, 16));
		hover = new Image(skin, new Rectangle(16, 48, 16, 16));
		down = new Image(skin, new Rectangle(64, 48, 16, 16));
		hoverDown = new Image(skin, new Rectangle(80, 48, 16, 16));
		inactive = new Image(skin, new Rectangle(96, 0, 16, 16));
		inactiveDown = new Image(skin, new Rectangle(96, 32, 16, 16));
		
		this.enabled = enabled;
	}
	
	/**
	 * Add the checkbox's label.
	 *
	 * @param	x		The position on the X axis.
	 * @param	y		The position on the Y axis.
	 * @param	text	The text of the label.
	 */
	override private function addLabel (x:Float, y:Float, text:String)
	{
		this.label = new Label(this, text, x+24, y, true, {color:0});
	}
}