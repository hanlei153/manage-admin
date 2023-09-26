export default {
    data() {
        return {
            tableData: [],    //用于存储列表的数据
            tableHeight: '500', //列表的初始高度
            currentPage: 1,    //当前页
            pageSize: 20,   //每页的容量
            total: 0,   //列表总数
            loading: false, //列表的数据加载loading状态
        }
    }
}