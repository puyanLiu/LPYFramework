module hxy.JsGame.Common {
    export class Rectangle {
        private _x: number;
        private _y: number;
        private _width: number;
        private _height: number;

        constructor(x: number, y: number, width: number, height: number) {
            this._x = x;
            this._y = y;
            this._width = width;
            this._height = height;
        }

        get x(): number {
            return this._x;
        }
        set x(v: number) {
            this._x = v;
        }
        get y(): number {
            return this._y;
        }
        set y(v: number) {
            this._y = v;
        }
        get width(): number {
            return this._width;
        }
        set width(v: number) {
            this._width = v;
        }
        get height(): number {
            return this._height;
        }
        set height(v: number) {
            this._height = v;
        }

        IsIntersects(targetRectangle: Rectangle) : boolean {
            var cX = (this._x + this._width / 2) - (targetRectangle._x + targetRectangle._width / 2);
            var cW = (this._width + targetRectangle._width) / 2;
            var cY = (this._y + this._height / 2) - (targetRectangle._y + targetRectangle._height / 2);
            var cH = (this._height + targetRectangle._height) / 2;
            if ((Math.abs(cX) < Math.abs(cW)) && (Math.abs(cY) < Math.abs(cH))) {
                return true;
            }
            return false;
        }
    }
}