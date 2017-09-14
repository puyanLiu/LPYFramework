// 获取元素
function $(id) {
    return document.getElementById(id);
}

// 最大盒子
var w_slider = $("w_slider");
// 滚动图片组的父亲
var slider_main = $("slider_main");
// 控制点的父亲
var slider_ctrl = $("slider_ctrl");

// 生成span
var imgs = slider_main.children;
var imgCount = slider_main.children.length;
for (var i = 0; i < imgCount; i++) {
    var newSpan = document.createElement("span");
    newSpan.innerHTML = imgCount - i;
    newSpan.className = "slider-ctrl-con";
    slider_ctrl.insertBefore(newSpan, slider_ctrl.children[1]);
}

// 设置第一个span默认
var spans = slider_ctrl.children;
spans[1].className = "slider-ctrl-con current";

// 开始，将第一张图留下，其余图片右移310px
var w_sliderWidth = w_slider.clientWidth;
console.log('mainWidth', w_sliderWidth);
for (var i = 1; i < imgCount; i++) {
    imgs[i].style.left = w_sliderWidth + "px";
}

var iNow = 0;
// 遍历控制span
for (var k in spans) {
    spans[k].onclick = function() {
        if (this.className == "slider-ctrl-perv") {
            console.log(3423);
            // 左侧按钮
            animate(imgs[iNow], {
                left: w_sliderWidth
            });
            iNow--;
            iNow < 0 ? iNow = imgCount - 1 : iNow;
            imgs[iNow].style.left = -w_sliderWidth + "px";
            animate(imgs[iNow], {
                left: 0
            });
            setSquare();

        } else if (this.className == "slider-ctrl-next") {
            // 右侧按钮
            autoPlay();
        } else {
            var index = this.innerHTML - 1;
            if (index > iNow) {
                // 右移
                animate(imgs[iNow], {
                    left: -w_sliderWidth
                });
                imgs[index].style.left = w_sliderWidth + "px";
            } else if (index < iNow) {
                // 左移
                animate(imgs[iNow], {
                    left: w_sliderWidth
                });
                imgs[index].style.left = -w_sliderWidth + "px";
            }
            iNow = index;
            animate(imgs[iNow], {
                left: 0
            });
            setSquare();
        }
    }
}

// 控制底部span变化
function setSquare() {
    for (var i = 1; i < spans.length - 1; i++) {
        spans[i].className = "slider-ctrl-con";
    }
    spans[iNow + 1].className = "slider-ctrl-con current";
}

// 添加定时器
var timer = null;
timer = setInterval(autoPlay, 2000);

// 点击的时候，当前的图片先慢慢走到左边，下一张图片快速走到右侧310位置，然后慢慢走到舞台中
function autoPlay() {
    animate(imgs[iNow], {
        left: -w_sliderWidth
    });
    iNow++;
    iNow > imgCount - 1 ? iNow = 0 : iNow;
    // 下一张立马走到310位置
    imgs[iNow].style.left = w_sliderWidth + "px";
    animate(imgs[iNow], {
        left: 0,
    });

    // 设置底部span
    setSquare();
}

// 鼠标经过清除定时器
w_slider.onmouseover = function() {
    clearInterval(timer);
}

// 鼠标离开添加定时器
w_slider.onmouseout = function() {
    timer = setInterval(autoPlay, 2000);
}