//产品对象
/*对象内如何使用对象的属性和方法：this，对象外如何使用：先实例化，后用点语法*/
function Product() {
    /*属性 行为*/
    this.name ='';
    this.price='';
    this.description = '';
    this.youhuijia='';
    this.zhekou = ''
    this.sales = ''
    this.image=''
}
Product.prototype={
    bindDom:function(){
        ""
        var str=''
        str+='<dl>'
            str+='<dt><a><img src="'+this.image+'" width="384" height="225" /></a></dt>'
            str+='<dd>'
                str+='<span><a><em>'+this.zhekou+'折/</em>'+this.name+'</a></span>'
            str+='</dd>'
            str+='<dd class="price">'
                str+='<em>￥'+this.price+'</em>'
                str+='<del>￥'+this.youhuijia+'</del>'
                str+='<i>售量：'+this.sales+'</i>'
            str+='</dd>'
        str+='</dl>'
        return str;
    },
    bindEvents:function(){

    }
}

/*搭积木开发 -- 代码可读性极高*/
window.onload=function() {
  /*假设这是ajax获取的json数据 -- 假设这是后台给你的数据*/


    /*实例1*/
    var product1 = new Product()
    product1.name = 'SKII'
    product1.price = 1111
    product1.youhuijia = 1000
    product1.sales = 300
    product1.zhekou = 3.5
    product1.image = 'img/boutque10_r2_c2.jpg'

    /*实例2*/
    var product2 = new Product()
    product2.name = '玉兰油'
    product2.price = 1111
    product2.youhuijia = 1000
    product2.sales = 300
    product2.zhekou = 3.5
    product2.image = 'img/boutque10_r2_c2.jpg'

    /*实例3*/
    var product3 = new Product()
    product3.name = '兰蔻'
    product3.price = 1111
    product3.youhuijia = 1000
    product3.sales = 300
    product3.zhekou = 3.5
    product3.image = 'img/boutque10_r2_c2.jpg'



    /*表示有多个产品  我们需要定义多个实例*/
    var products = [product1,product2,product3]

    /*前端代码*/
    /*前后台开发不影响，我们不必等待后端人员给我们数据*/
    var str=''
    for(var i = 0,len=products.length;i<len;i++) {
        str+= products[i].bindDom()
    }
    var container = document.getElementById('container')
    container.innerHTML=str
}