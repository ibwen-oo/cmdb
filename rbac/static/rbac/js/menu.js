// 动态展开/收起二级菜单
(function (jq) {
    jq('.menu-left .item .menu-title').click(function () {
        $(this).next().toggleClass('hide');
    });
})(jQuery);