/*
* @Author: liupuyan
* @Date:   2017-01-09 10:35:30
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-01-09 11:00:16
*/

'use strict';

function CircleText(option) {
	this._init(option);
}

CircleText.prototype = {
	_init: function(option) {
		this.x = option.x || 0;
		this.y = option.y || 0;
		this.innerRadius = option.innerRadius || 0;
		this.outerRadius = option.outerRadius || 0;
		this.text = option.text || 'canvas';
		this.innerStyle = option.innerStyle || 'red';
		this.outerStyle = option.outerStyle || 'blue';

		// 创建文字和圆形的一个组
		this.group = new Konva.Group({
			x: this.x,
			y: this.y
		});

		// 创建内环圆
		var innerCircle = new Konva.Circle({
			x: 0,
			y: 0,
			radius: this.innerRadius,
			fill: this.innerStyle,
			opacity: .8
		});
		this.group.add(innerCircle);

		// 创建背景外环
		var outerRing = new Konva.Ring({
			x: 0,
			y: 0,
			innerRadius: this.innerRadius,
			outerRadius: this.outerRadius,
			fill: this.outerStyle,
			opacity: .5
		});
		this.group.add(outerRing);

		// 创建中心圆的文字
		var cenText = new Konva.Text({
			x: 0 - this.outerRadius,
			y: -7,
			width: this.outerRadius * 2,
			align: 'center',
			text: this.text,
			fontSize: 17,
			fontStyle: 'bold',
			fontFamily: '微软雅黑',
			fill: '#fff',
		});
		this.group.add(cenText);

	},
	addToGroupOrLayer: function(arg) {
		arg.add(this.group);
	}
}