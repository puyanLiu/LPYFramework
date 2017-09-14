/*
* @Author: liupuyan
* @Date:   2017-01-06 16:51:48
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-01-06 18:29:43
*/

'use strict';

function ProgressBar(option) {
	this._init(option);
}

ProgressBar.prototype = {
	// 类初始化的时候：创建内部矩形，外部矩形，然后把两个矩形放到group里面去
	
	_init: function(option) {
		this.x = option.x || 0;
		this.y = option.y || 0;
		this.w = option.w || 0;
		this.h = option.h || 0;

		this.fillStyle = option.fillStyle || 'red';
		this.strokeStyle = option.strokeStyle || 'red';

		// 内部进度条的矩形
		var innerRect = new Konva.Rect({
			x: this.x,
			y: this.y,
			width: 0,
			height: this.h,
			fill: this.fillStyle,
			cornerRadius: 0.5 * this.h,
			id: 'innerRect',
			name: 'ss'
		});
		this.innerRect = innerRect;

		// 添加一个外边框矩形
		var outerRect = new Konva.Rect({
			x: this.x,
			y: this.y,
			width: this.w,
			height: this.h,
			stroke: this.strokeStyle,
			strokeWidth: 4,
			cornerRadius: 0.5 * this.h
		});

		// 创建组
		this.group = new Konva.Group({
			x: 0,
			y: 0
		});
		this.group.add(innerRect);
		this.group.add(outerRect);
	},
	// 动画
	changeValue: function(val) {
		if (val > 1) {
			val = val / 100;
		}

		// 动画
		var width = this.w * val;
		var innerRect = this.group.findOne('#innerRect');
		// var innerRect = this.innerRect;
		
		// to动画 让我们的物件变换到某个状体
		innerRect.to({
			width: width,
			duration: .3,
			easing: Konva.Easings.EasIn
		});
		
	},
	// 把当前创建的进度条添加到层中，arg:层或组
	addToGroupOrLayer: function(layer) {
		layer.add(this.group);
	}
};