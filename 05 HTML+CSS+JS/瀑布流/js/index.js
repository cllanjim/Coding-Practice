/**
 * Created by SketchK on 15/11/20.
 */

//利用该函数可以获得对应id类型的标签
function $(id){
    return typeof id === 'string' ? document.getElementById(id) : id;
}

//当屏幕加载完毕时调用
window.onload = function(){
    //调用实现瀑布流布局的函数
    waterFall('main','box');
    window.onscroll = function(){
        //模拟加载时需要的图片数据
        var dataImg = {
            "data":[{"src":'30.jpg'},{"src":'31.jpg'},{"src":'32.jpg'},{"src":'33.jpg'},{"src":'34.jpg'},{"src":'35.jpg'}]
        }

        //判断是否具备加载条件
        if(checkWillScroll){
            for(var i = 0; i < dataImg.data.length; i++){
                var newBox = document.createElement('div');
                newBox.className = 'box';
                $('main').appendChild(newBox);

                var newPic = document.createElement('div');
                newPic.className = 'pic';
                newBox.appendChild(newPic);

                var newImg = document.createElement('img');
                newImg.src = 'images/'+dataImg.data[i].src;
                newPic.appendChild(newImg);
            }

            waterFall('main', 'box');
        }
    }
}

function waterFall(parent,box){
    //通过这个方法拿到main中的所有box标签
    var allBoxs = $(parent).getElementsByClassName(box);
    //获得标签的标准宽度
    var boxW = allBoxs[0].offsetWidth;
    //拿到客户端的宽度
    var clientW = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    //计算列数
    var cols = Math.floor(clientW / boxW);
    //让父标签居中
    //此处需要确定main的大小后才能让其居中，否则其自身将填充整个背景本身就已经达到所谓居中
    $(parent).style.cssText = 'width:' + boxW * cols +'px;' + 'margin: 0 auto';

    // 定位

    //创建一个数组用来存储第一行中所有元素的高度
    var heightArr = [];
    //遍历每一个图片元素
    for(var i = 0; i < allBoxs.length; i++){
        //offsetHeight属性可以获取高度
        var boxH = allBoxs[i].offsetHeight;

        if(i < cols){
        //对第一行的元素进行计算,并将高度值保存到heightArr中
            heightArr.push(boxH);
        }else{
        //进入到else处代表将安置第一行以外的其他标签

            //取出第一排中最短的盒子
            var minBoxH = Math.min.apply(null,heightArr);
            //取出最短的盒子的索引
            var minBoxIndex = getMinIndex(minBoxH, heightArr);

            //对第i个盒子进行定位
            allBoxs[i].style.position = 'absolute';
            //对盒子的上部进行定位
            allBoxs[i].style.top = minBoxH + 'px';
            //对盒子的左部进行定位
            allBoxs[i].style.left = boxW * minBoxIndex + 'px';

            //更新被定位盒子的高度
            heightArr[minBoxIndex] += allBoxs[i].offsetHeight;
        }
    }
}

function getMinIndex(val, arr){
    for(var i = 0; i < arr.length; i++){
        if(arr[i] == val){
            return i;
        }
    }
}

function checkWillScroll(){
    //拿到所有的box标签元素
    var allBoxs = $('main').getElementsByClassName("box");

    //取出最后一个盒子
    var lastBox = allBoxs[allBoxs.length - 1];
    //取出最后一个盒子头部偏离的高度
    var offsetTop = lastBox.offsetTop;
    //取出最后盒子的高度的一半
    var lastBoxHalfHeight = Math.floor(lastBox.offsetHeight / 2);
    //取出页面顶端偏离浏览器的高度
    var offsetClientTopH = document.body.offsetTop || document.documentElement.offsetTop;
    //取出浏览器的高度
    var clientH = document.body.clientHeight || document.documentElement.clientHeight;

    //判断
    //如果当前页面的底部已经移动的最后一个box标签的一半时,就应当要加载新的图片
    return (offsetTop + lastBoxHalfHeight) < (offsetClientTopH + clientH) ? true : false;
}