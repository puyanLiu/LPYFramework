/*
* @Author: liupuyan
* @Date:   2017-01-09 15:40:41
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-01-09 17:49:08
*/

'use strict';

function HistogramChart(option) {
	this._init(option);
}

HistogramChart.prototype = {
	_init: function(option) {
		this.x = option.x || 0;
		this.y = option.y || 0;
		this.w = option.w || 0;
		this.h = option.h || 0;

		this.data = option.data || [];

		var x0 = 0;
		var y0 = 0;

		// 柱状图中所有的元素的组
		this.group = new Konva.Group({
			x: this.x,
			y: this.y
		});

		// 放矩形的组
		this.rectGroup = new Konva.Group({
			x: 0,
			y: 0
		});
		this.group.add(this.rectGroup);

		// 添加一个放百分比文字的组
		this.textPercentGroup = new Konva.Group({
			x: 0,
			y: 0
		});
		this.group.add(this.textPercentGroup);

		// 绘制底线
		var bsLine = new Konva.Line({
			// x 从 1/8 到 6/8
			// y 3、4高度
			points: [x0, y0, x0 + this.w, y0],
			strokeWidth: 1,
			stroke: 'lightgreen'
		});
		this.group.add(bsLine);

		// 定义 矩形和矩形的间距
		var rectWidth = this.w / this.data.length;
		var height = this.h;

		var self = this; // 当前柱状的对象
		this.data.forEach(function(item, index) {
			var rect = new Konva.Rect({
				x: x0 + (1 / 4 + index) * rectWidth,
				y: y0 - item.value * height,
				width: 1 / 2 * rectWidth,
				height: item.value * height,
				fill: item.color,
				opacity: .8,
				cornerRadius: 10,
				shadowBlur: 10,
				shadowColor: 'black',
				shadowOffsetX: 4,
				shadowOffsetY: 4
			});
			self.rectGroup.add(rect);

			// 把百分比的文字放到柱状图的顶部
			var text = new Konva.Text({
				x: x0 + index * rectWidth,
				y: y0 - item.value * height - 20,
				text: item.value * 100 + '%',
				width: rectWidth,
				align: 'center',
				fontSize: 14,
				fill: item.color,
				name: 'textPercent' // 设置文字的name，可以通过类选择器选取
			});
			self.textPercentGroup.add(text);

			// 把百分比的文字放到柱状图的顶部
			var textBottom = new Konva.Text({
				x: x0 + 20 + (1 / 4 + index) * rectWidth,
				y: y0 + 10,
				text: item.name,
				fill: item.color,
				rotation: 30,
				width: rectWidth,
			});
			self.group.add(textBottom);
		});
	},
	addToGroupOrLayer: function(arg) {
		arg.add(this.group);
	},
	playAnimate: function() {
		var self = this;
		this.rectGroup.getChildren().each(function(item, index) {
			// each是Konva的数组提供的方法，只能用于Konva的数组，或者是Konva选择器选择出来的元素上。
			
			// 在konva中，如果传参数：设置值， 如果不传参代表取值
			item.y(0);
			item.height(0);

			// 动画显示到初始的状态
			item.to({
				duration: 1,
				y: -self.data[index].value * self.h,
				height: self.data[index].value * self.h
			});
		});

		// 把文字设置动画
		// 类型选择器是通过 name属性来选取。
		this.textPercentGroup.getChildren().each(function(item, index) {
			// each函数第一个参数是元素对象，第二个参数是索引值
			item.y(-14);
			item.to({
				duration: 1,
				y: -self.data[index].value * self.h - 20
			});
		});
	}
};