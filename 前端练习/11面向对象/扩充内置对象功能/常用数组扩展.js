/*
* @Author: liupuyan
* @Date:   2017-03-08 10:03:03
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-08 14:18:36
*/

/** 删除数组中指定索引的数据 **/
Array.prototype.deleteAt = function (index) {
    if (index < 0) {
        return this;
    }
    return this.slice(0, index).concat(this.slice(index + 1, this.length));
}
/** 数组洗牌 **/
Array.prototype.random = function () {
    var tempArr = [], me = this, t;
    while (me.length > 0) {
        t = Math.floor(Math.random() * me.length);
        tempArr[tempArr.length] = me[t];
        me = me.deleteAt(t);
    }
    return tempArr;
}
Array.prototype.orderRandom = function () {
    return this.sort(function () {
        return Math.random() > 0.5 ? "-1" : "1";
    });
}
/** 数字数组排序 **/
Array.prototype.sortNum = function (i) {
    if (!i) {
        i = 0;
    }
    if (i == 1) {
        return this.sort(function (a, b) {
            return b - a;
        });
    }
    return this.sort(function (a, b) {
        return a - b;
    });
}
/** 获取数字数组中的最大项 **/
Array.prototype.getMax = function () {
    return this.sortNum(1)[0];
}
/** 获取数字数组中的最小项 **/
Array.prototype.getMin = function () {
    return this.sortNum(0)[0];
}
/** 数组第一次出现指定元素的位置 **/
Array.prototype.indexOf = function (o) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == o) {
            return i;
        }
    }
    return -1;
}
/** 去除数组中的重复项 **/
Array.prototype.arrUnique = function () {
    var reset = [], done = {};
    for (var i = 0; i < this.length; i++) {
        var temp = this[i];
        if (!done[temp]) {
            done[temp] = true;
            reset.push(temp);
        }
    }
    return reset;
}

/*--数组扩展方法--*/
/*
 *去除数组中的重复项
 */
Array.prototype.unique = function() {
    var a = []; var l = this.length;
    for (var i = 0; i < l; i++)
    {
        for (var j = i + 1; j < l; j++)
        {
            if (this[i] === this[j]) j = ++i;
        }
        a.push(this[i]);
    }
    return a;
};

var arr = [1,2,3,4,5,6,6,7,7,77,7,]
console.log(arr.unique())
 

 /*--数组扩展方法--*/

        /*数组基础*/
        /* 将数组清空，并返回这个数组的引用*/
        Array.prototype.clear = function() {
            this.length = 0;
            return this;
        }

        /* 返回数组第一项*/
        Array.prototype.first = function() {
            return this[0];
        }

        /* 返回数组最后一项*/
        Array.prototype.last = function() {
            return this[this.length - 1];
        }

        /* 返回数组的大小，即数组长度*/
        Array.prototype.size = function() {
            return this.length;
        }



        /*计算类*/
        function cacl(arr, callback) {
            var ret;
            for (var i=0; i<arr.length;i++) {
                ret = callback(arr[i], ret);
            }
            return ret;
        }
        Array.prototype.max = function () {
            return cacl(this, function (item, max) {
                if (!(max > item)) {
                    return item;
                }
                else {
                    return max;
                }
            });
        };
        Array.prototype.min = function () {
            return cacl(this, function (item, min) {
                if (!(min < item)) {
                    return item;
                }
                else {
                    return min;
                }
            });
        };
        Array.prototype.sum = function () {
            return cacl(this, function (item, sum) {
                if (typeof (sum) == 'undefined') {
                    return item;
                }
                else {
                    return sum += item;
                }
            });
        };
        Array.prototype.avg = function () {
            if (this.length == 0) {
                return 0;
            }
            return this.sum(this) / this.length;
        };


        //数组的交，并，差集
        /* 返回数组与目标数组的交集组成的数组*/
        Array.prototype.intersect = function(target) {
            var originalArr = this.unique(),
                target = target.unique();
            return originalArr.filter(function(e, i, self) {
                for( var i = 0, l = target.length; i < l; ++i) {
                    if(e === target[i]) {
                        return true;
                    }
                }
                return false;
            });
        }

        /* 返回数组与目标数组的并集组成的数组*/
        Array.prototype.union = function(target) {
            return this.concat(target).unique();
        }

        /*返回数组与目标数组的差集组成的数组*/
        Array.prototype.diff = function(target) {
            var originalArr = this.unique(),
                target = target.unique();
            return originalArr.filter(function(e, i, self) {
                for( var i = 0, l = target.length; i < l; ++i) {
                    if(e === target[i]) {
                        return false;
                    }
                }
                return true;
            });
        }



        /* ES5 ES6新增*/

        /*去除数组中的重复项*/
        Array.prototype.unique = function() {
            var a = []; var l = this.length;
            for (var i = 0; i < l; i++) {
                for (var j = i + 1; j < l; j++) {
                    if (this[i] === this[j]) j = ++i;
                }
                a.push(this[i]);
            }
            return a;
        };



        /* 对数组的每一项执行回调,这个方法没返回值*/
        Array.prototype.forEach= function(fn, ctx) {
            for(var i = 0, l = this.length; i < l; i++) {
                fn.call(ctx || null, this[i], i, this);
            }
        }

        /*对数组每项运行回调函数，返回由回调函数的结果组成的数组*/
        Array.prototype.map = function(fn, ctx) {
            var ret = [];
            for(var i = 0, l = this.length; i < l; i++) {
                ret.push(fn.call(ctx || null, this[i], i, this));
            }
            return ret;
        }

        /*对数组每项运行回调函数，返回使回调函数返回值为true组成的数组*/
        Array.prototype.filter = function(fn, ctx) {
            var ret = [];
            for(var i = 0, l = this.length; i < l; i++) {
                fn.call(ctx || null, this[i], i, this) &&
                ret.push(this[i]);
            }
            return ret;
        }


        /*对数组每项运行回调函数，如果所有的回调函数都返回true, 则返回true*/
        Array.prototype.every = function(fn, ctx) {
            for(var i = 0, l = this.length; i < l; i++) {
                !!fn.call(ctx || null, this[i], i, this) === false;
                return false;
            }
            return true;
        }

        /*对数组每项运行回调函数，如果有一项回调函数返回true, 则返回true*/
        Array.prototype.some = function(fn, ctx) {
            for(var i = 0, l = this.length; i < l; i++) {
                !!fn.call(ctx || null, this[i], i, this) === true;
                return true;
            }
            return false;
        }

        /**
         * 从左向右（顺利）对数组的每一项(从第二项开始，即下标为1)运行回调函数。
         * 回调函数包含四个参数prev（上一次回调的返回值）, cur（当前数组项）, index（当前数组项的索引）, self（数组本身）
         */
        Array.prototype.reduce = function(callback) {
            var i = 1, //从数组第二个元素开始
            l = this.length,
            callbackRet = this[0];
            for(; i < l; ++i) {
                callbackRet = callback.call(null, callbackRet, this[i], i, this);
            }
            return callbackRet;
        },

        /**
         * 从右向左（逆序）对数组的每一项(从倒数第二项开始，即下标为arr.length - 2)运行回调函数。
         * 回调函数包含四个参数prev（上一次回调的返回值）, cur（当前数组项）, index（当前数组项的索引）, self（数组本身）
         */
        Array.prototype.reduceRight = function(callback) {
            var l = this.length,
            i = l - 2, //从数组倒数第二个元素开始
            callbackRet = this[l - 1]; //回调初始值为数组最后一个元素的值
            for(; i >= 0; --i) {
                callbackRet = callback.call(null, callbackRet, this[i], i, this);
            }
            return callbackRet;
        }
        /**
         * 返回目标值在数组中第一次出现的位置，搜索从左向右进行。
         * 如果目标值在数组中不存在，则返回-1。可以指定一个搜索起始位置。默认为0
         */
        Array.prototype.indexOf= function(target, start) {
            var l = this.length,
            start = ~~start;//可以指定一个搜索起始位置。默认为0。start不传，默认为undefined,~~undefined -> 0
            if(start < 0)
            start = 0;//如果指定的搜索位置小于0，则设置其开始搜索位置为0
            for(; start < l; ++start) {
                if(this[start] === target)
                return start;
            }
            return -1;
        },

        /**
         * 返回目标值在数组中的位置。搜索从右向左进行
         * 如果目标值在数组中不存在，则返回-1。可以指定一个搜索起始位置。默认为数组长度
         */
        Array.prototype.lastIndexOf = function(target, start) {
            var l = this.length;
            if(start === void 0)
            start = this.length;
        else if(start < 0)
            start = 0;
            for(;start >= 0; --start) {
                if(this[start] === target)
                return start;
            }
            return -1;
        }

        /**
         * 对于单一类型的数组，可以使用此方法去重。
         * 但这类数组：[ 'ff', 1, '1' ]会去重失败
         */
        Array.prototype.enhanceUnique = function() {
            var ret = [], tempMap = {}, temp, i = 0, l = this.length, undef = void 0;
            for(; i < l; ++i) {
                temp = this[i];
                if(tempMap[temp] === undef) {
                    ret.push(temp);
                    tempMap[temp] = true;
                }
            }
            return ret;
        }

        /*去掉数组中的目标元素*/
        Array.prototype.without = function() {
            var args = [].slice.call(arguments).unique(),
            i = 0, l = this.length,
            j = 0, k = args.length;

            for(; i < l; ++i) {
                for(; j < k; ++j) {
                    if(this[i] === args[j]) {
                        this.splice(i, 1);
                    }
                }
                j = 0;//将j归0，以便下次循环
            }
            return this;
        }


        /* 递归将数组扁平化*/
        Array.prototype.flatten = function() {
            var ret = [], i = 0, l = this.length, tmp, toString = ({}).toString;
            for(; i < l; ++i) {
                tmp = this[i];
                if(toString.call(tmp) === '[object Array]') {
                    ret = ret.concat(tmp.flatten());
                } else {
                    ret.push(tmp);
                }
            }
            return ret;
        }

        /* 随机返回数组的一项*/
        Array.prototype.random = function(n) {
            //Math.floor():向下取整。Math.floor(1.8) -> 1
            //Math.ceil():向上取整。Math.ceil(1.1) -> 2
            //v = Math.random() * n:会产生一个 0 < v < nv的数
            //v2 = Math.floor(Math.random() * n)：v2为一个大于等于0，小于n的整数
            return this[Math.floor(Math.random() * n || this.length)];
        },


        /* 删除数组指定位置的项*/
        Array.prototype.removeAt = function(pos) {
            this.splice(pos, 1);
            return this;
        }

        /* 检测数组是否包含目标值*/
        Array.prototype.contains= function(target) {
            return this.some(function(e, i, self) {
                return e === target;
            });
        }

