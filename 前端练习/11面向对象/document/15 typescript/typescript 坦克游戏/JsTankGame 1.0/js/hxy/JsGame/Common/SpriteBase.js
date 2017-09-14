/// <reference name="MicrosoftAjax.js"/>
/// <reference path="Rectangle.js" />
/// <reference path="ImagesManager.js" />
/// <reference path="../hxy.JsGame.Enum/Direction.js" />


Type.registerNamespace("hxy.JsGame.Common");

hxy.JsGame.Common.SpriteBase = function() {
    this._speed = null;
    this._maxLeft = null;
    this._maxTop = null;
    this._maxRight = null;
    this._maxBottom = null;
    this._direction = null;
    
    this._imagesPathes = null;
    this._imageWidth = null;
    this._imageHeight = null;
    
    this._isActive = null;
    
    this._manager = null;//sprites manager
    
    this._div = null;
    this._img = null;
}

hxy.JsGame.Common.SpriteBase.prototype = {
    OnBoundary: function(direction) {
        //do nothing(vitual method)
    },
    OnCollided: function(targetRect, targetCollisionType, isInitiative) {
        //do nothing(vitual method)
    },
    Initialize: function(imagePathes, width, height, manager) {
        this._manager = manager;
        this._speed = 0;
        this._maxRight = 2000;
        this._maxBottom = 1000;
        this._maxLeft = 0;
        this._maxTop = 0;
        this._direction = hxy.JsGame.Enum.Direction.Up;
        this._imagesPathes = imagePathes;
        
        //construct a div
        this._div = document.createElement("div");
        this._div.style.position = "absolute";
        this._div.style.overflow = "hidden";
        this.set_isVisible(true);
        this._div.style.pixelLeft = 0;
        this._div.style.pixelTop = 0;
        this._div.style.pixelWidth = width;
        this._div.style.pixelHeight = height;
        //construct a img
        this._img = document.createElement("img");
        this._img.src = imagePathes[0];
        this._img.style.width = "100%";
        this._img.style.height = "100%";
        this._div.appendChild(this._img);
    },
    Move: function(){// Move(); Move(dir);
        //update position
        if (this.get_isActive()) {
            var dir;
            if(arguments.length == 0){
                dir = this._direction;
            }
            else if(arguments.length == 1){
                dir = arguments[0];
            }
            var x = this.get_x(), y = this.get_y();
            //change x and y
            switch (dir) {
                case hxy.JsGame.Enum.Direction.Left:
                    x -= this._speed;
                    if (x < this._maxLeft - 1) {
                        x = this._maxLeft;
                        this.OnBoundary(hxy.JsGame.Enum.Direction.Left);
                    }
                break;
                case hxy.JsGame.Enum.Direction.Right:
                    x += this._speed;
                    if (x > this._maxRight - 1) {
                        x = this._maxRight - 1;
                        this.OnBoundary(hxy.JsGame.Enum.Direction.Right);
                    }
                break;
                case hxy.JsGame.Enum.Direction.Up:
                    y -= this._speed;
                    if (y < this._maxTop - 1) {
                        y = this._maxTop;
                        this.OnBoundary(hxy.JsGame.Enum.Direction.Up);
                    }
                break;
                case hxy.JsGame.Enum.Direction.Down:
                    y += this._speed;
                    if (y > this._maxBottom - 1) {
                        y = this._maxBottom - 1;
                        this.OnBoundary(hxy.JsGame.Enum.Direction.Down);
                    }
                break;
            }
            this.set_pos(x, y);
        }
    },
    GoBack: function(pixels){
        //update position
        if (this.get_isActive()) {
            var dir = this.get_direction();
            var x = this.get_x(), y = this.get_y();
            //change x and y
            switch (dir) {
                case hxy.JsGame.Enum.Direction.Left:
                    x += pixels;
                break;
                case hxy.JsGame.Enum.Direction.Right:
                    x -= pixels;
                break;
                case hxy.JsGame.Enum.Direction.Up:
                    y += pixels;
                break;
                case hxy.JsGame.Enum.Direction.Down:
                    y -= pixels;
                break;
            }
            this.set_pos(x, y);
        }
    },
    FarAwayFrom: function(targetRect){
        while (this.IsCollided(targetRect)) {
          this.GoBack(1);
        }
    },
    IsCollided: function(target){//overload: target:SpriteBase/Rectangle
        if(!this.get_isVisible())
            return false;
        //target is a SpriteBase
        if(target.get_isVisible !== undefined){
            if(!target.get_isVisible())
                return false;
            return this.get_myRectangle().IsIntersects(target.get_myRectangle());
        }
        else{//target is a Rectangle
            return this.get_myRectangle().IsIntersects(target);
        }
    },
    ChangeARandomDirection: function(){
        var random = Math.random() * 4;
        if(random <= 1){
            this.set_direction(hxy.JsGame.Enum.Direction.Up);
        }
        else if(random <= 2){
            this.set_direction(hxy.JsGame.Enum.Direction.Right);
        }
        else if(random <= 3){
            this.set_direction(hxy.JsGame.Enum.Direction.Down);
        }
        else if(random <= 4){
            this.set_direction(hxy.JsGame.Enum.Direction.Left);
        }
    },
    get_images: function(){
        return this._imagesPathes;
    },
    get_imageIndex: function(){
        for(var i = 0; i < this._imagesPathes.length; i++){
            if(this._imagesPathes[i] == this._img.src)
                return i;
        }
    },
    set_imageIndex: function(value){
        this._img.src = this._imagesPathes[value];
    },
    get_div: function(){
        return this._div;
    },
    get_x: function(){
        return this._div.style.pixelLeft;
    },
    get_y: function(){
        return this._div.style.pixelTop;
    },
    set_pos: function(x, y){
        this._div.style.pixelLeft = x;
        this._div.style.pixelTop = y;
    },
    get_width: function(){
        return this._div.style.pixelWidth;
    },
    get_height: function(){
        return this._div.style.pixelHeight;
    },
    set_size: function(width, height){
        this._div.style.pixelWidth = width;
        this._div.style.pixelHeight = height;
    },
    get_direction: function(){
        return this._direction;
    },
    set_direction: function(value){
        this._direction = value;
    },
    get_maxLeft: function(){
        return this._maxLeft;
    },
    set_maxLeft: function(value){
        this._maxLeft = value;
    },
    get_maxRight: function(){
        return this._maxRight;
    },
    set_maxRight: function(value){
        this._maxRight = value;
    },
    get_maxTop: function(){
        return this._maxTop;
    },
    set_maxTop: function(value){
        this._maxTop = value;
    },
    get_maxBottom: function(){
        return this._maxBottom;
    },
    set_maxBottom: function(value){
        this._maxBottom = value;
    },
    get_isVisible: function(){
        return this._div.style.display != "none";
    },
    set_isVisible: function(value){
        this._isVisible = value ? "block" : "none";
    },
    get_isActive: function(){
        return this._isActive;
    },
    set_isActive: function(value){
        this._isActive = value;
    },
    get_speed: function(){
        return this._speed;
    },
    set_speed: function(value){
        this._speed = value;
    },
    get_myRectangle: function(){
        var rect = new hxy.JsGame.Common.Rectangle(
            this.get_x(),
            this.get_y(),
            this.get_width(),
            this.get_height()
            );
        return rect;
    }
}
hxy.JsGame.Common.SpriteBase.registerClass('hxy.JsGame.Common.SpriteBase', null, hxy.JsGame.Interface.ICollidable);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
