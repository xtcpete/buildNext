<template>
  <v-app-bar app>
      <v-row align="center" justify="space-between" class="mx-4">
        <v-col cols="auto">
            <v-row align="center" justify="end">
                <v-img src="/logo.png" alt="Logo" width="80" class="mr-4"></v-img>
                <v-btn text>关于我们</v-btn>
                <v-btn text>企业团队</v-btn>
                <v-btn text>新闻动态</v-btn>
                <v-btn text>
                  <v-icon>mdi-translate</v-icon> ENGLISH
                </v-btn>
            </v-row>
        </v-col>
        <v-col cols="auto">
            <v-row align="center" justify="end" class="right-buttons">
                <v-btn text>设计公司及独立设计师</v-btn>
                <v-btn text>材料设备供应商</v-btn>
                <v-btn text>施工单位供应商</v-btn>
                <v-btn text>专家人才库</v-btn>
                <v-btn text>需求大厅</v-btn>
                <v-btn text>
                    <v-icon>mdi-login</v-icon> 登录
                </v-btn>
            </v-row>
        </v-col>
      </v-row>
  </v-app-bar>
</template>

<script>
export default {
  name: 'Header',
};
</script>

<style scoped>

/* Add hover effects to buttons */
.v-btn {
  transition: background-color 0.3s ease, color 0.3s ease;
}
.v-btn:hover {
  background-color: #f5f5f5;
  color: #1976d2;
}
.right-buttons {
    color: gray;
}
.right-buttons .v-btn:hover {
    background-color: #f5f5f5;
    color: orange;
}

</style>
