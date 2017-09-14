/*
* @Author: liupuyan
* @Date:   2017-02-21 16:51:36
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-02-21 16:58:51
*/

//页面的业务逻辑
$(document).ready(function(){

    
	/*定义对象*/
	//定义产品对象
	function Product(){
	    this.name='HM休闲服登山包'
	    this.description='棒棒的，棒棒的，登山一流，服务一流，你好，我好，他也好，太棒了，一口气等上珠穆朗玛峰'
	    this.normalPrice=144
	    this.groupbuyPrice=120
	    this.buySum=100;
	    this.images=[
	        {small:'../images/s11.jpg',big:'../images/s11.jpg'},
	        {small:'../images/s12.jpg',big:'../images/s12.jpg'},
	        {small:'../images/s13.jpg',big:'../images/s13.jpg'}
	    ]
	}
	Product.prototype={
	    /*普通购买*/
	    buy:function(){},
	    bindDOMImage:function(){
	        var str=''
	        for(var i= 0,len=this.images.length;i<len;i++) {
	            str+='<li>'
	            str+='<img class="etalage_thumb_image" src="'+ this.images[i].small+'" class="img-responsive" />'
	            str+='<img class="etalage_source_image" src="'+ this.images[i].small+'" class="img-responsive" />'
	            str+='</li>'
	        }
	        $('#etalage').html(str)

	        /*jquery插件实现的幻灯片特效*/
	        $('#etalage').etalage({
	            thumb_image_width: 300,
	            thumb_image_height: 400,

	            show_hint: true,
	            click_callback: function(image_anchor, instance_id){
	                alert('Callback example:\nYou clicked on an image with the anchor: "'+image_anchor+'"\n(in Etalage instance: "'+instance_id+'")');
	            }
	        });
	        // This is for the dropdown list example:
	        $('.dropdownlist').change(function(){
	            etalage_show( $(this).find('option:selected').attr('class') );
	        });
	    },
	    bindDOMDetail:function(){
	        /*绑定元素*/
	        $('#pname').html(this.name)
	        $('#description').html(this.description)
	        $('#price').html(this.normalPrice)
	        $('#groupPrice').html(this.groupbuyPrice)
	        $('#buyCount').html(this.buySum)
	    },
	    /*团购*/
	    groupBuy:function(){},
	    /*添加到购物车*/
	    addCart:function(){

	    }
	}


    /*产品相关*/
    /*实例化*/
    var product =  new Product()
    product.name='HM最新款式登山运动服11'
    product.description='棒棒的，棒棒的，登山一流，服务一流，你好，我好，他也好，太棒了，一口气等上珠穆朗玛峰'
    product.normalPrice=144
    product.groupbuyPrice=120
    product.buySum=100;
    product.images=[
        {small:'images/s11.jpg',big:'images/s11.jpg'},
        {small:'images/s12.jpg',big:'images/s12.jpg'},
        {small:'images/s13.jpg',big:'images/s13.jpg'}
    ]


    /*绑定元素*/
    $('#pname').html(product.name)
    $('#description').html(product.description)
    $('#price').html(product.normalPrice)
    $('#groupPrice').html(product.groupbuyPrice)
    $('#buyCount').html(product.buySum)
    /*绑定图片 幻灯片*/
    product.bindImage()


    /*绑定事件*/
    $('#btnaddcart').onclick=function(){

    }
    $('#btnbuy').onclick=function(){}
});