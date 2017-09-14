/// <reference name="MicrosoftAjax.js"/>
/// <reference path="Direction.js" />

Type.registerNamespace("hxy.JsGame.Enum");

hxy.JsGame.Enum.CollisionType = function(element){
    ///<summary>descripe a type of collision</summary>
    ///<field name="PlayerTank" type="Number" interger="true" static="true">PlayerTank</field>
    ///<field name="EnemyTank" type="Number" interger="true" static="true">EnemyTank</field>
    ///<field name="PlayerShell" type="Number" interger="true" static="true">PlayerShell</field>
    ///<field name="EnemyShell" type="Number" interger="true" static="true">EnemyShell</field>
    ///<field name="Explosion" type="Number" interger="true" static="true">Explosion</field>
    ///<field name="Barrier" type="Number" interger="true" static="true">Barrier</field>
    ///<field name="Grass" type="Number" interger="true" static="true">Grass</field>
    throw Error.notImplemented();
}

hxy.JsGame.Enum.CollisionType.prototype = {
    PlayerTank: 1,
    EnemyTank: 2,
    PlayerShell: 4,
    EnemyShell: 8,
    Explosion: 16,
    Barrier: 32,
    Grass: 64
}
hxy.JsGame.Enum.CollisionType.registerEnum('hxy.JsGame.Enum.CollisionType');

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();