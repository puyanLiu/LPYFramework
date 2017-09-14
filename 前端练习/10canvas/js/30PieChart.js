/*
* @Author: liupuyan
* @Date:   2017-01-09 18:34:36
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-01-09 18:54:16
*/

'use strict';

function PieChart(option) {
	this._init(option);
}

PieChart.prototype = {
	_init: function(option) {
		this.x = option.x || 0;
		this.y = option.y || 0;
		this.r = option.r || 0;

		this.data = option.data || [];

		// 饼状图所有的物件的组
		this.group = new Konva.Group({
			x: this.x,
			y: this.y
		});

		// 饼状图 所有的扇形的组
		this.wedgeGroup = new Konva.Group({
			x: 0,
			y: 0
		});
		this.group.add(this.wedgeGroup);

		// 添加一个放百分比文字的组
		this.textGroup = new Konva.Group({
			x: 0,
			y: 0
		});
		this.group.add(this.textGroup);

		var self = this; 
		var tempAngle = -90;

		this.data.forEach(function(item, index) {
			// 做一个扇形
			// wedg楔形物
			var angle = 360 * item.value;
			var wedge = new Konva.Wedge({
				x: 0,
				y: 0,
				angle: angle,
				radius: self.r,
				fill: item.color,
				rotation: tempAngle
			});
			self.wedgeGroup.add(wedge);

			// 绘制文本的角度
			var textAngle = tempAngle + 1 / 2 * angle;
			// 绘制百分比的文本
			var text = new Konva.Text({
				x: (self.r + 20) * Math.cos(Math.PI / 180 * textAngle),
				y: (self.r + 20) * Math.sin(Math.PI / 180 * textAngle),
				text: item.value * 100 + '%',
				fill: item.color
			});
			// 根据角度判断设置文本的位置
			if (textAngle > 90 && textAngle < 270) {
				// 让文本局右对齐
				text.x(text.x() - text.getWidth());
			}
			self.textGroup.add(text);

			tempAngle += angle;
		});

		// 外圆绘制
		var cir = new Konva.Circle({
			x: 0,
			y: 0,
			radius: this.r + 10,
			stroke: '#ccc',
			strokeWidth: 2
		});
		this.group.add(cir);

		this._animateIndex = 0;
	},
	addToGroupOrLayer: function(arg) {
		arg.add(this.group);
	},
	playAnimate: function() {
		var self = this;
		if (this._animateIndex == 0) {
			this.wedgeGroup.getChildren().each(function(item, index) {
				item.angle(0);
			});
		}
		var item = this.wedgeGroup.getChildren()[this._animateIndex]; // 取到要进行动画的扇形
		item.to({
			angle: this.data[this._animateIndex].value * 360,
			duration: this.data[this._animateIndex].value * 2,
			onFinish: function() {
				self._animateIndex++;
				
				if (self._animateIndex >= data.length) {
					self._animateIndex = 0;
					return;
				}
				self.playAnimate();
			}
		});
	}
};