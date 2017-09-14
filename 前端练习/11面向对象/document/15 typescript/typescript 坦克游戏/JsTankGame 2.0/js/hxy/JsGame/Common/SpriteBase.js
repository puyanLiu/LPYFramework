var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var Common;
        (function (Common) {
            var SpriteBase = (function () {
                function SpriteBase(imagePathes, width, height, manager) {
                    this._manager = manager;
                    this._speed = 0;
                    this._maxRight = 2000;
                    this._maxBottom = 1000;
                    this._maxLeft = 0;
                    this._maxTop = 0;
                    this._direction = 1 /* Up */;
                    this._imagesPathes = imagePathes;
                    //construct a div
                    this._div = document.createElement("div");
                    this._div.style.position = "absolute";
                    this._div.style.overflow = "hidden";
                    this.isVisible = true;
                    this._rect = new Common.Rectangle(0, 0, width, height);
                    this.setPos(0, 0);
                    this.setSize(width, height);
                    //construct a img
                    this._img = document.createElement("img");
                    this._img.src = imagePathes[0];
                    this._img.style.width = "100%";
                    this._img.style.height = "100%";
                    this._div.appendChild(this._img);
                }
                Object.defineProperty(SpriteBase.prototype, "collisionType", {
                    get: function () {
                        throw new Error();
                    },
                    enumerable: true,
                    configurable: true
                });
                SpriteBase.prototype.OnBoundary = function (direction) {
                    //do nothing(vitual method)
                };
                SpriteBase.prototype.OnCollided = function (targetRect, targetCollisionType, isInitiative) {
                    //do nothing(vitual method)
                };
                Object.defineProperty(SpriteBase.prototype, "manager", {
                    get: function () {
                        return this._manager;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "images", {
                    get: function () {
                        return this._imagesPathes;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "imageIndex", {
                    get: function () {
                        for (var i = 0; i < this._imagesPathes.length; i++) {
                            if (this._imagesPathes[i] == this._img.src)
                                return i;
                        }
                    },
                    set: function (value) {
                        this._img.src = this._imagesPathes[value];
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "div", {
                    get: function () {
                        return this._div;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "x", {
                    get: function () {
                        return this._rect.x;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "y", {
                    get: function () {
                        return this._rect.y;
                    },
                    enumerable: true,
                    configurable: true
                });
                SpriteBase.prototype.setPos = function (x, y) {
                    this._rect.x = x;
                    this._rect.y = y;
                    this._div.style.left = x + "px";
                    this._div.style.top = y + "px";
                };
                Object.defineProperty(SpriteBase.prototype, "width", {
                    get: function () {
                        return this._rect.width;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "height", {
                    get: function () {
                        return this._rect.height;
                    },
                    enumerable: true,
                    configurable: true
                });
                SpriteBase.prototype.setSize = function (width, height) {
                    this._rect.width = width;
                    this._rect.height = height;
                    this._div.style.width = width + "px";
                    this._div.style.height = height + "px";
                };
                Object.defineProperty(SpriteBase.prototype, "direction", {
                    get: function () {
                        return this._direction;
                    },
                    set: function (value) {
                        this._direction = value;
                        this.onDirectionChanged(value);
                    },
                    enumerable: true,
                    configurable: true
                });
                SpriteBase.prototype.onDirectionChanged = function (value) {
                };
                Object.defineProperty(SpriteBase.prototype, "maxLeft", {
                    get: function () {
                        return this._maxLeft;
                    },
                    set: function (value) {
                        this._maxLeft = value;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "maxRight", {
                    get: function () {
                        return this._maxRight;
                    },
                    set: function (value) {
                        this._maxRight = value;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "maxTop", {
                    get: function () {
                        return this._maxTop;
                    },
                    set: function (value) {
                        this._maxTop = value;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "maxBottom", {
                    get: function () {
                        return this._maxBottom;
                    },
                    set: function (value) {
                        this._maxBottom = value;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "isVisible", {
                    get: function () {
                        return this._div.style.display != "none";
                    },
                    set: function (value) {
                        this._div.style.display = value ? "block" : "none";
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "isActive", {
                    get: function () {
                        return this._isActive;
                    },
                    set: function (value) {
                        this._isActive = value;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "speed", {
                    get: function () {
                        return this._speed;
                    },
                    set: function (value) {
                        this._speed = value;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(SpriteBase.prototype, "rectangle", {
                    get: function () {
                        return this._rect;
                    },
                    enumerable: true,
                    configurable: true
                });
                SpriteBase.prototype.Move = function () {
                    //update position
                    if (this.isActive) {
                        var x = this.x, y = this.y;
                        switch (this._direction) {
                            case 4 /* Left */:
                                x -= this._speed;
                                if (x < this._maxLeft - 1) {
                                    x = this._maxLeft;
                                    this.OnBoundary(4 /* Left */);
                                }
                                break;
                            case 8 /* Right */:
                                x += this._speed;
                                if (x > this._maxRight - 1) {
                                    x = this._maxRight - 1;
                                    this.OnBoundary(8 /* Right */);
                                }
                                break;
                            case 1 /* Up */:
                                y -= this._speed;
                                if (y < this._maxTop - 1) {
                                    y = this._maxTop;
                                    this.OnBoundary(1 /* Up */);
                                }
                                break;
                            case 2 /* Down */:
                                y += this._speed;
                                if (y > this._maxBottom - 1) {
                                    y = this._maxBottom - 1;
                                    this.OnBoundary(2 /* Down */);
                                }
                                break;
                        }
                        this.setPos(x, y);
                    }
                };
                SpriteBase.prototype.GoBack = function (pixels) {
                    //update position
                    if (this.isActive) {
                        var dir = this.direction;
                        var x = this.x, y = this.y;
                        switch (dir) {
                            case 4 /* Left */:
                                x += pixels;
                                break;
                            case 8 /* Right */:
                                x -= pixels;
                                break;
                            case 1 /* Up */:
                                y += pixels;
                                break;
                            case 2 /* Down */:
                                y -= pixels;
                                break;
                        }
                        this.setPos(x, y);
                    }
                };
                SpriteBase.prototype.FarAwayFrom = function (targetRect) {
                    while (this.IsCollided(targetRect)) {
                        this.GoBack(1);
                    }
                };
                //IsCollided(target: SpriteBase) {
                //    if (!this.isVisible || !target.isVisible) return false;
                //    return this.myRectangle.IsIntersects(target.myRectangle);
                //}
                //IsCollidedRect(target: Rectangle) {
                //    if (!this.isVisible) return false;
                //    return this.myRectangle.IsIntersects(target);
                //}
                SpriteBase.prototype.IsCollided = function (target) {
                    if (!this.isVisible)
                        return false;
                    //target is a SpriteBase
                    //http://www.jb51.net/article/21109.htm
                    //http://segmentfault.net/q/1010000000669230
                    if (target instanceof SpriteBase) {
                        if (!target.isVisible)
                            return false;
                        return this._rect.IsIntersects(target._rect);
                    }
                    else if (target instanceof Common.Rectangle) {
                        return this._rect.IsIntersects(target);
                    }
                };
                SpriteBase.prototype.ChangeARandomDirection = function () {
                    var random = Math.random() * 4;
                    if (random <= 1) {
                        this.direction = 1 /* Up */;
                    }
                    else if (random <= 2) {
                        this.direction = 8 /* Right */;
                    }
                    else if (random <= 3) {
                        this.direction = 2 /* Down */;
                    }
                    else if (random <= 4) {
                        this.direction = 4 /* Left */;
                    }
                };
                return SpriteBase;
            })();
            Common.SpriteBase = SpriteBase;
        })(Common = JsGame.Common || (JsGame.Common = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=SpriteBase.js.map