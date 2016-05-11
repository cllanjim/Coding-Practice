/**
 * Created by SketchK on 15/11/20.
 */

//定义一个名为$的函数,
//该函数的作用是传入一个id参数,如果参数类型与string相同,则返回一个与id名相同的标签;否则返回原参数
function $(id){
    return typeof id === 'string' ? document.getElementById(id) : id;
}

//当网页加载完毕
window.onload = function () {
    //拿到标题标签
    //var titles = $('header').getElementsByTagName('li');

    var header = $('header');
    var titles = header.getElementsByTagName('li');
    //拿到内容标签
    var body = $('body');
    var divs = body.getElementsByClassName('dom');

    //如果数据不匹配就不进行下面的操作
    if(titles.length != divs.length) return;

    //先去标题里拿标题
    for(var i = 0; i < titles.length; i++){
        //标题栏中的标签
        var li = titles[i];
        //为每个标题标签设置id参数
        li.id = i;
        //监听鼠标的移动事件
        li.onmousemove = function(){
            //去内容里寻找对应的标签
            for(var j = 0; j < titles.length; j++){
                titles[j].className = '';
                divs[j].style.display = 'none';
            }
            //this指标题栏中被触发的标签
            //将被触发的标签设置为selected
            this.className = 'selected';
            //根据被触发的标签索引号寻找内容标签,并显示其内容
            divs[this.id].style.display = 'block';
        }
    }
}

