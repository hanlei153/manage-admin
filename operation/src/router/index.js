// router.js

import {createRouter, createWebHistory} from 'vue-router'
import LoginForm from '../components/LoginForm.vue'
import LayoutPage from '../components/LayoutPage.vue'



const routes = [
  {
    path: '/login',
    component: LoginForm,
  },
  {
    path: '/',
    name: '首页',
    redirect: '/DashboardPage',
    component: LayoutPage,
    meta: { 
      title: '仪表盘' 
    },
    children: [
      { 
        path: '/DashboardPage', 
        component:()=>import('@/components/views/DashboardPage.vue'),
      },
    ]
  },
  {
    path: '/Sales_Data',
    name: '销售数据',
    redirect: '/Sales_Data/order_management',
    component: LayoutPage,
    meta: { 
      title: '销售数据'
    },
    children: [
      { 
        path: 'order_management',
        name: '订单管理',
        component:()=>import('@/components/views/Sales_Data/order_management.vue'),
        meta: {
          title: '订单管理',
        } 
      },
      {
        path: 'OrderPage2',
        name: '其他2',
        redirect: '/Sales_Data/OrderPage2/OrderPage2-1',
        meta: { 
          title: '其他2' 
        },
        children: [{
          path: 'OrderPage2-1',
          name: '其他2-1',
          component:()=>import('@/components/views/orderPage.vue'),
          meta: {
            title: '其他2-1',
          } 
        }],
      },
    ]
  },
  {
    path: '/Product',
    name: '产品管理',
    component: LayoutPage,
    redirect: '/Product/Enter_product',
    meta: { 
      title: '产品管理' 
    },
    children: [
      { 
        path: 'Enter_product',
        component:()=>import('@/components/views/Product/Enter_product.vue'),
        meta: {
          title: '产品管理',
        } 
      },
      { 
        path: 'ProductPage2',
        component:()=>import('@/components/views/ProductPage.vue'),
        meta: {
          title: '产品2',
        } 
      },
    ]
  }
  // 添加其他路由配置
]

const router = createRouter({
  history: createWebHistory(),
  routes,
});


function checkCookieValidity() {
  const cookieValue = getCookie('loginStatus'); // 替换为你的 Cookie 名称
  if (cookieValue) {
    // 在这里检查 Cookie 的有效性，比如是否过期
    // 如果有效，返回 true；否则，返回 false
    return true;
  }
  return false;
}
function getCookie(name) {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
}
// 全局前置守卫
router.beforeEach((to, from, next) => {
  // 在这里检查 Cookie 是否超时
  const isCookieValid = checkCookieValidity(); // 这里需要你实现一个检查 Cookie 的函数
  if (to.path === '/login') {
    next();
  } else {
    if (isCookieValid) {
      //如果有效继续路由
      next();
    } else {
      next('/login');
    }
  }
})

export default router