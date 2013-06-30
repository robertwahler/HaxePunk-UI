package com.haxepunk.ui;

import flash.geom.Rectangle;

/**
 * A toggle button control.
 *
 * @author Valentin LEMIERE
 */
class ToggleButton extends Button
{
	/**
	 * Graphic of the control when the mouse overs it and it's active and checked.
	 */
	public var hoverDown:Graphic;
	/**
	 * Graphic of the control when inactive and checked.
	 */
	public var inactiveDown:Graphic;
	
	/**
	 * Constructor.
	 *
	 * @param	x			The position on the X axis.
	 * @param	y			The position on the Y axis.
	 * @param	text		The toggle button's text.
	 * @param	checked		If the toggle button is checked.
	 * @param	enabled		If the control is enabled.
	 */
	public function new(x:Float = 0, y:Float = 0, text:String = "Toggle", checked:Bool = false, enabled:Bool = true)
	{
		super(x, y, text, active);
		
		hoverDown = down;
		inactiveDown = new NineSlice(this.width, this.height, new Rectangle(72, 96, 8, 8));
		
		this.checked = checked;
		this.enabled = enabled;
	}
	
	/**
	 * Called when the button is enabled or disabled.
	 */
	override function set_enabled (v:Bool):Bool
	{
		if (v) 
			graphic = this.checked ? this.down : this.normal;
		else 
			graphic = this.checked ? this.inactiveDown : this.inactive;
		
		return this.enabled = v;
	}
	
	/**
	 * Called when the mouse enter the control.
	 */
	override public function mouseEnter (c:Control)
	{
		this.graphic = this.checked ? this.hoverDown : this.hover;
		
		if(this.onHover != null) 
			this.onHover(c);
	}
	
	/**
	 * Called when the mouse leave the control.
	 */
	override public function mouseLeave ()
	{
		if (this.enabled)
			this.graphic = this.checked ? this.down : this.normal;
	}
	
	/**
	 * Called when the control is clicked.
	 */
	override public function click (c:Control)
	{
		this.checked = !this.checked;
		super.click(c);
	}
	
	/**
	 * Is the control checked.
	 */
	private var checked(default, set_checked):Bool;
	function set_checked(b:Bool):Bool
	{
		this.checked = b;
		this.graphic = this.checked ? this.down : this.normal;
		
		return this.checked;
	}
	
}
