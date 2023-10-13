<template>
     <!-- 弹窗 -->
     <div style="border: 0;">
        <!-- 退款确认窗口 -->
        <div v-if="showOrderRefund" class="page_container">
          <div v-if="showOrderRefund" class="div_OrderRefund">
              <div class="center-container">
                  <el-row :gutter="250">
                      <el-col :span="24">
                          <span>确定退款该笔订单吗？</span>
                      </el-col>
                  </el-row>
                  
              </div>
              <div class="center-container_OrderRefund">
                  <el-row :gutter="250">
                      <el-col :span="12">
                              <el-button @click="Refund2()">确定</el-button>
                      </el-col>
                      <el-col :span="12">
                              <el-button @click="showOrderRefund = false">取消</el-button>
                      </el-col>
                  </el-row>
              </div>
          </div>
        </div>

     </div>
     <el-scrollbar height="calc(100vh - 60px)">
        <div style="background-color: #ffffff; margin-top: 20px; margin-left: 20px; margin-right: 20px; border-radius: 10px;">
            <el-row :gutter="20" class="el-row-div1">
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" style="white-space: nowrap; margin-left: 20px;">
                        <div>订单ID：</div>
                        <el-input v-model="OrderID" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </div>
                </el-col>
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" style="white-space: nowrap;">
                        <div>产品名称：</div>
                            <el-input v-model="ProductName" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </div>
                </el-col>
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" style="white-space: nowrap; margin-left: 30px;">
                        <div>&nbsp;&nbsp;日期范围：</div>
                        <div class="daterange-picker">
                            <div class="block">
                                <el-date-picker
                                  v-model="daterange"
                                  type="daterange"
                                  unlink-panels
                                  range-separator="To"
                                  start-placeholder="Start date"
                                  end-placeholder="End date"
                                  :shortcuts="shortcuts"
                                  :size="size"
                                />
                            </div>
                        </div>
                    </div>
                </el-col>
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" >
                        <div>
                            <el-button @click="sreachOrder()" type="default" :icon="Search">搜索</el-button>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>

        <div style="background-color: #ffffff; margin-top: 20px; margin-left: 20px; margin-right: 20px; border-radius: 10px;">
            <el-row>
                <el-col :span="24">
                    <div class="example-pagination-block">
                        <el-table :data="tableData" style="margin-left: 30px; margin-right: 30px;" class="example-demonstration">
                            <el-table-column prop="Order_ID" label="订单ID" min-width="5%" show-overflow-tooltip/>
                            <el-table-column prop="Product_Name" label="产品名称" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="is_Refund" label="是否退款" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="Product_price" label="产品价格" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="Trading_Hours" label="交易时间" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="operate" label="操作" min-width="5%" show-overflow-tooltip>
                                <template v-slot="scope">
                                    <span class="refund" @click="Refund(scope.row);">退款</span>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                </el-col>
            </el-row>
        </div>
     </el-scrollbar>
</template>

<script scope>
import config from '@/components/config.json';
import { convertDateFormat } from "@/assets/js/dateUtils";
import { ElMessage } from 'element-plus'
import { ref } from 'vue'

export default {
    data() {
        return {
          ElMessage,
          showOrderRefund: false,
          OrderID: null,
          ProductName: null,
          Order_ID: null,
          Product_Name: null,
          is_Refund: null,
          Product_price: null,
          Trading_Hours: null,
          tableData: [],
          backendUrl: config.backendUrl,

          daterange: ref(''),
          shortcuts: [
  {
    text: 'Last week',
    value: () => {
      const end = new Date()
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
      return [start, end]
    },
  },
  {
    text: 'Last month',
    value: () => {
      const end = new Date()
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
      return [start, end]
    },
  },
  {
    text: 'Last 3 months',
    value: () => {
      const end = new Date()
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
      return [start, end]
    },
  },
]
        }
    },
    mounted() {
      this.sreachOrder()
    },
    methods: {
      sreachOrder() {
        const ProductData = {
                OrderID: this.OrderID,
                ProductName: this.ProductName,
                DateRange: this.daterange,
                searchOrder: null
            }
            console.log(ProductData)
            //发起post请求
            fetch(config.backendUrl + '/order_management', {
                method: 'post',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify(ProductData),
                mode: 'cors',
            })
            .then(response => response.json())
            .then(response => {
                if (response.error_code == 0 && response.msg == '查询完成') {
                    //
                    this.tableData = []
                    for (const i in response.data) {
                      const table_data = {
                        Order_ID: response.data[i][0],
                        Product_Name: response.data[i][1],
                        is_Refund: response.data[i][2],
                        Product_price: response.data[i][3],
                        Trading_Hours: convertDateFormat(response.data[i][4]),
                      }
                      if ( table_data['is_Refund'] == 0)  {
                        table_data['is_Refund'] = '否'
                      } else if (table_data['is_Refund'] == 1) {
                        table_data['is_Refund'] = '已退款'
                        }
                      this.tableData.push(table_data)
                    }
                }
            })
      },
      Refund(row) {
        this.Order_ID = row['Order_ID']
        this.showOrderRefund = true
      },
      Refund2() {
        const ProductData = {
          OrderID: this.Order_ID,
          Refund: null
        }
        fetch(config.backendUrl + '/order_management', {
            method: 'post',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(ProductData),
            mode: 'cors',
        })
        .then(response => response.json())
            .then(response => {
                if (response.error_code == 0 && response.msg == '更新完成') {
                    this.ElMessage({
                        message: '订单退款成功！',
                        type: 'success',
                    })
                    this.showOrderRefund = false
                    this.sreachOrder()
                } else {
                    this.ElMessage({
                        message: '订单退款失败！',
                        type: 'success',
                    })
                    this.showOrderRefund = false
                    this.sreachOrder()
                }
            })
      }
    }
}
</script>

<style>
    @import '../../../assets/css/page_container.css';
    .el-row {
        margin-bottom: 20px;
    }
    .grid-content {
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        min-height: 100px;
    }
    .center-container {
        display: flex;
        justify-content: center; /* 水平居中 */
        align-items: center; /* 垂直居中 */
        margin-top: 50px;
    }
    .div_OrderRefund {
        position: absolute;
        top: 25%;
        left: 30%;
        width: 500px;
        height: 200px;
        border: 1px solid #ffffff;
        background-color: #ffffff;
        box-shadow: 0px 0px 10px #222222;
        z-index: 9999;
    }
    .center-container_OrderRefund {
        display: flex;
        justify-content: center; /* 水平居中 */
        margin-top: 50px;
    }
    .refund:hover {
        color: rgb(20, 192, 14);
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s;
    }
    
    .daterange-picker {
      display: flex;
      width: 100%;
      padding: 0;
      flex-wrap: wrap;
    }
    
    .daterange-picker .block {
      padding: 30px 0;
      text-align: center;
      border-right: solid 1px var(--el-border-color);
      flex: 1;
    }
    
    .daterange-picker .block:last-child {
      border-right: none;
    }
    
    .daterange-picker .demonstration {
      display: block;
      color: var(--el-text-color-secondary);
      font-size: 14px;
      margin-bottom: 20px;
    }
</style>