package com.haxepunk.ui;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import flash.events.MouseEvent;
import flash.display.BitmapData;

class Window extends Entity
{	
	public function new (?skin:BitmapData)
	{
		super();
		
		if (skin != null) Window.skin = skin;
	}
	
	override public function added ()
	{
		super.added();
		
		if (HXP.stage != null) HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	override public function removed ()
	{
		super.removed();
		
		if(HXP.stage != null) HXP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	override public function update ()
	{
		super.update();
		
		var e = HXP.scene.collidePoint("ui_control", Input.mouseX+HXP.camera.x, Input.mouseY+HXP.camera.y);
		if (e != null)
		{
			var c = cast(e, Control);
			
			if (!c.enabled) return;
			
			if(Input.mouseDown) c.mouseDown();
			else
			{
				c.mouseEnter();
				if (this.lastHover != null && this.lastHover != c) lastHover.mouseLeave();
				
				this.lastHover = c;
			}			
		}
		else if (this.lastHover != null) { lastHover.mouseLeave(); lastHover = null; }
	}
	
	public function onMouseUp(me:MouseEvent = null)
	{
		var e = HXP.scene.collidePoint("ui_control", Input.mouseX, Input.mouseY);
		if (e != null)
		{
			var c = cast(e, Control);
			if (!c.enabled || !Input.mouseReleased) return;
			c.click(c);
		}
	}
	
	public function add(c:Control):Control
	{
		return this.scene.add(c);
	}
	
	public function remove(c:Control):Control
	{
		return this.scene.remove(c);
	}
	
	@:isVar public static var skin(get_skin, set_skin):BitmapData;
	static function get_skin() 
	{
		if (skin != null) 
			return skin;
		else
			return skin = openfl.Assets.getBitmapData("gfx/ui/defaultSkin.png");
	}
	static function set_skin(s) 
	{
		return skin = s;
	}
	
	private var lastHover:Control;
}