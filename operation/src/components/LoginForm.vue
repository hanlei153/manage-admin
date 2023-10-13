<template>
    <div class="center-content">
      <h1>Welcome to My Vue App</h1>
      <p>This is the homepage of your Vue.js application.</p>
      <img alt="Vue logo" src="../assets/logo.png">
    </div>

    <div class="login-container">
      <h2>Login</h2>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="username">Username:</label>
          <input class="input_login" type="text" id="username" v-model="username" required>
        </div>
        <div class="form-group">
          <label for="password">Password:</label>
          <input class="input_login" type="password" id="password" v-model="password" required>
        </div>
        <button type="submit">Login</button>
      </form>
      <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
    </div>
  </template>
  
  
  <script>
  import config from './config.json';
  export default {
    data() {
      return {
        username: '',
        password: '',
        errorMessage: '',
        backendUrl: config.backendUrl,
      };
    },
    methods: {
      login() {
        // 在此处编写登录逻辑
        // 检查用户名和密码，执行登录操作
        const userData = {
          username: this.username,
          password: this.password
        }

        //发起post请求
        fetch(config.backendUrl + '/login', {
          method: 'post',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(userData),
          mode: 'cors',
        })
        .then(response => response.json())
        .then(response => {
          if (response.error_code == 0 && response.msg == '登陆成功') {
            //登录成功，跳转首页
            document.cookie = 'loginStatus=true;max-age=21600';
            this.$store.commit('Changeusername', response.username);
            this.$store.commit('Changesex', response.sex);
            this.$store.commit('Changeposition', response.position);
            this.$store.commit('ChangecontactInfo', response.contactinfo);
            this.$store.commit('Changehome_address', response.home_address);
            this.$router.push('/DashboardPage');
          } else if(response.error_code == 1){
            //用户名或密码错误
              this.errorMessage = 'Invalid username or password';
          } else {
            //其他错误提示
            throw new Error('Network response was not ok')
          }
        })
        .catch(error => {
          // 处理请求错误
          console.error('There was a problem with the fetch operation:', error);
        });
      }
    }
  };
  </script>
  
  <style>
  /* 添加适当的样式来美化登录页面 */
  .center-content {
    text-align: center; /* 居中文本 */
  }
  
  .center-content img {
    display: block; /* 将图像设置为块级元素，以便水平居中 */
    margin: 0 auto; /* 通过左右边距自动居中图像 */
  }
  .login-container {
    max-width: 350px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #fff;
  }
  
  .form-group {
    margin-bottom: 15px;
  }
  
  label {
    display: block;
    font-weight: bold;
  }
  
  .input_login {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  
  button {
    background-color: #007bff;
    color: #fff;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .error-message {
    color: red;
    margin-top: 10px;
  }
  h1 {
    font-size: 2rem;
    margin-bottom: 20px;
  }
  
  p {
    font-size: 1.2rem;
  }
  </style>