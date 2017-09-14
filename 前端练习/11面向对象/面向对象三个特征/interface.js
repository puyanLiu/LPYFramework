
function Interface(name, methods) {
    if (arguments.length != 2) {
        throw new Error("当前参数为： " + arguments.length + "个但是接口要求必须为2两个参数.");
    }
    this.name = name;
    this.methods = [];
    for (var i = 0, len = methods.length; i < len; i++) {
        if (typeof methods[i] !== 'string') {
            throw new Error("方法名称必须是字符串");
        }
        this.methods.push(methods[i]);
    }
};


//Static class Method

Interface.ensureImplements = function(object){
    if(arguments.length<2){
        throw new Error("方法 Interface.ensureImplemnents 指定了" + arguments.length+ "个参数，但是期望的是2个 .");
    }
    for(var i=1,len = arguments.length; i<len; i++){
        var _interface = arguments[i];
        if(_interface.constructor !== Interface){
            throw new Error("方法 Interface.ensureImplements 期望两个或两个以上实例对象参数");
        }

        for(var j=0, methodsLen = _interface.methods.length; j<methodsLen;j++ ){
            var method = _interface.methods[j];
            if(!object[method]||typeof object[method] !== 'function'){
                throw new Error("Function Interface.ensureImplements: object does not implements the "
                    +_interface.name + "interface. Method "+ method + " was not found");
            }
        }
    }

};
