/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.Enum");

hxy.JsGame.Enum.Direction = function(element) {
    ///<summary>sprite's direction</summary>
    ///<field name="Up" type="Number" interger="true" static="true">Up</field>
    ///<field name="Down" type="Number" interger="true" static="true">Down</field>
    ///<field name="Left" type="Number" interger="true" static="true">Left</field>
    ///<field name="Right" type="Number" interger="true" static="true">Right</field>
    throw Error.notImplemented();
}

hxy.JsGame.Enum.Direction.prototype = 
{
    Up: 1,
    Down: 2,
    Left: 4,
    Right: 8
}

hxy.JsGame.Enum.Direction.registerEnum('hxy.JsGame.Enum.Direction');

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
