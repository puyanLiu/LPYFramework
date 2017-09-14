var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var Common;
        (function (Common) {
            var Rectangle = (function () {
                function Rectangle(x, y, width, height) {
                    this._x = x;
                    this._y = y;
                    this._width = width;
                    this._height = height;
                }
                Object.defineProperty(Rectangle.prototype, "x", {
                    get: function () {
                        return this._x;
                    },
                    set: function (v) {
                        this._x = v;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(Rectangle.prototype, "y", {
                    get: function () {
                        return this._y;
                    },
                    set: function (v) {
                        this._y = v;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(Rectangle.prototype, "width", {
                    get: function () {
                        return this._width;
                    },
                    set: function (v) {
                        this._width = v;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(Rectangle.prototype, "height", {
                    get: function () {
                        return this._height;
                    },
                    set: function (v) {
                        this._height = v;
                    },
                    enumerable: true,
                    configurable: true
                });
                Rectangle.prototype.IsIntersects = function (targetRectangle) {
                    var cX = (this._x + this._width / 2) - (targetRectangle._x + targetRectangle._width / 2);
                    var cW = (this._width + targetRectangle._width) / 2;
                    var cY = (this._y + this._height / 2) - (targetRectangle._y + targetRectangle._height / 2);
                    var cH = (this._height + targetRectangle._height) / 2;
                    if ((Math.abs(cX) < Math.abs(cW)) && (Math.abs(cY) < Math.abs(cH))) {
                        return true;
                    }
                    return false;
                };
                return Rectangle;
            })();
            Common.Rectangle = Rectangle;
        })(Common = JsGame.Common || (JsGame.Common = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=Rectangle.js.map