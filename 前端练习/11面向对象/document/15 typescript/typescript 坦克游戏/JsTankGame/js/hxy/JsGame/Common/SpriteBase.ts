module hxy.JsGame.Common {
    export interface BundaryEventHandler {
        (direction: Enum.Direction): void;
    }
    /**
    * 精灵类
    */
    export class SpriteBase {
        private _speed = 0;
        private _maxLeft = 0;
        private _maxTop = 0;
        private _maxRight = 2000;
        private _maxBottom = 1000;
        private _direction = Enum.Direction.Up;

        private _imagesPathes: string[];
        private _imageIndex = 0;
        private _imageWidth: number;
        private _imageHeight: number;

        private _isActive: boolean;

        private _div: HTMLElement;
        private _img: HTMLImageElement;

        private _rect: Rectangle;

        private _bundaryHandlers = new EventList<BundaryEventHandler>();

        constructor(imagePathes: string[], width: number, height: number) {
            this._imagesPathes = imagePathes;
        
            //construct a div
            this._div = document.createElement("div");
            this._div.style.position = "absolute";
            this._div.style.overflow = "hidden";
            this.isVisible = true;
            this._rect = new Rectangle(0, 0, width, height);
            this.setPos(0, 0);
            this.setSize(width, height);
            //construct a img
            this._img = document.createElement("img");
            this._img.style.width = "100%";
            this._img.style.height = "100%";
            this._div.appendChild(this._img);

            this.imageIndex = 0;
        }

        protected onBoundary(direction: Enum.Direction) {
            this._bundaryHandlers.fire(t => t(direction));
        }
        addOnBoundary(handler: BundaryEventHandler) {
            this._bundaryHandlers.add(handler);
        }
        
        get images() {
            return this._imagesPathes;
        }
        get imageIndex() {
            return this._imageIndex;
        }
        set imageIndex(value) {
            this._imageIndex = value;
            this._img.src = this._imagesPathes[value];
        }
        get div() {
            return this._div;
        }
        get x() {
            return this._rect.x;
        }
        get y() {
            return this._rect.y;
        }
        setPos(x: number, y: number) {
            this._rect.x = x;
            this._rect.y = y;
            this._div.style.left = x + "px";
            this._div.style.top = y + "px";
        }
        get width() {
            return this._rect.width;
        }
        get height() {
            return this._rect.height;
        }
        /**
          * 设置当前精灵的大小。
          * @param width 设置精灵的宽度。
          * @param height 设置精灵的高度。
          */
        setSize(width, height) {
            this._rect.width = width;
            this._rect.height = height;
            this._div.style.width = width + "px";
            this._div.style.height = height + "px";
        }
        get direction() {
            return this._direction;
        }
        set direction(value: Enum.Direction) {
            this._direction = value;
            this.onDirectionChanged(value);
        }
        protected onDirectionChanged(value: Enum.Direction) {
        }
        get maxLeft() {
            return this._maxLeft;
        }
        set maxLeft(value) {
            this._maxLeft = value;
        }
        get maxRight() {
            return this._maxRight;
        }
        set maxRight(value) {
            this._maxRight = value;
        }
        get maxTop() {
            return this._maxTop;
        }
        set maxTop(value) {
            this._maxTop = value;
        }
        get maxBottom() {
            return this._maxBottom;
        }
        set maxBottom(value) {
            this._maxBottom = value;
        }
        get isVisible(): boolean {
            return this._div.style.display != "none";
        }
        set isVisible(value: boolean) {
            this._div.style.display = value ? "block" : "none";
        }
        get isActive() {
            return this._isActive;
        }
        set isActive(value) {
            this._isActive = value;
        }
        get speed() {
            return this._speed;
        }
        set speed(value) {
            this._speed = value;
        }
        get rectangle() {
            return this._rect;
        }

        move() {
            //update position
            if (this.isActive) {
                var x = this.x, y = this.y;
                //change x and y
                switch (this._direction) {
                    case Enum.Direction.Left:
                        x -= this._speed;
                        if (x < this._maxLeft - 1) {
                            x = this._maxLeft;
                            this.onBoundary(Enum.Direction.Left);
                        }
                        break;
                    case Enum.Direction.Right:
                        x += this._speed;
                        if (x > this._maxRight - 1) {
                            x = this._maxRight - 1;
                            this.onBoundary(Enum.Direction.Right);
                        }
                        break;
                    case Enum.Direction.Up:
                        y -= this._speed;
                        if (y < this._maxTop - 1) {
                            y = this._maxTop;
                            this.onBoundary(Enum.Direction.Up);
                        }
                        break;
                    case Enum.Direction.Down:
                        y += this._speed;
                        if (y > this._maxBottom - 1) {
                            y = this._maxBottom - 1;
                            this.onBoundary(Enum.Direction.Down);
                        }
                        break;
                }
                this.setPos(x, y);
            }
        }

        goBack(pixels: number) {
            //update position
            if (this.isActive) {
                var dir = this.direction;
                var x = this.x, y = this.y;
                //change x and y
                switch (dir) {
                    case Enum.Direction.Left:
                        x += pixels;
                        break;
                    case Enum.Direction.Right:
                        x -= pixels;
                        break;
                    case Enum.Direction.Up:
                        y += pixels;
                        break;
                    case Enum.Direction.Down:
                        y -= pixels;
                        break;
                }
                this.setPos(x, y);
            }
        }

        farAwayFrom(targetRect: Rectangle) {
            while (this.isCollided(targetRect)) {
                this.goBack(1);
            }
        }

        //IsCollided(target: SpriteBase) {
        //    if (!this.isVisible || !target.isVisible) return false;

        //    return this.myRectangle.IsIntersects(target.myRectangle);
        //}
        //IsCollidedRect(target: Rectangle) {
        //    if (!this.isVisible) return false;

        //    return this.myRectangle.IsIntersects(target);
        //}
        isCollided(target: SpriteBase|Rectangle) {
            if (!this.isVisible) return false;

            //target is a SpriteBase
            //http://www.jb51.net/article/21109.htm
            //http://segmentfault.net/q/1010000000669230
            if (target instanceof SpriteBase) {
                if (!target.isVisible) return false;

                return this._rect.isIntersects(target._rect);
            }
            else if (target instanceof Rectangle) {
                return this._rect.isIntersects(target);
            }
        }

        changeARandomDirection() {
            var random = Math.random() * 4;
            if (random <= 1) {
                this.direction = Enum.Direction.Up;
            }
            else if (random <= 2) {
                this.direction = Enum.Direction.Right;
            }
            else if (random <= 3) {
                this.direction = Enum.Direction.Down;
            }
            else if (random <= 4) {
                this.direction = Enum.Direction.Left;
            }
        }
    }
}