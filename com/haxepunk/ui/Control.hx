package com.haxepunk.ui;

import com.haxepunk.Entity;
import flash.text.TextFormatAlign;

/**
 * @author PigMess
 * @author AClockWorkLemon
 * @author Rolpege
 */

class Control extends Entity
{
	/**
	 * Graphic of the button when active and not pressed nor overed.
	 */	
	public var normal:Graphic;
	/**
	 * Graphic of the button when the mouse overs it and it's active.
	 */		
	public var hover:Graphic;
	/**
	 * Graphic of the button when the mouse is pressing it and it's active.
	 */		
	public var down:Graphic;
	/**
	 * Graphic of the button when inactive.
	 */
	public var inactive:Graphic;
	
	public var enabled(default, set_enabled):Bool = true;
	function set_enabled (v:Bool):Bool
	{
		if (v) graphic = normal;
		else graphic = inactive;
		
		return this.enabled = v;
	}
	
	public function mouseDown ()
	{
		this.graphic = this.down;
	}
	
	public function mouseEnter ()
	{
		this.graphic = this.hover;
		if(this.onHover != null) this.onHover(this);
	}
	
	public function mouseLeave ()
	{
		if (this.enabled)
			this.graphic = this.normal;
	}
	
	/**
	 * This function will be called when the button is pressed. 
	 */		
	public dynamic function onClick(button:Control) { }
	
	/**
	 * This function will be called when the mouse overs the button. 
	 */		
	public dynamic function onHover(button:Control) { }

	/** class constructor
	 * @param x - position of the component on the X axis
	 * @param y - position of the component on the Y axis
	 * @param width - width of the component
	 * @param height - height of the component
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1) 
	{
		super(x, y);
		
		this.width = width;
		this.height = height;		
		
		this.type = "ui_control";
	}

	public override function added ()
	{
		super.added();
		
		absoluteX = x;
		absoluteY = y;
	}

	override public function update ()
	{
		x = absoluteX + HXP.camera.x;
		y = absoluteY + HXP.camera.y;
		
		super.update();
	}

	private var absoluteX:Float;
	private var absoluteY:Float;
}
