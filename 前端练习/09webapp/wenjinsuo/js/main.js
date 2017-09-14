/*
* @Author: liupuyan
* @Date:   2016-12-09 18:11:57
* @Last Modified by:   liupuyan
* @Last Modified time: 2016-12-20 15:48:06
*/

'use strict';

$(function() {
	/**
	 * 根据屏幕宽度的变化决定轮播图应该展示什么
	 * @return {[type]} [description]
	 */
	function resize() {
		// 获取屏幕宽度
		var windowWidth = $(window).width();
		console.log(windowWidth);
		// 判断屏幕属于大屏还是小屏
		var isSmallScreen = windowWidth < 768;
		// 根据大小为界面上的每一张轮播图设置背景
		$("#main_ad > .carousel-inner > .item").each(function(index, el) {
			var $item = $(el);
			var imgSrc = isSmallScreen ? $item.data('image-xs') : $item.data('image-lg');
			// jQuery方式
	      	// $element.data()
	      	// 是一个函数 ，专门用于取元素上的自定义属性（data-abc）
	      	// 函数的参数是我们要取得属性名称（abc）
	      	//
	      	// $element.attr('data-abc')
	      	//
	      	// JS中的写法
	      	// element.dataset['abc']
	      	//
	      	// element.getAttribute('data-abc')
	      	// element.setAttribute('data-abc','')

			$item.css({
				'backgroundImage': 'url(' + imgSrc + ')',
			});
			if (isSmallScreen) {
				$item.html('<img src="' + imgSrc + '" alt="" />')
			} else {
				$item.empty();
			}
		});


		// 特别推荐
		var $ulContainer = $(".nav-products-tabs");
		// 获取所有子元素的和
		var width =  30;
		$ulContainer.children().each(function(index, el) {
			// console.log(el.clientWidth);
			// console.log($(el).width());
			width += el.clientWidth;
		});
		// 此时width等于所有li的宽度总和
		if (width > $(window).width()) {
			$ulContainer.css({
				"width": width
			}).parent().css({
				"overflow-x": 'scroll'
			});
		} else {
			$ulContainer.css({
				"width": 'auto'
			}).parent().css({
				"overflow-x": 'hidden'
			});;
		}
	}

	$(window).on('resize', resize).trigger('resize');

	// 新点击切换
	$("#news a").click(function(e) {
		$("#news .newTitle > p").text($(this).data('new-title'));
	});

	// 初始化打开登陆框
	// $("#login_form").modal('show');
	
	// tooltips提示框效果
	$('[data-toggle="tooltip"]').tooltip();

	// 轮播图触摸
	var offset = 50;
	$(".carousel").each(function(index, el) {
		var startX, endX;
		el.addEventListener('touchstart', function(e) {
			startX = e.touches[0].clientX;
			e.preventDefault();
		});
		el.addEventListener('touchmove', function(e) {
			endX = e.touches[0].clientX;
			e.preventDefault();
		});
		el.addEventListener('touchend', function(e) {
			var offsetX = endX - startX;
			// console.log(offsetX);
			if (offsetX > offset) {
				// 右
				$(this).carousel('prev');
			} else if (offsetX < -offset) {
				// 左
				$(this).carousel('next');
			}
			// console.log(this); this = $(".carousel")
			e.preventDefault();
		});
	});
	
});