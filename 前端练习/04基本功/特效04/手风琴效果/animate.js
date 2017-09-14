// 封装多个属性 添加回调函数
function animate(obj, json, fn) {
    clearInterval(obj.timer);
    obj.timer = setInterval(function() {
        // 遍历JSON
        var flag = true; // 用来判断是否停止定时器
        for (var attr in json) {
            // 计算步长
            var current = 0;
            if (attr == "opacity") {
                current = parseInt(getStyle(obj, attr) * 100) || 0;
            } else {
                current = parseInt(getStyle(obj, attr));
            }
            // 目标位置
            var step = (json[attr] - current) * 0.1;
            step = step > 0 ? Math.ceil(step) : Math.floor(step);
            if (attr == "opacity") {
                // 判断浏览器是否支持opacity
                if ("opacity" in obj.style) {
                    obj.style[attr] = (current + step) / 100;
                } else {
                    // obj.style.filter = alpha(opacity = 30)
                    obj.style.filter = "alpha(opacity = " + (current + step) + ")"
                }

                console.log("透明度", current);
            } else if (attr == "zIndex") {
                obj.style.zIndex = json[attr];
            } else {
                obj.style[attr] = current + step + "px";
            }
            console.log(current);
            // 只要其中一个不满足条件，就不应该停止定时器
            if (current != json[attr]) {
                flag = false;
            }
        }

        if (flag) {
            clearInterval(obj.timer);
            if (fn) {
                fn();
            }
        }
    }, 5);
}

// 获取当前样式
function getStyle(obj, attr) {
    if (obj.currentStyle) { // ie 
        return obj.currentStyle[attr];
    } else { // w3c 浏览器
        return window.getComputedStyle(obj, null)[attr];
    }
}