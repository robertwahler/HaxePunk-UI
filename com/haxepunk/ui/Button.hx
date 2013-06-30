package com.haxepunk.ui;

import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

/**
 * @author Rolpege
 * @coauthor PigMess
 */

class Button extends Control
{	
	/**
	 * The button's label 
	 */		
	public var label:Entity;
	
	/**
	 * Constructor.
	 *  
	 * @param x			X coordinate of the button.
	 * @param y			Y coordinate of the button.
	 * @param width		Width of the button's hitbox.
	 * @param height	Height of the button's hitbox.
	 * @param text		Text of the button
	 * @param callback	The function that will be called when the button is pressed.
	 * @param active	Whether the button is active or not.
	 */
	public function new(x:Float = 0, y:Float = 0, text:String = "Button", enabled:Bool = true)
	{
		var t = new Text(text, 4, 4, {color:0});
		label = new Entity(x, y, t);
		HXP.scene.add(label);
		
		super(x, y, t.width+8, t.height+8);
								
		normal = new NineSlice(this.width, this.height, new Rectangle(0, 96, 8, 8));
		hover = new NineSlice(this.width, this.height, new Rectangle(24, 96, 8, 8));
		down = new NineSlice(this.width, this.height, new Rectangle(48, 96, 8, 8));
		inactive = new NineSlice(this.width, this.height, new Rectangle(96, 96, 8, 8));
		
		this.enabled = enabled;
		
		setHitbox(this.width, this.height);	
	}
	
	override public function added ()
	{
		super.added();
		HXP.scene.bringForward(label);
	}
	
	override public function update ()
	{
		super.update();
		
		label.x = this.x;
		label.y = this.y;
	}
	
	override public function removed ()
	{
		super.removed();
		HXP.scene.remove(label);
	}
}
