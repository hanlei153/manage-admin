import { createStore } from 'vuex' 
import createPersistedState from 'vuex-persistedstate'
export default createStore({
  state: {  //初始信息
    username: null,
    sex: null,
    position: null,
    contactInfo: null,
    home_address: null,
  },

  mutations: {  // 设置用户信息
    Changeusername(state, username) {
      state.username = username;
    },
    Changesex(state, sex) {
      state.sex = sex;
    },
    Changeposition(state, position) {
      state.position = position;
    },
    ChangecontactInfo(state, contactInfo) {
      state.contactInfo = contactInfo;
    },
    Changehome_address(state, home_address) {
      state.home_address = home_address;
    },
  },

  getters: { // 可以在这里定义获取用户信息的 getter 方法

  },

  actions: {  // 在这里定义异步操作，例如从后端获取用户信息并调用 mutations 设置

  },

  modules: {
  },

  plugins: [createPersistedState({
    storage: window.sessionStorage,
  })]
})