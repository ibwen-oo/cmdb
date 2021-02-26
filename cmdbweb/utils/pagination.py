class Pagination:
    """
    自定义分页(Bootstrap版)
    """
    def __init__(self, request, total_data_count, pre_page_data=10, show_page_num=11, queryset=None):
        """
        :param request: 当前请求,用于查找请求路径、当前页等信息
        :param total_data_count: 总数据量
        :param pre_page_data: 每页显示几条数据
        :param show_page_num: 每页最多显示多少个页码
        :param queryset: 传入一个 QuerySet, 通过 QuerySet 计算数据量,功能未实现
        """
        self.request = request

        # 获取用户的请求参数
        import copy
        self.parms = copy.deepcopy(request.GET)
        # print(self.parms)
        # print(self.parms.urlencode())
        try:
            self.current_page = int(self.request.GET.get("page"))
        except Exception as e:
            # 获取页码失败默认展示第一页
            self.current_page = 1

        self.total_data_count = total_data_count
        self.base_url = self.request.path_info
        self.pre_page_data = pre_page_data
        self.show_page_num = show_page_num

        # 计算一共有多少页,
        # 如果总数据小于每页显示的数据,就只有一页
        if self.total_data_count <= self.pre_page_data:
            self.total_pages = 1
        else:
            self.total_pages, n = divmod(self.total_data_count, self.pre_page_data)
            if n:
                self.total_pages += 1
            self.half_pre_page_num = show_page_num // 2

        # 生成页码的 html 列表
        self.pagination_html_list = []

    @property
    def begin(self):
        """
        :return: 返回查询时每页数据的起始点
        示例：
        models.Book.objects.all()[.begin:.end]
        """
        return (self.current_page - 1) * self.pre_page_data

    @property
    def end(self):
        """
        :return: 返回查询时每页数据的结束点
        示例：
        models.Book.objects.all()[begin:.end]
        """
        return self.current_page * self.pre_page_data

    def get_start_end(self):
        # 计算页码范围
        # 处理总页数小于每个页面可以显示的页码数的情况
        if self.total_pages <= self.show_page_num:
            self._start_page_num = 1
            self._end_page_num = self.total_pages
        # 处理左边界(_start_page_num 小于1的情况)
        elif self.current_page - self.half_pre_page_num <= 1:
            self._start_page_num = 1
            self._end_page_num = self.show_page_num
        # 处理右边界(_end_page_num 大于 total_pages 的情况)
        elif self.current_page + self.half_pre_page_num >= self.total_pages:
            self._end_page_num = self.total_pages
            self._start_page_num = self._end_page_num - self.show_page_num + 1
        else:
            # 正常页码区间
            self._start_page_num = self.current_page - self.half_pre_page_num
            self._end_page_num = self.current_page + self.half_pre_page_num

        return self._start_page_num, self._end_page_num + 1

    def get_html_code(self):
        """
        实现页面跳转时保存用户的请求参数,而不是写死跳转到指定页数
        比如：
        用户请求地址: http://127.0.0.1:8000/books/?page=2&name=Tom&age=19
        self.parms 的值: <QueryDict: {'page': ['2'], 'name': ['Tom'], 'age': ['19']}>
        self.parms.urlencode() 的值: page=2&name=Tom&age=19
        :return:
        """
        self.pagination_html_list.append('<nav aria-label="Page navigation"><ul class="pagination">')
        # 添加首页
        self.parms["page"] = 1
        _page_first_li = '<li><a href="{}?{}">首页</a></li>'.format(self.base_url, self.parms.urlencode())
        self.pagination_html_list.append(_page_first_li)
        # 添加上一页
        if self.current_page == 1:
            _previous_page_li = '<li><a href="#" aria-label="Previous"><span aria-hidden="true">上一页</span></a></li>'
        else:
            _previous_page_num = self.current_page - 1
            self.parms["page"] = _previous_page_num
            _previous_page_li = '<li><a href="{}?{}" aria-label="Previous"><span aria-hidden="true">上一页</span></a></li>'.format(self.base_url, self.parms.urlencode())
        self.pagination_html_list.append(_previous_page_li)

        for page in range(*self.get_start_end()):
            # 给页码的 a 标签添加请求参数,页面跳转的时候请求参数不丢失
            self.parms["page"] = page
            # print(self.parms.urlencode())
            if page == self.current_page:
                li_tag = '<li class="active"><a href="{}?{}">{}</a></li>'.format(self.base_url, self.parms.urlencode(), page)
            else:
                li_tag = '<li><a href="{}?{}">{}</a></li>'.format(self.base_url, self.parms.urlencode(), page)
            self.pagination_html_list.append(li_tag)

        # 添加下一页
        if self.current_page == self.total_pages:
            _next_page_li = '<li><a href="#" aria-label="Next"><span aria-hidden="true">下一页</span></a></li>'
        else:
            _next_page_num = self.current_page + 1
            self.parms["page"] = _next_page_num
            _next_page_li = '<li><a href="{}?{}" aria-label="Next"><span aria-hidden="true">下一页</span></a></li>'.format(self.base_url, self.parms.urlencode())
        self.pagination_html_list.append(_next_page_li)

        # 添加尾页
        self.parms["page"] = self.total_pages
        _page_end_li = '<li><a href="{}?{}">尾页</a></li>'.format(self.base_url, self.parms.urlencode())
        self.pagination_html_list.append(_page_end_li)
        self.pagination_html_list.append('</ul></nav>')

        _pagination_html_str = "".join(self.pagination_html_list)

        return _pagination_html_str