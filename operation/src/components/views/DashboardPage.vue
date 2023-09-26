<template>
  <el-scrollbar height="calc(100vh - 50px)">
  <div>
    <el-row>
      <el-col :span="24" class="data">
        <span>数据</span>
        <Refresh class="refresh-icon" @click="refresh_data()"/>
        <span>更新时间：xxxxxxxxxx</span>
      </el-col>
    </el-row>
    
    <el-row :gutter="30">
      <el-col :span="6" @click="totalSales(); totalSales_sum()">
        <div class="div1 div1-left" >
          <div><img src="../../assets/img/理财.png" class="licai_logo"/></div>
          <div class="wenzi">
            <div class="wenzi_span1"><span>销售额</span></div>
            <div class="wenzi_span2"><span>总额：{{ totalSales_sum_total }}</span></div>
            <div class="wenzi_span2"><span>当月：{{ totalSales_sum_month }}</span></div>
          </div>
        </div>
      </el-col>

      <el-col :span="6" @click="category_data()">
        <div class="div1" >
          <div><img src="../../assets/img/理财.png" class="licai_logo"/></div>
          <div class="wenzi">
            <span>产品分类数据</span>
          </div>
      </div></el-col>

      <el-col :span="6"><div class="div1" >
        <div><img src="../../assets/img/理财.png" class="licai_logo"/></div>
          <div class="wenzi"><span>无</span></div>
      </div></el-col>

      <el-col :span="6" @click="Transaction_quantity(); Transaction_counts()">
        <div class="div1 div1-right" >
          <div><img src="../../assets/img/理财.png" class="licai_logo"/></div>
          <div class="wenzi">
            <div class="wenzi_span1"><span>交易数量</span></div>
            <div class="wenzi_span2"><span>总量：{{ Transaction_count_total }}</span></div>
            <div class="wenzi_span2"><span>当月：{{ Transaction_count_month }}</span></div>
          </div>
        </div>
      </el-col>
    </el-row>

    <el-row>
      <el-col :span="24">
        <div id="myChart" class="div2"></div>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="8">
        <div id="myPie" class="div3 div3-left"></div>
      </el-col>
      <el-col :span="8">
        <div class="div3">暂无数据~</div>
      </el-col>
      <el-col :span="8">
        <div class="div3 div3-right">暂无数据~</div>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="8">
        <div class="div3 div3-left">暂无数据~</div>
      </el-col>
      <el-col :span="8">
        <div class="div3">暂无数据~</div>
      </el-col>
      <el-col :span="8">
        <div class="div3 div3-right">暂无数据~</div>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="8">
        <div class="div3 div3-left">暂无数据~</div>
      </el-col>
      <el-col :span="8">
        <div class="div3">暂无数据~</div>
      </el-col>
      <el-col :span="8">
        <div class="div3 div3-right">暂无数据~</div>
      </el-col>
    </el-row>
  </div>
  </el-scrollbar>
  
</template>

<script>
    import config from '../config.json';
    import { Refresh } from "@element-plus/icons-vue";
    import theme from '@/assets/js/theme';
    import { formatDate, getFirstDayOfMonth, getLastDayOfMonth } from '@/assets/js/dateUtils';
    // import { formatNumber } from '@/assets/js/formatNumber';
    export default {
      data() {
        return {
            // 图标
            Refresh,
            // 图表数据
            title: '销售数据',
            xAxis_name: '时间',
            xAxis_data: [],
            yAxis_name: '元/日',
            yAxis_Label_formatter: '￥{value}',
            series: [],
            myPieSeriesData: [],
            Transaction_count_total: null,
            Transaction_count_month: null,
            totalSales_sum_total: null,
            totalSales_sum_month: null
        }
      },
      mounted() {
        this.myPie();
        this.Transaction_counts();
        this.totalSales_sum();
        this.totalSales();
        this.myPie_sum();
      },
      methods: {
        refresh_data() {
            fetch( 
                config.backendUrl + 'refresh_data', 
                {
                    method: 'get',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    mode: 'cors',
                }
            )
        },
        Transaction_counts(){
          const data = {
            Transaction_counts: null,
            start_time: formatDate(getFirstDayOfMonth()),
            end_time: formatDate(getLastDayOfMonth()),
          }
          fetch(config.backendUrl + '/total_counts', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '查询完成') {
              this.Transaction_count_month = response.month_select_result[0]
              this.Transaction_count_total = response.total_select_result[0]
            }
          })
          
        },
        totalSales_sum() {
          const data = {
            totalSales_sum: null,
            start_time: formatDate(getFirstDayOfMonth()),
            end_time: formatDate(getLastDayOfMonth()),
          }
          fetch(config.backendUrl + '/total_counts', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '查询完成') {
              this.totalSales_sum_month = response.month_select_result[0]
              this.totalSales_sum_total = response.total_select_result[0]
            }
          })
        },
        totalSales() {
          const data = {
            totalSales: null,
            start_time: formatDate(getFirstDayOfMonth()),
            end_time: formatDate(getLastDayOfMonth()),
          }
          fetch(config.backendUrl + '/totalSales', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '查询完成') {
              const myChart = document.getElementById('myChart')
              myChart.removeAttribute("_echarts_instance_")
              const xAxis_data = []
              const series_data1 = []
              const series_data2 = []
              for (const [key, value] of Object.entries(response.data)) {
                xAxis_data.push(key)
                series_data1.push(value.sales)
                series_data2.push(value.refunds)
              }
              this.xAxis_data = xAxis_data
              this.yAxis_Label_formatter = '￥{value}'
              this.yAxis_name = '元/日'
              this.series = [
                {
                  name: '销售额',
                  data: series_data1,
                  type: 'line',
                  // stack: 'samesign',
                  markPoint: {
                    symbolSize: 65,
                    data: [
                      { type: 'max', name: 'Max' },
                    ]
                  },
                },
                {
                  name: '退款额',
                  data: series_data2,
                  type: 'line',
                  // stack: 'samesign',
                  markPoint: {
                    symbolSize: 65,
                    data: [
                      { type: 'max', name: 'Max' },
                    ]
                  },
                }
              ]

              this.drawLine();
            } else {
              console.log('查询异常')
            }
          })
        },
        category_data() {
          const data = {
            category_data: null,
            start_time: formatDate(getFirstDayOfMonth()),
            end_time: formatDate(getLastDayOfMonth()),
          }
          fetch(config.backendUrl + '/totalSales', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '查询完成') {
              const myChart = document.getElementById('myChart')
              myChart.removeAttribute("_echarts_instance_")
              const series_data = []
              for (const key in response.sales) {
                const seriesItem = {
                  name: key,
                  data: response.sales[key],
                  type: 'line',
                  // stack: 'samesign',
                  markPoint: {
                    symbolSize: 65,
                    data: [
                      { type: 'max', name: 'Max' },
                    ]
                  },
                }
                series_data.push(seriesItem)
              }
              this.series = series_data
              this.xAxis_data = response.date
            }
            this.drawLine();
          })
        },
        Transaction_quantity() {
          const data = {
            Transaction_quantity: null,
            start_time: formatDate(getFirstDayOfMonth()),
            end_time: formatDate(getLastDayOfMonth()),
          }
          fetch(config.backendUrl + '/totalSales', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '查询完成') {
              const myChart = document.getElementById('myChart')
              myChart.removeAttribute("_echarts_instance_")
              const xAxis_data = []
              const series_data = []
              for (const [key, value] of Object.entries(response.data)) {
                xAxis_data.push(key)
                series_data.push(value)
              }
              this.xAxis_data = xAxis_data
              this.yAxis_Label_formatter = '{value}次'
              this.yAxis_name = '次/日'
              this.series = [
                {
                  name: '交易次数',
                  data: series_data,
                  type: 'line',
                  // stack: 'samesign',
                  markPoint: {
                    symbolSize: 65,
                    data: [
                      { type: 'max', name: 'Max' },
                    ]
                  },
                },
              ]
              this.drawLine();
            } else {
              console.log('查询异常')
            }
          })
        },
        myPie_sum() {
          const data = {
            myPie_sum: null,
            start_time: formatDate(getFirstDayOfMonth()),
            end_time: formatDate(getLastDayOfMonth()),
          }
          fetch(config.backendUrl + '/totalSales', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '查询完成') {
              for (const i in response.data) {
                const Name = response.data[i][0]
                const Price = response.data[i][1]
                const pie_data = {
                  value: Price,
                  name: Name
                }
                this.myPieSeriesData.push(pie_data)
              }
              this.myPie()
            }
          })
        },
        myPie() {
          this.$echarts.registerTheme('theme', theme)
          const myPie = this.$echarts.init(document.getElementById("myPie"), 'theme')
          const option = {
            title: {
              text: '月度数据',
              padding: 10,
            },
            legend: {
              top: 'bottom'
            },
            series: [
                {
                  name: '月度数据',
                  type: 'pie',
                  data: this.myPieSeriesData,
                  // roseType: 'area',
                  radius: '50%',
                  percentPrecision: 0,
                  label: {
                    normal : {
                        formatter: '{b}: {c} ({d}%)',
                        textStyle : {
                            fontWeight : 'normal',
                            fontSize : 11
                        }
                    }
                  },
                }
              ]
            };
            myPie.setOption(option, );
       
        },
        drawLine()  {
          this.$echarts.registerTheme('theme', theme)
          const myChart = this.$echarts.init(document.getElementById("myChart"), 'theme')
          const option = {
            title: {
              text: this.title,
              padding: 10,
            },
            legend: {
              right: '20'
            },
            xAxis: {
              name: this.xAxis_name,
              type: 'category',
              data: this.xAxis_data,
            },
            yAxis: {
              type: 'value',
              name: this.yAxis_name,
              axisLabel: {
                formatter: this.yAxis_Label_formatter,
              }
            },
            series: this.series,
            tooltip: {
              show: true,
              trigger: 'axis',
              axisPointer: {
              type: 'line'
              }
            },
            toolbox: {
              show: true
            },
            animation: true,
            animationEasing: 'quarticInOut',

          };
            // 设置实例参数
            myChart.setOption(option, );
        }
      }
    }
    
</script>


<style>

  .data {
    display: flex;
    align-items: center;
    margin-top: 10px;
    margin-left: 30px;
  }

  .refresh-icon {
    width: 1.2em; 
    margin-top: 3px; 
    margin-left: 20px; 
    margin-right: 20px;
  }

  .refresh-icon:hover {
    cursor: pointer;
  }

  .div1 {
    display: flex;
    align-items: center;
    height: 130px;
    border: 1px;
    border-radius: 10px;
    background-color: rgb(250, 250, 250);
    margin-top: 20px;
  }
  .div1-left {
    margin-left: 30px;
  }
  .div1-right {
    margin-right: 30px;
  }

  .licai_logo {
    width: 70px;
    height: 70px;
    border-radius: 8px;
    margin-left: 40px;
  }

  .wenzi {
    position: relative; 
    left: 15%;
  }

  .wenzi_span1 {
    font-size: 15px;
    color: rgba(168, 168, 168, 0.884);
    margin-bottom: 8px;
  }

  .wenzi_span2 {
    font-size: 25px;
    color:rgba(48, 48, 48, 0.856);
  }

  .div2 {
    display: flex;
    flex: 1;
    align-items: center;
    justify-content: center;
    margin-top: 20px;
    margin-bottom: 20px;
    margin-left: 30px;
    margin-right: 27px;
    padding: 0px;
    height: 300px;
    border: 1px;
    border-radius: 10px;
    background-color: rgb(250, 250, 250);
  }
  .div3 {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 20px;
    margin-bottom: 20px;
    height: 350px;
    border: 1px;
    border-radius: 10px;
    background-color: rgb(250, 250, 250);
  }
  .div3-left {
    margin-left: 30px;
  }
  .div3-right {
    margin-right: 30px;
  }
</style>
