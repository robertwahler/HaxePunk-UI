package com.haxepunk.ui;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import flash.events.MouseEvent;
import flash.display.BitmapData;

/**
 * Main UI class, used to add/remove controls and to dispatch events.
 *
 * @author Valentin LEMIERE
 */
class Window extends Entity
{
	/**
	 * The skin used to render all controls.
	 */
	@:isVar public static var skin(get_skin, set_skin):BitmapData;
	static function get_skin() 
	{
		if (skin != null)
			return skin;
		else
			return skin = openfl.Assets.getBitmapData("gfx/ui/defaultSkin.png");
	}
	static function set_skin(s) { return skin = s; }
		
	/**
	 * Constructor.
	 *
	 * @param	skin	The skin to use for all controls.
	 */
	public function new (?skin:BitmapData)
	{
		super();
		
		if (skin != null)
			Window.skin = skin;
	}
	
	/**
	 * Add a control to the scene.
	 *
	 * @param	c	The control to add.
	 */
	public function add <C:Control>(c:C):C
	{
		return this.scene.add(c);
	}
	
	/**
	 * Add multiple controls from the scene.
	 *
	 * @param	...list		Several controls (as arguments) or an Array/Vector of controls.
	 */
	public function addList <C:Control>(list:Iterable<C>)
	{
		for (c in list)
			this.add(c);
	}
	
	/**
	 * Add the mouse event listener.
	 */
	override public function added ()
	{
		super.added();
		
		if (HXP.stage != null) 
			HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	/**
	 * Called when a mouse click was detected, call the click
	 * function of the clicked control.
	 *
	 * @param	me	The mouse event.
	 */
	public function onMouseUp(me:MouseEvent = null)
	{
		// Get the entity bellow the mouse.
		var e = HXP.scene.collidePoint("ui_control", Input.mouseX, Input.mouseY);
		if (e != null)
		{
			var c = cast(e, Control);
			
			// If the control is disabled or the mouse click isn't release: do nothing.
			if (!c.enabled || !Input.mouseReleased) 
				return;
				
			c.click(c);
		}
	}
	
	/**
	 * Remove the control from the scene.
	 *
	 * @param	c	The control to remove.
	 */
	public function remove <C:Control>(c:C):C
	{
		return this.scene.remove(c);
	}
	
	/**
	 * Remove multiple controls from the scene.
	 *
	 * @param	...list		Several controls (as arguments) or an Array/Vector of controls.
	 */
	public function removeList <C:Control>(list:Iterable<C>)
	{
		for (c in list)
			this.remove(c);
	}
	
	/**
	 * Remove the mouse event listener.
	 */
	override public function removed ()
	{
		super.removed();
		
		if(HXP.stage != null) 
			HXP.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
	}
	
	/**
	 * Update all controls.
	 */
	override public function update ()
	{
		super.update();
		
		// Get the entity below the mouse.
		var e = HXP.scene.collidePoint("ui_control", Input.mouseX+HXP.camera.x, Input.mouseY+HXP.camera.y);
		if (e != null)
		{
			var c = cast(e, Control);
			
			// If the control is disabled do nothing.
			if (!c.enabled) 
				return;
			
			if(Input.mouseDown) 
				c.mouseDown();
			else
			{
				c.mouseEnter(c);
				
				// If the control bellow the mouse has changed then the mouse has leave to previous on.
				if (this.lastHover != null && this.lastHover != c) 
					this.lastHover.mouseLeave();
				
				this.lastHover = c;
			}			
		}
		else if (this.lastHover != null) 
		{
			this.lastHover.mouseLeave(); 
			this.lastHover = null; 
		}
	}	
	
	/**
	 * The last hovered control.
	 */
	private var lastHover:Control;	 
}