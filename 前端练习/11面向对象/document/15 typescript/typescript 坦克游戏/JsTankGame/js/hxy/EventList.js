var hxy;
(function (hxy) {
    var EventList = (function () {
        function EventList() {
            this._handlers = new Array();
        }
        EventList.prototype.add = function (handler) {
            this._handlers.push(handler);
        };
        EventList.prototype.remove = function (handler) {
            hxy.Helper.removeFromArray(this._handlers, handler);
        };
        EventList.prototype.fire = function (callback) {
            this._handlers.forEach(function (t) { return callback(t); });
        };
        return EventList;
    })();
    hxy.EventList = EventList;
})(hxy || (hxy = {}));
//# sourceMappingURL=EventList.js.map