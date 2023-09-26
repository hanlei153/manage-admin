/**
 * app全局变量
 *@author MuYi
 *@date 2022/3/21 8:58
 *@version 1.0
 */
 export default {
    namespace: 'true',
    state() {
      return {
        /**
         * app信息
         */
        appInfo: {
          registerCompany: '请联系注册您的公司',
          version: '1.0.0',
          copyright: 'WinTown Software studio All rights reserved.',
          copyrightYear: '©2021-2022',
          author: ''
        }, 
        theme: { 
          menuMode: 'vertical', 
          colorBackground: '#009999',
        }
      }
    },
    mutations: {
      /**
       * 设置app信息
       * @param appInfo
       */
      saveAppInfo(state, appInfo) {
       state.appInfo = appInfo;
      }, 
      saveTheme(state, theme) {
        state.theme = theme;
      }
    },
    actions: {
      updateTheme(context, theme) {
        context.commit("theme", theme);
      },
      updateAppInfo(context, appInfo) {
        context.commit("appInfo", appInfo)
      }
    },
    getters: {
      theme(state) {
        return state.theme;
      },
      appInfo(state) {
        return state.appInfo;
      }
    }
  }