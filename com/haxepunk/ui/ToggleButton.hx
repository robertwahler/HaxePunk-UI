package com.haxepunk.ui;

import com.haxepunk.Graphic;
import com.haxepunk.utils.Input;
import flash.geom.Rectangle;

class ToggleButton extends Button
{
	public var hoverDown:Graphic;
	public var inactiveDown:Graphic;
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Toggle", checked:Bool = false, enabled:Bool = true)
	{
		super(x, y, text, active);
		hoverDown = down;
		inactiveDown = new NineSlice(this.width, this.height, new Rectangle(72, 96, 8, 8));
		this.checked = checked;
		this.enabled = enabled;
	}
	
	override function set_enabled (v:Bool):Bool
	{
		if (v) graphic = this.checked ? this.down : this.normal;
		else graphic = this.checked ? inactiveDown : inactive;
		
		return this.enabled = v;
	}
	
	override public function mouseEnter ()
	{
		this.graphic = this.checked ? hoverDown : this.hover;
		if(this.onHover != null) this.onHover(this);
	}
	
	override public function mouseLeave ()
	{
		if (this.enabled)
			this.graphic = this.checked ? this.down : this.normal;
	}
	
	override public function click (c:Control)
	{
		this.checked = !this.checked;
		super.click(c);
	}
	
	private var checked:Bool;
	
}
