/*
* @Author: liupuyan
* @Date:   2017-03-13 16:25:53
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-14 15:23:08
*/

'use strict';

// 引入gulp模块
var gulp = require('gulp');
// 引入less转css模块
var less = require('gulp-less');
// 引入css压缩模块
var cssnano = require('gulp-cssnano');
// 引入BrowserSync
// 调用 .create() 意味着你得到一个唯一的实例并允许您创建多个服务器或代理
var browserSync = require('browser-sync').create();
// 引入js合并模块
var concat = require('gulp-concat');
// 引入js压缩模块
var uglify = require('gulp-uglify');
// 引入html压缩模块
var htmlmin = require('gulp-htmlmin');


// 注册一个任务
gulp.task('copy', function() {
	console.log('copy');
	// 复制文件
	// gulp.src取文件
	gulp.src('src/index.html')
		.pipe(gulp.dest('dist/')); // 将此处需要的操作传递进去
});

gulp.task('dist', function() {
	gulp.watch('src/index.html', ['copy']);
	gulp.watch('src/styles/*.less', ['style']);
});

// less编译 压缩 合并（合并没有必要，一般预处理CSS都可以导包）
// npm install gulp --save-dev
// npm install gulp-less --save-dev
// npm install gulp-cssnano --save-dev
gulp.task('style', function() {
	// 编译单个less文件
	// gulp.src('src/styles/index.less')
	// 编译多个less文件
	// gulp.src(['src/styles/index.less', 'src/styles/detail.less'])
	
	// gulp.src('src/styles/*.less')
	// 	.pipe(less()) // less转css
	// 	.pipe(cssnano()) // css压缩
	// 	.pipe(gulp.dest('dist/css'));

	gulp.src(['src/styles/*.less', '!src/styles/_*.less'])
		.pipe(less())
		.pipe(cssnano())
		.pipe(gulp.dest('dist/css'))
		.pipe(browserSync.reload({
			stream: true
		}));
});

// JS合并 压缩混淆
// npm install --save-dev gulp-concat
// npm install --save-dev gulp-uglify
gulp.task('script', function() {
	gulp.src('src/script/*.js')
		.pipe(concat('all.js'))
		.pipe(uglify())
		.pipe(gulp.dest('dist/script'))
		.pipe(browserSync.reload({
			stream: true
		}));
});

// 图片复制
gulp.task('image', function() {
	gulp.src('src/images/*.*')
		.pipe(gulp.dest('dist/images'))
		.pipe(browserSync.reload({
			stream: true
		}));
});

// html压缩
// npm i gulp-htmlmin --save-dev
gulp.task('html', function() {
	 var options = {
        removeComments: true,//清除HTML注释
        collapseWhitespace: true,//压缩HTML
        collapseBooleanAttributes: true,//省略布尔属性的值 <input checked="true"/> ==> <input />
        removeEmptyAttributes: true,//删除所有空格作属性值 <input id="" /> ==> <input />
        removeScriptTypeAttributes: true,//删除<script>的type="text/javascript"
        removeStyleLinkTypeAttributes: true,//删除<style>和<link>的type="text/css"
        minifyJS: true,//压缩页面JS
        minifyCSS: true//压缩页面CSS
    };
	gulp.src('src/*.html')
		.pipe(htmlmin({
			collapseWhitespace: true,
			removeComments: true
		}))
		.pipe(gulp.dest('dist'))
		.pipe(browserSync.reload({
			stream: true
		}));
});

// npm install --save-dev browser-sync
// 静态服务器
gulp.task('qqmserver', ['style', 'script', 'image', 'html'], function() {
	// .init 启动服务器
	// browserSync.init({
	// 	server: {
	// 		// 静态服务器的目录
	// 		baseDir: './src/'
	// 	},
	// });

	// html文件更新重新刷新
	// gulp.watch('src/*.html').on('change', browserSync.reload);
	


	browserSync.init({
		server: {
			baseDir: ['dist/']
		}
	}, function(err, bs) {
		console.log(bs.options.getIn(["urls", "local"]));
	});

	gulp.watch('src/styles/*.less', ['style']);
	gulp.watch('src/script/*.js', ['script']);
	gulp.watch('src/images/*.*', ['image']);
	gulp.watch('src/*.html', ['html']);
});