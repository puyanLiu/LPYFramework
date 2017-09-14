/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.Common");

hxy.JsGame.Common.Rectangle = function(x, y, width, height) 
{
    this._x = x;
    this._y = y;
    this._width = width;
    this._height = height;
}

hxy.JsGame.Common.Rectangle.prototype = 
{
    get_x: function()
    {
        return this._x;
    },
    set_x: function(value)
    {
        this._x = value;
    },
    get_y: function()
    {
        return this._y;
    },
    set_y: function(value)
    {
        this._y = value;
    },
    get_width: function()
    {
        return this._width;
    },
    set_width: function(value)
    {
        this._width = value;
    },
    get_height: function()
    {
        return this._height;
    },
    set_height: function(value)
    {
        this._height = value;
    },
    IsIntersects: function(targetRectangle)
    {
        var cX = (this._x + this._width / 2) - (targetRectangle._x + targetRectangle._width / 2);
        var cW = (this._width + targetRectangle._width) / 2;
        var cY = (this._y + this._height / 2) - (targetRectangle._y + targetRectangle._height / 2);
        var cH = (this._height + targetRectangle._height) / 2;
        if((Math.abs(cX) < Math.abs(cW)) && (Math.abs(cY) < Math.abs(cH))){
            return true;
        }
        return false;
    }
}
hxy.JsGame.Common.Rectangle.registerClass('hxy.JsGame.Common.Rectangle');

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
