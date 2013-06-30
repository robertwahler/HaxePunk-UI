package com.haxepunk.ui;

import com.haxepunk.graphics.Text;

/**
 * A label control.
 *
 * @author Valentin LEMIERE
 */
class Label extends Control
{	 
	/**
	 * Should the label redirect it's click to it's parent.
	 */
	public var redirectClick:Bool = false;
	/**
	 * The label text height.
	 */
	public var textHeight(get_textHeight, never):Int;
	public function get_textHeight()
	{
		return this.text.height;
	}
	/**
	 * The parent object of the label.
	 */
	public var parent:Control;
	/**
	 * The label text width.
	 */
	public var textWidth(get_textWidth, never):Int;
	public function get_textWidth()
	{
		return this.text.width;
	}
	
	/**
	 * Constructor.
	 *
	 * @param	text			Test of the label.
	 * @param	x				Position of the label on the X axis.
	 * @param	y				Position of the label on the Y axis.
	 * @param	redirectClick	If clicking on the label click on it's parent control.
	 * @param	options			The options for the Text object.
	 */
	public function new (parent:Control, text:String = "", x:Float = 0, y:Float = 0, redirectClick:Bool = false, ?options:TextOptions)
	{
		this.text = new Text(text, 0, 0, options);
		this.graphic = this.text;
		
		super(x, y, this.textWidth, this.textHeight);
		
		this.parent = parent;
		this.redirectClick = redirectClick;
	}
	
	/**
	 * When clicked redirect click to parent if set to redirect.
	 */
	override function click (c:Control)
	{
		if (this.redirectClick && this.parent.enabled)
			this.parent.click(this.parent);
	}
	
	/** No mouse effect on label. */
	override public function mouseEnter (c:Control) { }
	/** No mouse effect on label. */
	override public function mouseDown () { }
	/** No mouse effect on label. */
	override public function mouseLeave () { }

	/**
	 * The Text object.
	 */
	private var text:Text;
}