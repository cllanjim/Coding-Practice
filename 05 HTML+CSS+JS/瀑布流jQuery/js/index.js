$(window).on('load',function(){
    //实现瀑布流效果
    waterFall();

    $(window).on('scroll',function(){
        var data = {"dataImg":[{"src":"0.jpg"},{"src":"2.jpg"},{"src":"5.jpg"},{"src":"8.jpg"},{"src":"10.jpg"}]};

        if(checkWillScoll){
            $.each(data.dataImg,function(index,value){
                var newBox = $('<div>').addClass('box').appendTo($('#main'));
                var newPic = $('<div>').addClass('pic').appendTo($(newBox));
                $('<img>').attr('src','images/'+$(value).attr('src')).appendTo($(newPic));
            });
            waterFall();
        }
    })
});


function waterFall(){
    //取出所有的盒子
    var allBoxs = $('#main>div');
    //求出盒子的宽度 outerWidth 包括外边框 width 净宽度
    var boxW = allBoxs.eq(0).outerWidth();
    //求出屏幕的宽度
    var clientW = $(window).width();
    //计算列数
    var cols = Math.floor(clientW / boxW);
    //让main标签居中
    $('#main').css({
        'width':boxW * cols + 'px',
        'margin':'0 auto'
    });
    //创建用于保存高度的数组
    var heightArr = [];

    $.each(allBoxs, function(index, value){
        //求出每个盒子的高度
        var boxH = $(value).outerHeight();
        if(index < cols){
            heightArr[index] = boxH;
        }else{
            //求出最矮盒子的高度
            var minBoxH = Math.min.apply(null, heightArr);
            //求出最矮盒子的索引
            var minBoxIndex = $.inArray(minBoxH,heightArr);
            //定位
            var box = allBoxs[index];
            $(box).css({
                'position':'absolute',
                'top': minBoxH + 'px',
                'left':minBoxIndex * $(box).outerWidth() + 'px'
            });
            heightArr[minBoxIndex] += boxH;
        }

    })

}

function checkWillScoll(){
    //拿到最后一个盒子
    var lastBox = $('#main>div').last();
    //求出盒子自身高度的一半 + 盒子头部偏离的高度
    var lastBoxDis = $(lastBox).offset().top + Math.floor($(lastBox).offset().height / 2);
    //求出页面偏离的高度
    var topScrollH = $(window).offset().top;
    //求出浏览器的高度
    var clientH = $(window).height();

    return lastBoxDis < (topScrollH + clientH) ? true :false;

}