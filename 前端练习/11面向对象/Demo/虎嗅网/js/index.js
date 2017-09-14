/*
* @Author: liupuyan
* @Date:   2017-02-21 16:27:51
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-02-21 16:28:06
*/

window.onload =function(){
    var data=[
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'},
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'},
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'},
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'},
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'},
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'},
        {title:'腾讯入股京东',comments:100,source:'新浪网',date:'2014-09-09',image:'images/head.jpg',introduce:'“京东+微信”，抑或是“易迅+微信+京东”，之于京东，之于腾讯电商，都是很有想象力的，是打一次翻身仗的机'}
    ]
    var str=''
    var container  = document.getElementById('container')

    for(var i= 0,len=data.length;i<len;i++) {
        var news = new News()
        news.title='腾讯入股京东'
        news.comments=data[i].comments
        news.date=data[i].date
        news.image=data[i].image
        news.source=data[i].source
        news.introduce=data[i].introduce
        str+= news.bindListDOM()
    }
    container.innerHTML=str;
}