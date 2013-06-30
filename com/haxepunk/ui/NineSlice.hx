package com.haxepunk.ui;

import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.atlas.AtlasRegion;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * ...
 * @author AClockWorkLemon
 */
class NineSlice extends Graphic
{
	private var _skin:BitmapData;
	
	private var _topLeft:Image;
	private var _topCenter:Image;
	private var _topRight:Image;
	private var _centerLeft:Image;
	private var _centerCenter:Image;
	private var _centerRight:Image;
	private var _bottomLeft:Image;
	private var _bottomCenter:Image;
	private var _bottomRight:Image;
	
	private var _xScale:Float;
	private var _yScale:Float;
	
	private var _clipRect:Rectangle;
	
	private var width:Float;
	private var height:Float;
	
	/**
	 * Constructor. Initiates the class
	 * @param	width		Initial Width of the 9slice
	 * @param	height		Initial Height of the 9slice
	 * @param	clipRect	Rectangle of the area on the skin to use
	 * @param	gridSize	Grid spacing to use when chopping
	 * @param	skin		optional custom skin
	 */
	public function new(width:Float, height:Float, ?clipRect:Rectangle)
	{
		super();
		_skin = Window.skin;
		this.width = width;
		this.height = height;
		
		if (clipRect == null) clipRect = new Rectangle(0, 0, 1, 1);
		_clipRect = clipRect;
		
		_topLeft      = new Image(_skin, new Rectangle(clipRect.x                     , clipRect.y                      , clipRect.width, clipRect.height));
		_topCenter    = new Image(_skin, new Rectangle(clipRect.x + clipRect.width    , clipRect.y                      , clipRect.width, clipRect.height));
		_topRight     = new Image(_skin, new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y                      , clipRect.width, clipRect.height));
		_centerLeft   = new Image(_skin, new Rectangle(clipRect.x                     , clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_centerCenter = new Image(_skin, new Rectangle(clipRect.x + clipRect.width    , clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_centerRight  = new Image(_skin, new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_bottomLeft   = new Image(_skin, new Rectangle(clipRect.x                     , clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
		_bottomCenter = new Image(_skin, new Rectangle(clipRect.x + clipRect.width    , clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
		_bottomRight  = new Image(_skin, new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
	}
	
	/**
	 * Updates the Image. Make sure to set graphic = output image afterwards.
	 * @param	width	New width
	 * @param	height	New height
	 * @return
	 */
	override public function render(target:BitmapData, point:Point, camera:Point)
	{
		if (width  < _clipRect.width * 2)  width  = _clipRect.width * 2;
		if (height < _clipRect.height * 2) height = _clipRect.height * 2;
		
		_xScale = (width - _clipRect.width * 2) / _clipRect.width;
		_yScale = (height - _clipRect.height * 2) / _clipRect.height;
		
		#if !js
		_topCenter.scaleX = _xScale;
		_centerLeft.scaleY = _yScale;
		_centerCenter.scaleX = _xScale;
		_centerCenter.scaleY = _yScale;
		_centerRight.scaleY = _yScale;
		_bottomCenter.scaleX = _xScale;
		#end
		
		// half
		var hw = _clipRect.width / 2;
		var hh = _clipRect.height / 2;
		// half-scaled
		var hsw = (_clipRect.width + (_xScale * _clipRect.width)) / 2;
		var hsh = (_clipRect.height + (_yScale * _clipRect.height)) / 2;
		
		_topCenter.x    = hw;
		_topRight.x     = hsw;
		_centerLeft.y   = hh;
		_centerCenter.x = hw;
		_centerCenter.y = hh;
		_centerRight.x  = hsw;
		_centerRight.y  = hh;
		_bottomLeft.y   = hsh;
		_bottomCenter.x = hw;
		_bottomCenter.y = hsh;
		_bottomRight.x  = hsw;
		_bottomRight.y  = hsh;
		
		var tlp = new Point(_topLeft.x + point.x, _topLeft.y + point.y);
		var tcp = new Point(_topCenter.x + point.x, _topCenter.y + point.y);
		var trp = new Point(_topRight.x + point.x, _topRight.y + point.y);
		var clp = new Point(_centerLeft.x + point.x, _centerLeft.y + point.y);
		var ccp = new Point(_centerCenter.x + point.x, _centerCenter.y + point.y);
		var crp = new Point(_centerRight.x + point.x, _centerRight.y + point.y);
		var blp = new Point(_bottomLeft.x + point.x, _bottomLeft.y + point.y);
		var bcp = new Point(_bottomCenter.x + point.x, _bottomCenter.y + point.y);
		var brp = new Point(_bottomRight.x + point.x, _bottomRight.y + point.y);
		
		if (HXP.renderMode.has(RenderMode.HARDWARE))
		{
			// TODO
		}
		else
		{
			_topLeft.render(target, tlp, camera);
			
			#if js
			for (i in 0...Math.ceil(_xScale))
			{
			#end
				_topCenter.render(target, tcp, camera);
			#if js
				tcp.x += _topCenter.width;
			}
			#end
			
			_topRight.render(target, trp, camera);
			
			#if js
			for (i in 0...Math.ceil(_yScale))
			{
			#end
			_centerLeft.render(target, clp, camera);
			#if js
				clp.y += _centerLeft.height;
			}
			#end
			
			#if js
			for (i in 0...Math.ceil(_yScale))
			{
			for (j in 0...Math.ceil(_xScale))
			{
			#end
			_centerCenter.render(target, ccp, camera);
			#if js
				ccp.x += _centerLeft.width;
			}
				ccp.x = _centerCenter.x + point.x;
				ccp.y += _centerLeft.height;
			}
			#end
			
			#if js
			for (i in 0...Math.ceil(_yScale))
			{
			#end
			_centerRight.render(target, crp, camera);
			#if js
				crp.y += _centerRight.height;
			}
			#end		
			
			_bottomLeft.render(target, blp, camera);
			
			#if js
			for (i in 0...Math.ceil(_xScale))
			{
			#end
				_bottomCenter.render(target, bcp, camera);
			#if js
				bcp.x += _bottomCenter.width;
			}
			#end
			
			_bottomRight.render(target, brp, camera);
		}
	}
}