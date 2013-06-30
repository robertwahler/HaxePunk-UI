package com.haxepunk.ui;

import com.haxepunk.Entity;

/**
 * Base class for all controls.
 *
 * @author PigMess
 * @author AClockWorkLemon
 * @author Rolpege
 * @author Valentin LEMIERE
 */
class Control extends Entity
{
	/**
	 * If the control is enabled, ie. can we interact with it.
	 */
	public var enabled(default, set_enabled):Bool = true;
	function set_enabled (v:Bool):Bool
	{
		if (v) 
			this.graphic = this.normal;
		else 
			this.graphic = this.inactive;
		
		return this.enabled = v;
	}
	/**
	 * Graphic of the control when the mouse is pressing it and it's active.
	 */		
	public var down:Graphic;
	/**
	 * Graphic of the control when the mouse overs it and it's active.
	 */		
	public var hover:Graphic;
	/**
	 * Graphic of the control when inactive.
	 */
	public var inactive:Graphic;
	/**
	 * Graphic of the control when active and not pressed nor overed.
	 */	
	public var normal:Graphic;
	
	/** 
	 * Constructor.
	 *
	 * @param	x		Position of the control on the X axis.
	 * @param	y		Position of the control on the Y axis.
	 * @param	width	Width of the control.
	 * @param 	height	Height of the control.
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0) 
	{
		super(x, y);
		
		this.width = width;
		this.height = height;		
		
		// Used to detect mouse actions.
		this.type = "ui_control";
		
		setHitbox(this.width, this.height);
	}
	
	/**
	 * Init the x and y position of the control.
	 */
	public override function added ()
	{
		super.added();
		
		this.screenX = x;
		this.screenY = y;
	}
	
	/**
	 * The control was cliked.
	 *
	 * @param	c	The control clicked.
	 */
	public function click (c:Control)
	{
		if (this.onClick != null) 
			this.onClick(c);
	}
	
	/**
	 * The mouse is on the control.
	 *
	 * @param	c	The control bellow the mouse.
	 */
	public function mouseEnter (c:Control)
	{
		this.graphic = this.hover;
		
		if(this.onHover != null) 
			this.onHover(c);
	}
	
	/**
	 * The mouse button is clicked, but not yet released.
	 */
	public function mouseDown ()
	{
		this.graphic = this.down;
	}	
	
	/**
	 * The mouse leaved the control.
	 */
	public function mouseLeave ()
	{
		if (this.enabled)
			this.graphic = this.normal;
	}
	
	/**
	 * This function will be called when the button is pressed.
	 * You can change the function pointed by onClick.
	 */		
	public dynamic function onClick (c:Control) { }
	
	/**
	 * This function will be called when the mouse overs the button. 
	 * You can change the function pointed by onHover.
	 */		
	public dynamic function onHover (c:Control) { }

	/**
	 * Replace the control if the camera moved.
	 */
	override public function update ()
	{
		this.x = this.screenX + HXP.camera.x;
		this.y = this.screenY + HXP.camera.y;
		
		super.update();
	}

	/**
	 * Hold the x position on the screen of the control.
	 */
	private var screenX:Float;
	/**
	 * Hold the y position on the screen of the control.
	 */
	private var screenY:Float;
}
