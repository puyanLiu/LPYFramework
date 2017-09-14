/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.Interface");

hxy.JsGame.Interface.ICollidable = function(element) 
{
    throw Error.notImplemented();
}

hxy.JsGame.Interface.ICollidable.prototype = 
{
    get_collisionType: function() 
    {
        throw Error.notImplemented();
    }
}
hxy.JsGame.Interface.ICollidable.registerInterface('hxy.JsGame.Interface.ICollidable');

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
