<template>
    <!-- 弹窗 -->
    <div style="border: 0;">
        <!-- 添加产品窗口 -->
        <div v-if="showAddProduct" class="page_container">
            <div v-if="showAddProduct" class="div_AddProduct">
                <div class="center-container">
                    <el-row style="margin-top: 5px;">
                        <el-col :span="24"><span>添加产品</span></el-col>
                    </el-row>
                </div>
                <el-row style="margin-top:50px; margin-left: 20px">
                    <el-col :span="12">
                        <span>产品名称：</span><el-input v-model="AddProductName" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </el-col>
                    <el-col :span="12">
                        <span>产品价格：</span><el-input v-model="AddProductPrice" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </el-col>
                </el-row>
                <div class="center-container">
                    <el-row :gutter="250">
                        
                        <el-col :span="12" class="centered-col">
                            <!-- <div class="center-container"> -->
                                <el-button @click="showAddProduct = false">取消</el-button>
                            <!-- </div> -->
                        </el-col>
                        <el-col :span="12" class="centered-col">
                            <!-- <div class="center-container"> -->
                                <el-button @click="AddProduct()">添加</el-button>
                            <!-- </div> -->
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>

        <!-- 编辑产品 -->
        <div v-if="showEditProduct" class="page_container">
            <div v-if="showEditProduct" class="div_EditProduct">
                <div class="center-container">
                    <el-row style="margin-top: 5px;">
                        <el-col :span="24"><span>添加产品</span></el-col>
                    </el-row>
                </div>
                <el-row style="margin-top:50px; margin-left: 20px">
                    <el-col :span="12">
                        <span>产&nbsp;品&nbsp;&nbsp;&nbsp;ID：</span><el-input v-model="EditProductID" placeholder="请输入内容" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                    <el-col :span="12">
                        <span>产品名称：</span><el-input v-model="EditProductName" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </el-col>
                </el-row>
                <el-row style="margin-top:10px; margin-left: 20px">
                    <el-col :span="12">
                        <span>产品状态：</span>
                        <el-input v-model="EditProductStatus" placeholder="请输入上架/下架" type="text" :clearable="true"></el-input>
                    </el-col>
                    <el-col :span="12">
                        <span>产品价格：</span><el-input v-model="EditProductPrice" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </el-col>
                </el-row>
                <el-row style="margin-top:10px; margin-left: 20px">
                    <el-col :span="12">
                        <span>上架时间：</span><el-input v-model="EditProductOn" placeholder="请输入内容" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                    <el-col :span="12">
                        <span>下架时间：</span><el-input v-model="EditProductOff" placeholder="请输入内容" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                </el-row>
                <div class="center-container">
                    <el-row :gutter="250">
                        <el-col :span="12" class="centered-col">
                            <!-- <div class="center-container"> -->
                                <el-button @click="editProduct()">确定</el-button>
                            <!-- </div> -->
                        </el-col>
                        <el-col :span="12" class="centered-col">
                            <!-- <div class="center-container"> -->
                                <el-button @click="showEditProduct = false">取消</el-button>
                            <!-- </div> -->
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>

        <!-- 删除产品确认窗口 -->
        <div v-if="showDeleteProduct" class="page_container">
            <div v-if="showDeleteProduct" class="div_DeleteProduct">
                <div class="center-container">
                    <el-row :gutter="250">
                        <el-col :span="24">
                            <span>确定删除该产品吗？</span>
                        </el-col>
                    </el-row>
                    
                </div>
                <div class="center-container_delete_product">
                    <el-row :gutter="250">
                        <el-col :span="12">
                                <el-button @click="DeleteProduct()">确定</el-button>
                        </el-col>
                        <el-col :span="12">
                                <el-button @click="showDeleteProduct = false">取消</el-button>
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>

        <!-- 下单窗口 -->
        <div v-if="showPlace_an_order_window" class="page_container">
            <div v-if="showPlace_an_order_window" class="div_Place_an_order_window">
                <div class="center-container">
                    <el-row :gutter="250">
                        <el-col :span="24">
                            <span>创建订单</span>
                        </el-col>
                    </el-row>
                </div>

                <el-row style="margin-top:20px; margin-left: 20px">
                    <el-col :span="12">
                        <span>产&nbsp;品&nbsp;&nbsp;&nbsp;ID：</span><el-input v-model="EditProductID" placeholder="请输入内容" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                    <el-col :span="12">
                        <span>产品名称：</span><el-input v-model="EditProductName" placeholder="请输入内容" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                </el-row>
                <el-row style="margin-top:10px; margin-left: 20px">
                    <el-col :span="12">
                        <span>产品状态：</span>
                        <el-input v-model="EditProductStatus" placeholder="请输入上架/下架" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                    <el-col :span="12">
                        <span>产品价格：</span><el-input v-model="EditProductPrice" placeholder="请输入内容" type="text" :clearable="true" disabled></el-input>
                    </el-col>
                </el-row>
                <el-row style="margin-top:10px; margin-left: 20px">
                    <el-col :span="24">
                        <span>订单数量：</span>
                        <!-- <template>  选择器i不显示，待解决
                            <el-input-number v-model="Order_Quantity" :min="1" :max="10" @change="handleChange"></el-input-number>
                        </template> -->
                        <el-input v-model="Order_Quantity" placeholder="请输入下单数量" type="text" :clearable="true" ></el-input>
                    </el-col>
                </el-row>

                <div class="center-container_place_an_order">
                    <el-row :gutter="250">
                        <el-col :span="12">
                                <el-button @click="Place_an_order()">确定</el-button>
                        </el-col>
                        <el-col :span="12">
                                <el-button @click="showPlace_an_order_window = false">取消</el-button>
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>
    </div>
    <el-scrollbar height="calc(100vh - 60px)">
        <div style="background-color: #ffffff; margin-top: 20px; margin-left: 20px; margin-right: 20px; border-radius: 10px;">
            <form>
            <el-row :gutter="20" class="el-row-div1">
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" >
                        <div>产品ID：</div>
                        <el-input v-model="ProductID" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </div>
                </el-col>
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" >
                        <div>产品名称：</div>
                            <el-input v-model="ProductName" placeholder="请输入内容" type="text" :clearable="true"></el-input>
                    </div>
                </el-col>
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" >
                        <div>产品状态：</div>
                        <el-select v-model="ProductStatus" class="m-2" placeholder="Select" size="default" :clearable="true">
                            <el-option
                              v-for="item in options"
                              :key="item.value"
                              :label="item.label"
                              :value="item.value"
                            />
                        </el-select>
                    </div>
                </el-col>
                <el-col :span="6">
                    <div class="grid-content ep-bg-purple" >
                        <div>
                            <el-button @click="sreachProduct()" type="default" :icon="Search">搜索</el-button>
                        </div>
                    </div>
                </el-col>
            </el-row>
            </form>
        </div>
        <div style="margin: 30px"><el-button plain @click="showAddProduct = true">添加产品</el-button></div>
        <div style="background-color: #ffffff; margin-top: 20px; margin-left: 20px; margin-right: 20px; border-radius: 10px;">
            <el-row>
                <el-col :span="24">
                    <div class="example-pagination-block">
                        <el-table :data="tableData" style="margin-left: 30px; margin-right: 30px;" class="example-demonstration">
                            <el-table-column prop="id" label="ID" min-width="5%" show-overflow-tooltip/>
                            <el-table-column prop="Name" label="产品名称" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="status" label="产品状态" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="price" label="产品价格" min-width="10%" show-overflow-tooltip/>
                            <el-table-column prop="on" label="上架时间" min-width="20%" show-overflow-tooltip/>
                            <el-table-column prop="off" label="下架时间" min-width="20%" show-overflow-tooltip/>
                            <el-table-column prop="place_an_order" label="下单" min-width="5%" show-overflow-tooltip>
                                <template v-slot="scope">
                                    <span class="place_an_order" @click="place_an_order(scope.row);">下单</span>
                                </template>
                            </el-table-column>
                            <el-table-column prop="operate" label="操作" min-width="20%" show-overflow-tooltip>
                                <template v-slot="scope">
                                    <el-button type="primary" icon="Edit" @click="editRow(scope.row);">编辑</el-button>
                                    <el-button type="danger" icon="Delete" @click="deleteRow(scope.row)">删除</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                </el-col>
            </el-row>
        </div>
        
    </el-scrollbar>
    
</template>

<script>
import { Search, Edit, Delete } from '@element-plus/icons-vue';
import { convertDateFormat } from "@/assets/js/dateUtils";
import config from '@/components/config.json';
import { ElMessage } from 'element-plus'
export default {
    data() {
        return {
            //图标
            Search, Edit, Delete,
            //消息提示
            ElMessage,
            showEditProduct: null,
            showDeleteProduct: null,
            showPlace_an_order_window: null,
            showAddProduct: false,
            AddProductName: null,
            AddProductPrice: null,
            ProductID: null,
            ProductName: null,
            ProductStatus: null,
            EditProductID: null,
            EditProductName: null,
            EditProductStatus: null,
            EditProductPrice: null,
            EditProductOn: null,
            EditProductOff: null,
            Order_Quantity: 1,
            options: [
                {
                  value: '已上架',
                  label: '已上架',
                },
                {
                  value: '已下架',
                  label: '已下架',
                },
            ],
            tableData: [],
            backendUrl: config.backendUrl,
        }
    },
    mounted() {
      this.sreachProduct()
    },
    methods: {
        AddProduct() {
            const AddProductData = {
                AddProductName: this.AddProductName,
                AddProductPrice: this.AddProductPrice,
                AddProduct: null
            }
            fetch(config.backendUrl + '/Product_Add_Query', {
                method: 'post',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify(AddProductData),
                mode: 'cors',
            })
            this.ElMessage({
                message: '产品添加成功！',
                type: 'success',
            })
            this.showAddProduct = false
            this.sreachProduct()
        },
        sreachProduct() {
            const ProductData = {
                ProductID: this.ProductID,
                ProductName: this.ProductName,
                ProductStatus: this.ProductStatus,
                SearchProduct: null
            }
            //发起post请求
            fetch(config.backendUrl + '/Product_Add_Query', {
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
                    this.tableData = []
                    for (const i in response.data) {
                      const table_data = {
                        id: response.data[i][0],
                        Name: response.data[i][1],
                        status: response.data[i][2],
                        price: response.data[i][3],
                        on: convertDateFormat(response.data[i][4]),
                        off: convertDateFormat(response.data[i][5]),
                      }
                      if ( table_data['off'] == 'NaN-NaN-NaN NaN:NaN:NaN')  {
                        table_data['off'] = ''
                      }
                      this.tableData.push(table_data)
                    }
                }
            })
        },
        place_an_order(row) {
            this.EditProductID = row['id']
            this.EditProductName = row['Name']
            this.EditProductStatus = row['status']
            this.EditProductPrice = row['price']
            this.showPlace_an_order_window = true
        },
        Place_an_order() {
            const ProductData = {
                Order_Quantity: this.Order_Quantity,
                ProductName: this.EditProductName,
                ProductPrice: this.EditProductPrice ,
                place_an_order: null
            }
            fetch(config.backendUrl + '/place_an_order', {
                method: 'post',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify(ProductData),
                mode: 'cors',
            })
            .then(response => response.json())
            .then(response => {
                if (response.error_code == 0 && response.msg == '插入完成') {
                    this.ElMessage({
                        message: '产品下单成功！',
                        type: 'success',
                    })
                    this.showPlace_an_order_window = false
                    this.sreachProduct()
                } else {
                    this.ElMessage({
                        message: '产品下单失败！',
                        type: 'error',
                    })
                    this.showPlace_an_order_window = false
                    this.sreachProduct()
                }
            })
            .catch( err => {
                console.log(err)
                this.ElMessage({
                        message: '产品下单失败！',
                        type: 'error',
                    })
                this.showPlace_an_order_window = false
                this.sreachProduct()
            })
        },
        editRow(row) {
            // 编辑行的逻辑，你可以在这里打开一个编辑对话框或者跳转到编辑页面
            this.EditProductID = row['id']
            this.EditProductName = row['Name']
            this.EditProductStatus = row['status']
            this.EditProductPrice = row['price']
            this.EditProductOn = row['on']
            this.EditProductOff = row['off']
            this.showEditProduct=true
        },
        editProduct() {
            const ProductData = {
                ProductID: this.EditProductID,
                ProductName: this.EditProductName,
                ProductStatus: this.EditProductStatus,
                ProductPrice: this.EditProductPrice ,
                EditProduct: null
            }
            fetch(config.backendUrl + '/Edit_Del_Product', {
                method: 'post',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify(ProductData),
                mode: 'cors',
            })
            this.ElMessage({
                message: '产品更新成功！',
                type: 'success',
            })
            this.showEditProduct = false
            this.sreachProduct()

        },
        deleteRow(row) {
            // 删除行的逻辑，你可以在这里弹出确认框，并根据用户的选择执行删除操作
            this.EditProductID = row['id']
            this.showDeleteProduct = true
        },
        DeleteProduct() {
            const ProductData = {
                ProductID: this.EditProductID,
                DeleteProduct: null
            }
            fetch(config.backendUrl + '/Edit_Del_Product', {
                method: 'post',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify(ProductData),
                mode: 'cors',
            })
            .then(response => response.json())
            .then(response => {
                if (response.error_code == 0 && response.msg == '删除完成') {
                    this.ElMessage({
                        message: '产品删除成功！',
                        type: 'success',
                    })
                    this.showDeleteProduct = false
                    this.sreachProduct()
                } else {
                    this.ElMessage({
                        message: '产品操作失败！',
                        type: 'success',
                    })
                    this.showDeleteProduct = false
                    this.sreachProduct()
                }
            })
        },
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

    .el-input {
        width: 60%;
    }
    
    .el-table {
        width: auto;
    }

    .place_an_order:hover {
        color: rgb(20, 192, 14);
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s;
    }

    .example-pagination-block + .example-pagination-block {
      margin-top: 10px;
    }
    .example-pagination-block .example-demonstration {
      margin-bottom: 16px;
    }

    .div_AddProduct {
        position: absolute;
        top: 15%;
        left: 20%;
        width: 700px;
        height: 300px;
        border: 1px solid #ffffff;
        background-color: #ffffff;
        box-shadow: 0px 0px 10px #222222;
        z-index: 9999;
    }
    .div_EditProduct {
        position: absolute;
        top: 15%;
        left: 20%;
        width: 700px;
        height: 400px;
        border: 1px solid #ffffff;
        background-color: #ffffff;
        box-shadow: 0px 0px 10px #222222;
        z-index: 9999;
    }

    .div_DeleteProduct {
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

    .div_Place_an_order_window {
        position: absolute;
        top: 25%;
        left: 25%;
        width: 500px;
        height: 320px;
        border: 1px solid #ffffff;
        background-color: #ffffff;
        box-shadow: 0px 0px 10px #222222;
        z-index: 9999;
    }

    .center-container_place_an_order {
        display: flex;
        justify-content: center; /* 水平居中 */
        margin-top: 20px;
    }

    .center-container_delete_product {
        display: flex;
        justify-content: center; /* 水平居中 */
        margin-top: 50px;
    }
    .center-container {
        display: flex;
        justify-content: center; /* 水平居中 */
        align-items: center; /* 垂直居中 */
        margin-top: 50px;
    }
    .centered-col {
        text-align: center;
    }
    #cours {
        display: none;
    }
    #cours option {
        font-size: 16px;
        background-color: #ffffff;

    }
</style>
