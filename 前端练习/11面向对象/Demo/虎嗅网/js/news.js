/*
* @Author: liupuyan
* @Date:   2017-02-21 16:25:12
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-02-21 16:36:49
*/

function News(){
    this.title=''
    this.introduce=''
    this.comments=0
    this.date=''
    this.author=''
    this.source='РВАЛНш'
    this.image='images/head.jpg'
    this.content=''
}
News.prototype={
    bindDetailDom:function(dom){
        var str = ''
        str+='<h1>'+this.title+'</h1>'
        str+='<div class="other">'
            str+='<u>'+this.author+'</u>|'
            str+='<time>'+this.date+'</time>|'
            str+='<i><a href="">评论('+this.comments+')</a></i>'
        str+='</div>'
        str+='<table cellpadding="0" cellspacing="0" class="neirong-box" >'
            str+='<tbody>'
            str+='<tr>'
            str+='<td id="article_content">'
            str+=this.content
            str+='</td>'
            str+='</tr>'
            str+='</tbody>'
        str+='</table>'
        dom.innerHTML = str;
    },
    bindListDOM:function(){
        var str = ''
        str+='<li>'
            str+='<a href="detail.html">'
                str+='<b>'+this.title+'</b>'
                 str+='<span><img src='+this.image+' width="120" height="80"/></span>'
                str+=this.introduce
            str+='</a>'
            str+='<p class="p-btm">'
                str+='<u>'+this.source+'</u>|'
                str+='<time>'+this.date+'</time>|'
                str+='<i><a href="get_comment/26039/1">评论('+this.comments+')</a></i>'
            str+='</p>'
        str+='</li>'

        return str;
    }
}