<template>
  <!-- 弹窗 -->
  <div style="border: 0;">
    <!-- 弹出个人信息窗口 -->
    <div v-if="showProfileModal" class="page_container">
      <div v-if="showProfileModal" class="div_window">
        <!-- <span>个人信息</span> -->
        <span @click="showProfileModal = false" class="close-button">&times;</span>
        <div>
          <img  src="../assets/logo.png" alt="User Avatar">
        </div>
        <table class="message_table">
          <tr>
            <td class="table_td_left">姓名：</td>
            <td class="table_td_right">{{ userInfo.username }}</td>
          </tr>
          <tr>
            <td class="table_td_left">姓别：</td>
            <td class="table_td_right">{{ userInfo.sex }}</td>
          </tr>
          <tr>
            <td class="table_td_left">职位：</td>
            <td class="table_td_right">{{ userInfo.position }}</td>
          </tr>
          <tr>
            <td class="table_td_left">电话：</td>
            <td class="table_td_right">{{ userInfo.contactInfo }}</td>
          </tr>
          <tr>
            <td class="table_td_left">住址：</td>
            <td class="table_td_right">{{ userInfo.home_address }}</td>
          </tr>
        </table>
      </div>
    </div>
    
    <!-- 弹出修改密码框 -->
    <div v-if="showChangePass" class="page_container">
      <el-form :model="form" label-width="80px">
        <div v-if="showChangePass" class="div_window2">
          <span @click="showChangePass = false" class="close-button">&times;</span>
          <table class="ChangePass_table">
            <tr>
              <td class="table_td_left">
                原密码：
              </td>
              <td class="table_td_right">
                <input class="input_login" type="password" id="password1" v-model="password1" required>
              </td>
            </tr>
            <tr>
              <td class="table_td_left">
                新密码：
              </td>
              <td class="table_td_right">
                <input class="input_login" type="password" id="password2" v-model="password2" required>
              </td>
            </tr>
            <tr>
              <td class="table_td_left">
                确认新密码：
              </td>
              <td class="table_td_right">
                <input class="input_login" type="password" id="password3" v-model="password3" required>
              </td>
            </tr>
            <tr style="line-height: 50px;">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td rowspan="2"><el-button type="button" @click="showChangePass = false">取消</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<el-button type="submit" @click="ChangePass()">确定</el-button></td>
            </tr>
          </table>
          <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
        </div>
      </el-form>
    </div>

    <!-- 头像选项框 -->
    <!--    -->
    <div v-if="showOptions" class="user-options" @mouseover="cancelHideTimer()" @mouseout="startHideTimer()"> 
      <ul>
        <li @click="showProfileModal = true">个人信息</li>
        <li @click="showChangePass= true">修改密码</li>
        <li><router-link to="/login" class="custom_router_link">退&nbsp;&nbsp;&nbsp;&nbsp;出</router-link></li>
      </ul>
    </div>
  </div>

    <!-- 布局 -->
    <el-row>
      <!-- logo -->
      <el-col :span="3">
        <div class="log-menu-container">
          <div class="logo">
            <img src="../assets/logo.png" alt="Logo" />
            <span style="font-size: 20px;color: #ffffff;">后台管理</span>
          </div>
        </div>
      </el-col>

      <!-- 面包屑 -->
      <el-col :span="19">
        <el-breadcrumb class="bread">
          <el-breadcrumb-item to="/DashboardPage">首页</el-breadcrumb-item>
          <el-breadcrumb-item v-for="item in $route.matched" :key="item.path" :to="{ path: item?.path }">
            {{ item?.meta?.title }}
          </el-breadcrumb-item>
        </el-breadcrumb>
      </el-col>

      <!-- 用户信息 -->
      <el-col :span="2">
        <div class="user-info" @click="showOptions = true" @mouseout="startHideTimer()">
          <span>{{ userInfo.username }}&nbsp;</span>
          <img src="../assets/logo.png" alt="User Avatar" />
        </div>
      </el-col>

    </el-row>

    
    <el-row>
      <!-- 菜单栏 -->
      <el-col :span="3">
        <el-scrollbar height="calc(100vh - 50px)">
          <el-menu default-active="2" class="menu-style" background-color="#0D1B36" text-color="#ffffff">
            <router-link to="/DashboardPage" class="custom_router_link">
              <el-menu-item index="1">
                <el-icon><House /></el-icon>
                <template #title>
                  首页
                </template>
              </el-menu-item>
            </router-link>
            <el-sub-menu index="2">
                    <template #title>
                      <el-icon><Document /></el-icon>
                      <span>产品管理</span>
                    </template>
                    
                    <el-menu-item-group>
                      <router-link to="/Product/Enter_product" class="custom_router_link">
                        <el-menu-item index="2-1">
                          <span>产品管理</span>
                        </el-menu-item>
                      </router-link>
                      
                      <router-link to="/Product/ProductPage2" class="custom_router_link">
                        <el-menu-item index="2-2">
                          <span>产品2</span>
                        </el-menu-item>
                      </router-link>
                    </el-menu-item-group>
            </el-sub-menu>
            <el-sub-menu index="3">
                    <template #title>
                      <el-icon><PhoneFilled /></el-icon>
                      <span>销售数据</span>
                    </template>
                    <el-menu-item-group>
                      <router-link to="/Sales_Data/order_management" class="custom_router_link">
                        <el-menu-item index="3-1">
                         <span>订单管理</span>
                        </el-menu-item>
                      </router-link>
                      <router-link to="/Sales_Data/OrderPage2/OrderPage2-1" class="custom_router_link">
                        <el-sub-menu index="3-2">
                          <template #title>其他2</template>
                          <el-menu-item index="3-2-1">
                            <span>其他2-1</span>
                          </el-menu-item>
                      </el-sub-menu>
                    </router-link>
                    </el-menu-item-group>
            </el-sub-menu>
          </el-menu>
        </el-scrollbar>
      </el-col>
      
      <el-col :span="21" style="background-color: rgba(227, 228, 230, 0.753);">
        <!-- 路由渲染位置 -->
        <router-view></router-view>
      </el-col>
    </el-row>
        
</template>

<script>
    import { useRoute } from 'vue-router';
    import { useStore } from 'vuex';
    import config from './config.json';
    import {Document,  Menu,  House,  Setting, ArrowRight } from '@element-plus/icons-vue'
    export default {
    data() {
      return {
        route: useRoute(),
        showOptions: false,
        showProfileModal: false,
        showChangePass: false,
        hideTimer: null,
        userInfo: {
          username: useStore().state.username, // 用户名
          sex: useStore().state.sex,
          position: useStore().state.position,
          contactInfo: useStore().state.contactInfo,
          home_address: useStore().state.home_address,
          // 其他用户信息
        },
        password1: '',
        password2: '',
        password3: '',
        errorMessage: '',
        Document,Menu,House,Setting,ArrowRight
      };
    },
    methods: {
      navigateTo(route) {
        this.selectedMenuItem = route;
        this.$router.push(route); // 跳转到指定的路由
      },
      startHideTimer() {
        console.log(this.showOptions)
        // 只有当鼠标不在选项卡和头像上时，才开始计时隐藏
        if (this.showOptions) {
          
          this.hideTimer = setTimeout(() => {
            this.showOptions = false;
            this.hideTimer = null;
          }, 2000); // 设置3秒后隐藏
        }
      },
      cancelHideTimer() {
        if (this.hideTimer) {
          clearTimeout(this.hideTimer);
          this.hideTimer = null;
        }
      },
      ChangePass() {
        //修改密码逻辑
        const userData = {
          contactInfo: this.userInfo.contactInfo,
          password1: this.password1,
          password2: this.password2,
          password3: this.password3,
        }
        if (this.password2 === this.password3) {
          fetch(config.backendUrl + '/ChangePass', {
            method: 'post',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(userData),
            mode: 'cors',
          })
          .then(response => response.json())
          .then(response => {
            if (response.error_code == 0 && response.msg == '修改成功') {
              this.errorMessage = '密码修改成功！'
            }
          })
        } else {
          this.errorMessage = '两次密码不同'
        }
        
      }
    }
    };
    
</script>

<style lang="scss" scoped>
    // @import "../assets/css/common.css";
    @import '../assets/css/page_container.css';

    .el-row {
      margin-bottom: 0px;
    }
    .el-row :last-child {
      margin-bottom: 0;
    }
    .el-col {
      border-radius: 4px;
    }

    .grid-content {
      border-radius: 4px;
      min-height: 36px;
    }
  
    // .page_container {
    //   position: absolute;
    //   width: 100%;
    //   min-height: 100vh; /* 让容器至少铺满视口高度 */
    //   background-color:#00000046; /* 半透明黑色背景 */
    //   justify-content: center;
    //   align-items: center;
    //   z-index: 9998;
    // }

    .div_window {
      position: absolute;
      top: 35%;
      left: 35%;
      width: 500px;
      height: 330px;
      border: 1px solid #ffffff;
      background-color: #ffffff;
      box-shadow: 0px 0px 10px #222222;
      z-index: 9999;
    }

    .div_window div img {
      width: 80px;
      height: 80px;
      border-radius: 50%;
    }

    .message_table {
      position: absolute;
      top: 100px;
      left: 30px;
    }

    .table_td_left {
      text-align: right;
    }
    
    .table_td_right {
      text-align: left;
    }

    .div_window2 {
      position: absolute;
      top: 35%;
      left: 35%;
      width: 400px;
      height: 250px;
      border: 1px solid #ffffff;
      background-color: #ffffff;
      box-shadow: 0px 0px 10px #222222;
      z-index: 9999;
    }

    .password {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    }

    .ChangePass_table {
      position: absolute;
      top: 50px;
      left: 20px;
      border: 0px;
    }

    .ChangePass_table tr {
      line-height: 30px;
    }

    .close-button {
      position: absolute;
      top: 3px;
      right: 15px;
      font-size: 25px;
      cursor: pointer;
    }

    .logo {
      position: flex;
      align-items: center;
      display: flex;
      background-color: rgb(13, 27, 54);
    }

    .logo img {
      padding: 5px;
      width: 40px;
    }

    .bread{
      margin:14px;
      font-size: 14px;
      margin-left: 30px;
    }

    .user-info {
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .user-info img {
      padding-top: 8px;
      margin: 0px;
      width: 40px;
      height: 40px;
      border-radius: 50%;
      cursor: pointer;
    }

    .user-options {
      position: fixed;
      z-index: 9997;
      top: 50px;
      right: 2%;
      background-color: #ffffffb6;
      border: 1px solid #ccc;
      box-shadow: 0px 2px 4px #00000046;
      border-radius: 4px;
    }

    .user-options ul {
      list-style-type: none;
      padding-left: 15px;
      padding-right: 15px;
      line-height: 25px;
      cursor: pointer;
    }

    .custom_router_link {
      text-decoration: none; /* 取消下划线 */
      color: inherit;
    }

    .user-info:hover .user-options {
      display: block;
    }

    .menu-style {
      height: calc(100vh - 50px);
      border-right-width: 0px;
    }

    
</style>