module hxy {
    export class Helper {
        static removeFromArray<T>(items: Array<T>, item: T) {
            var index = items.indexOf(item);
            if (index >= 0) {
                items.splice(index, 1);
            }
            //其它方法
            //http://zhidao.baidu.com/link?url=lCqhXjYRFqaQBI3U0Z9q-ClzoRgmzztqZnl-pA2kk069qWR_qBbnN7N_b6gr-vxpJWTAAdyVQ0HLwBL4ZP_yAq
            //http://www.cnblogs.com/greatverve/archive/2009/10/19/1586003.html
        }
    }
}