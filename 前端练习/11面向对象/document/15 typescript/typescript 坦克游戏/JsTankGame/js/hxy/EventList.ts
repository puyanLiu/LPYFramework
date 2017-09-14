module hxy {
    export class EventList<T> {
        private _handlers: Array<T> = new Array<T>();

        add(handler: T) {
            this._handlers.push(handler);
        }

        remove(handler: T) {
            Helper.removeFromArray(this._handlers, handler);
        }

        fire(callback: (handler: T) => void) {
            this._handlers.forEach(t => callback(t));
        }
    }

    export interface Action {
        (): void;
    }
    //export interface Action<T> {
    //    (item: T): void;
    //}
}