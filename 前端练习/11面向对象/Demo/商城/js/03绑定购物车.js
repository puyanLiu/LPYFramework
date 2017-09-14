/*
* @Author: liupuyan
* @Date:   2017-02-21 16:53:58
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-02-21 16:59:20
*/

/*定义购物车对象*/
function Cart(){
    this.products=[]
    this.sum=3
    this.allPrice=2000
}
Cart.prototype={
    bindBasic:function(){
        //绑定
        $('.cartsum').html(this.getSum())
        $('#cartprice').html(this.getAllPrice())
    },
    //绑定产品列表,每次点击到购物车执行的方法
    bindList:function(){
        var str=''
        for(var i= 0,len=this.products.length;i<len;i++){
            str+='<div class="cart_box">'
            str+='<div class="message">'
            str+=' <div class="alert-close"> </div>'
            str+=' <div class="list_img"> <img src="'+this.products[i].images[0].small+'" class="img-responsive" alt=""/> </div>'
            str+=' <div class="list_desc"><h4><a href="#">'+this.products[i].name+'</a></h4><span class="actual">'+ this.products[i].groupbuyPrice+'</span></div>'
            str+=' <div class="clearfix"></div>'
            str+='  <div class="clearfix"></div>'
            str+='  </div>'
            str+='   </div>'
        }
        $('.shopping_cart').html(str)

    },
    /*结算*/
    calcalate:function(){},
    /*获取产品个数*/
    getSum:function(){
        this.sum=this.products.length;
        return this.sum;
    },
    /*获取产品总价*/
    getAllPrice:function(){
        for(var i= 0,len=this.products.length;i<len;i++){
            this.allPrice+=this.products[i].groupbuyPrice;
        }
        return this.allPrice;
    }

}


$(document).ready(function(){

    /*开始编程*/
    /*产品相关*/
    /*实例化*/
    var product =  new Product()
    product.name='HM休闲服登山包33'
    product.description='棒棒的，棒棒的，登山一流，服务一流，你好，我好，他也好，太棒了，一口气等上珠穆朗玛峰'
    product.normalPrice=144
    product.groupbuyPrice=120
    product.buySum=100;
    product.images=[
        {small:'../images/s11.jpg',big:'../images/s11.jpg'},
        {small:'../images/s12.jpg',big:'../images/s12.jpg'},
        {small:'../images/s13.jpg',big:'../images/s13.jpg'}
    ]
    /*使用对象中的方法属性*/
    product.bindDOMDetail()
    product.bindDOMImage()

    /*绑定事件*/
    $('#btnaddcart').click(function(){
        /*购物车新增一个产品*/
        console.log('12222')
        cart.products.push(product)
        ///*更新购物车 - 重新绑定购物车*/
        /*如果不封装，这里就可能产生代码重复*/
        cart.bindBasic()
        cart.bindList()
        $(window).scrollTop(0);
    });





    /*实例购物车*/
    var cart =  new Cart()
    cart.sum=3
    cart.allPrice=2000

    /*假设购物车中已经有三个产品*/
    cart.products.push(product)
    cart.products.push(product)
    cart.products.push(product)

    /*使用对象中的方法属性*/
    cart.bindBasic()
    cart.bindList()


});