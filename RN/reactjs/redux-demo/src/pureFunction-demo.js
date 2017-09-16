
/**
 * 纯函数（Pure Function）
 * 一个函数的返回结果只依赖于它的参数，并且在执行过程里面没有副作用，这个函数就叫做纯函数
 * 
 * 一个函数在执行过程中有很多方式产生外部可观察的变化，
 * 比如说修改外部的变量，
 * 调用 DOM API 修改页面，
 * 或者你发送了 Ajax 请求，
 * 还有调用 window.reload 刷新浏览器，
 * 甚至是 console.log 往控制台打印数据也是副作用
 * 
 * 纯函数很严格，也就是说你几乎除了计算数据以外什么都不能干，计算的时候还不能依赖除了函数参数以外的数据
 */

/**
 * 函数的返回结果只依赖于它的参数
 * 
 * foo函数不是一个纯函数，因为它返回的结果依赖于外部变量a
 */
const a = 1;
const foo = (b) => a + b;
console.log(foo(2));

/**
 * foo是一个纯函数，它的返回结果只依赖于它的参数x和b
 */
const foo1 = (x, b) => x + b;
console.log(foo1(1, 2));

/**
 * 函数执行过程没有副作用
 * 
 * 一个函数执行过程对产生了外部可观察的变化，那么就说这个函数是有副作用的
 */

/**
 * foo2是一个纯函数，计算的过程里面并不会对传入的对象进行修改，计算前后的counter不会发生任何变化
 */
const foo2 = (obj, b) => {
  return obj.x + b;
}
const counter = {x: 1};
console.log(foo2(counter, 2));
console.log(counter.x);

/**
 * foo3不是一个纯函数，计算的内部对外部的counter产生了影响，它产生了副作用，应为它修改了外部传进来的对象
 */
const foo3 = (obj, b) => {
  obj.x = 2;
  return obj.x + b;
}
const counter1 = {x: 1};
console.log(foo3(counter1, 2));
console.log(counter1.x);

/**
 * foo4是一个纯函数，虽然函数内部修改了obj，但是obj是内部变量，外部程序根本观察不到，
 * 修改obj并不会产生外部可观察的变化，这个函数式没有副作用的
 */
const foo4 = (b) => {
  const obj = {x: 1};
  obj.x = 2;
  return obj.x + b;
}
console.log(foo4(2));