/*
* @Author: liupuyan
* @Date:   2017-01-06 09:04:01
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-01-06 10:11:36
*/

'use strict';

function Rect(option) {
	this._init(option);
}

Rect.prototype = {
	_init: function(option) {
		this.x = option.x || 0;
		this.y = option.y || 0;
		this.h = option.x || 0;
		this.w = option.w || 0;
		this.rotation = option.rotation || 0; // 矩形的旋转
		// 设置矩形的透明度
		this.opacity = option.opacity === 0 ? 0 : option.opacity || 1;
		this.scaleX = option.scaleX || 1; // 设置缩放
		this.scaleY = option.scaleY || 1;

		this.strokeStyle = option.strokeStyle || 'red';
		this.fillStyle = option.fillStyle || 'blue';
	},
	render: function(ctx) {
		ctx.save(); // 把当前的上下文的状态保存一下
		ctx.beginPath(); // 开始一个新的路径

		// 把整个画布进行位移
		ctx.translate(this.x, this.y);

		// 设置透明度
		ctx.globalAlpha = this.opacity;

		// 设置画布放大缩小
		ctx.scale(this.scaleX, this.scaleY);

		ctx.rect(0, 0, this.w, this.h);
		ctx.fillStyle = this.fillStyle;
		ctx.fill();
		ctx.strokeStyle = this.strokeStyle;
		ctx.stroke();

		ctx.restore();

	}
}