package com.haxepunk.ui;

import com.haxepunk.HXP;
import flash.geom.Rectangle;

/**
 * A button control.
 *
 * @author Rolpege
 * @author PigMess
 * @author Valentin LEMIERE
 */
class Button extends Control
{	
	/**
	 * Constructor.
	 *  
	 * @param x			X coordinate of the button.
	 * @param y			Y coordinate of the button.
	 * @param text		Text of the button.
	 * @param enabled	Whether the button is enabled or not.
	 */
	public function new(x:Float = 0, y:Float = 0, text:String = "Button", enabled:Bool = true)
	{
		addLabel(x, y, text);
		HXP.scene.add(label);
		
		super(x, y, this.label.textWidth+8, this.label.textHeight+8);
								
		normal = new NineSlice(this.width, this.height, new Rectangle(0, 96, 8, 8));
		hover = new NineSlice(this.width, this.height, new Rectangle(24, 96, 8, 8));
		down = new NineSlice(this.width, this.height, new Rectangle(48, 96, 8, 8));
		inactive = new NineSlice(this.width, this.height, new Rectangle(96, 96, 8, 8));
		
		this.enabled = enabled;
	}
	
	/**
	 * Add a label to the button.
	 *
	 * @param	x		The position on the X axis.
	 * @param	y		The position on the Y axis.
	 * @param	text	The text of the label.
	 */
	private function addLabel (x:Float, y:Float, text:String)
	{
		this.label = new Label(this, text, x+6, y+4, true, {color:0});
	}
	
	/**
	 * Put the label in front of the button.
	 */
	override public function added ()
	{
		super.added();
		HXP.scene.bringForward(label);
	}
	
	/**
	 * When the button is removed also remove the label.
	 */
	override public function removed ()
	{
		super.removed();
		HXP.scene.remove(label);
	}
	
	/**
	 * Move the button's label to make it follow.
	 */
	override public function update ()
	{
		super.update();
		
		this.label.x = this.x;
		this.label.y = this.y;
	}
	
	/**
	 * The button's label 
	 */		
	private var label:Label;
}
