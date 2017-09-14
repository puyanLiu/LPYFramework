/*
* @Author: liupuyan
* @Date:   2017-01-05 17:48:08
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-01-05 18:03:03
*/

'use strict';

function Sprite(option) {
	this._init(option);
}
Sprite.prototype = {
	// 初始化
	_init: function(option) {
		this.x = option.x === 0 ? 0 : (option.x || 10);
		this.y = option.y === 0 ? 0 : (option.y || 10);
		this.w = option.w || 40;
		this.h = option.h || 65;
		this.fps = option.fps || 10; // frame per second
		this.originW = option.originW || 40;
		this.originH = option.originH || 65;
		this._dirIndex = 0;
		this._imgSrc = option.imgSrc || '';
	},
	// 渲染当前动画
	render: function(ctx) {
		var img = new Image();
		img.src = this._imgSrc;
		var that = this;
		img.onload = function() {
			var frameIndex = 0;
			setInterval(function() {
				ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
				ctx.drawImage(img, frameIndex * that.originW, that._dirIndex * that.originH, that.originW, that.originH, that.x, that.y, that.w, that.h);
				frameIndex++;
				frameIndex %= 4;
			}, 1000 / self.fps);
		}
	},
	// 改变方向
	changeDir: function(dir) {
		switch(dir) {
			case 'left':
				this._dirIndex = 1;
			break;
			case 'right':
				this._dirIndex = 2;
			break;
			case 'up':
				this._dirIndex = 3;
			break;
			case 'down':
				this._dirIndex = 0;
		}
	}
};