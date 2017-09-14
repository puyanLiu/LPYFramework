var hxy;
(function (hxy) {
    var Helper = (function () {
        function Helper() {
        }
        Helper.RemoveFromArray = function (items, item) {
            var index = items.indexOf(item);
            if (index >= 0) {
                items.splice(index, 1);
            }
            //其它方法
            //http://zhidao.baidu.com/link?url=lCqhXjYRFqaQBI3U0Z9q-ClzoRgmzztqZnl-pA2kk069qWR_qBbnN7N_b6gr-vxpJWTAAdyVQ0HLwBL4ZP_yAq
            //http://www.cnblogs.com/greatverve/archive/2009/10/19/1586003.html
        };
        return Helper;
    })();
    hxy.Helper = Helper;
})(hxy || (hxy = {}));
//# sourceMappingURL=Helper.js.map