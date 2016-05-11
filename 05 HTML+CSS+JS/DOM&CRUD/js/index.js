/**
 * Created by SketchK on 15/11/19.
 */
//js的CRUD

//创建
//1
document.write('<img src = "images/img_01.jpg">');
document.write('<input type="date">');
//2
var p = document.createElement('p');
p.innerHTML = '标签一';
p.style.color='red';
//添加到body
document.body.appendChild(p);

var input = document.createElement('input');
p.appendChild(input);

//删除
var div = document.getElementById('word');
//1
div.parentNode.removeChild(div);
document.body.removeChild(div);
//2
div.remove();

//查询
console.log(document.body.outerHTML);
console.log("-------------------");
console.log(document.body.innerHTML);