<template>
  <v-app>
    <!-- Header -->
    <v-app-bar app color="white" elevation="1" height="80">
      <v-container fluid class="d-flex align-center">
        <!-- Logo with back functionality -->
        <v-btn 
          variant="text" 
          @click="goBack" 
          class="mr-4 pa-2 d-flex align-center justify-center"
          style="min-width: auto; height: 60px;"
        >
          <v-img :src="getAssetPath('/logo.png')" width="80" contain></v-img>
        </v-btn>
        
        <v-text-field
          v-model="searchQuery"
          placeholder="Search in Professionals"
          prepend-inner-icon="mdi-magnify"
          variant="outlined"
          density="compact"
          hide-details
          class="search-field mr-6"
          style="max-width: 300px;"
        ></v-text-field>
        
        <v-spacer></v-spacer>
        
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('设计公司及独立设计师')">设计公司及独立设计师</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('材料设备供应商')">材料设备供应商</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('施工单位供应商')">施工单位供应商</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('专家人才库')">专家人才库</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('需求大厅')">需求大厅</v-btn>
        
        <v-btn variant="text" prepend-icon="mdi-account" class="ml-4">
          登陆
        </v-btn>
      </v-container>
    </v-app-bar>

    <!-- Main Content -->
    <v-main>
      <v-container fluid class="pa-6">
        <!-- Page Title -->
        <h1 class="text-h4 font-weight-bold mb-6">{{ pageTitle }}</h1>
        
        <!-- Category Tags -->
        <v-row class="mb-6">
                    <!-- Companies List for 建筑材料 -->
          <v-row v-if="pageTitle === '建筑材料'">
            <v-col
              v-for="(company, index) in companies"
              :key="index"
              cols="12"
              md="6"
              lg="4"
              class="mb-6"
            >
              <v-card
                elevation="1"
                class="company-card pa-6"
                @click="navigateToCompany(company)"
                style="cursor: pointer;"
              >
                <v-row>
                  <!-- 主图 -->
                  <v-col cols="12">
                    <v-img
                      :src="company.mainImage"
                      height="180"
                      cover
                      class="rounded company-main-image mb-4"
                    ></v-img>
                  </v-col>
                  <!-- 产品信息 -->
                  <v-col cols="12">
                    <div class="d-flex align-center mb-2">
                      <h2 class="text-h6 font-weight-bold mr-3">{{ company.铝合金双开门 }}</h2>
                      <v-chip size="small" color="blue" variant="outlined">{{ company.铝合金双开门 }}</v-chip>
                    </div>
                    <div class="text-body-2 text-grey mb-1">{{ company.铝合金双开门 }}</div>
                    <div class="text-orange font-weight-bold mb-1">{{ company.铝合金双开门 }}</div>
                    <div class="mb-1">
                      <v-chip
                        v-for="tag in company.projectTypes"
                        :key="tag"
                        size="small"
                        class="mr-1 mb-1"
                        color="grey-lighten-2"
                      >{{ tag }}</v-chip>
                    </div>
                  </v-col>
                </v-row>
              </v-card>
            </v-col>
          </v-row>
          <v-col cols="12">
            <v-chip-group v-model="selectedCategory" class="mb-4">
              <v-chip 
                v-for="(category, index) in categories" 
                :key="index"
                :value="index"
                variant="outlined"
                class="mr-2 mb-2"
                @click="navigateToTag(category)"
              >
                {{ category }}
              </v-chip>
            </v-chip-group>
          </v-col>
        </v-row>

        <!-- Project Grid -->
        <v-row>
          <v-col 
            v-for="(project, index) in projects" 
            :key="index"
            :cols="project.cols || 6"
            :md="project.md || 6"
          >
            <v-card 
              class="project-card" 
              elevation="2"
              @click="handleProjectClick(project)"
              style="cursor: pointer;"
            >
              <v-img 
                :src="project.image" 
                :height="project.height || 250"
                cover
                class="project-image"
              >
                <div class="project-overlay">
                  <div class="project-info">
                    <h3 class="text-h6 text-white font-weight-bold mb-1">{{ project.title }}</h3>
                    <p class="text-body-2 text-white opacity-90">{{ project.description }}</p>
                  </div>
                </div>
              </v-img>
            </v-card>
          </v-col>
        </v-row>

      </v-container>
    </v-main>

    <!-- Footer -->
    <Footer />
  </v-app>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import Footer from '@/components/Footer.vue';
import { getAssetPath } from '@/utils/assets.js';

const router = useRouter();
const route = useRoute();

const pageTitle = ref('');
const contentTitle = ref('');
const contentDescription = ref('');
const features = ref([]);
const searchQuery = ref('');
const selectedCategory = ref(0);
const categories = ref([]);
const projects = ref([]);

const contentData = {
  '设计公司及独立设计师': {
    title: '设计公司及独立设计师',
    description: '为您提供专业的设计服务，包括建筑设计、室内设计、景观设计等多个领域的专业设计师和设计公司。',
    categories: ['总体设计', '建筑方案设计', '建筑施工图设计', '结构设计', '机电设计', '智能化设计', '幕墙设计', '室内设计', '景观设计', '消防设计', '海绵设计', '泛光设计'],
    projects: [
      {
        title: '现代商业综合体',
        description: '大型城市综合体建筑设计',
        image: getAssetPath("/gallary1.jpg"),
        cols: 6,
        md: 6,
        height: 300
      },
      {
        title: '创新建筑设计',
        description: '独特的螺旋式建筑造型',
        image: getAssetPath("/gallary2.jpg"),
        cols: 6,
        md: 6,
        height: 300
      },
      {
        title: '城市规划项目',
        description: '大型城市开发规划设计',
        image: getAssetPath("/gallary3.jpg"),
        cols: 8,
        md: 8,
        height: 250
      },
      {
        title: '高端住宅项目',
        description: '豪华住宅建筑群设计',
        image: getAssetPath("/gallary4.jpg"),
        cols: 4,
        md: 4,
        height: 250
      }
    ]
  },
  '材料设备供应商': {
    title: '材料设备供应商',
    description: '汇聚优质建筑材料和设备供应商，为您的项目提供高品质的建筑材料和先进设备。',
    categories: ['建筑材料', '装饰材料', '机电设备', '智能设备', '安全设备', '环保材料'],
    projects: [
      {
        title: '高品质建材展示',
        description: '优质建筑材料产品',
        image: getAssetPath("/gallary1.jpg"),
        cols: 6,
        md: 6,
        height: 250
      },
      {
        title: '智能设备系统',
        description: '现代化智能建筑设备',
        image: getAssetPath("/gallary2.jpg"),
        cols: 6,
        md: 6,
        height: 250
      }
    ]
  },
  '施工单位供应商': {
    title: '施工单位供应商',
    description: '专业的施工团队和承包商，提供从基础施工到装修完成的全流程建筑施工服务。',
    categories: ['土建施工', '装修施工', '机电安装', '市政工程', '园林工程', '专业工程'],
    projects: [
      {
        title: '大型建筑施工',
        description: '复杂建筑项目施工',
        image: getAssetPath("/gallary3.jpg"),
        cols: 8,
        md: 8,
        height: 300
      },
      {
        title: '精装修工程',
        description: '高端装修施工项目',
        image: getAssetPath("/gallary5.jpg"),
        cols: 4,
        md: 4,
        height: 300
      }
    ]
  },
  '专家人才库': {
    title: '专家人才库',
    description: '汇聚建筑行业各领域专家和人才，为您的项目提供专业咨询和技术支持。',
    categories: ['建筑专家', '结构专家', '机电专家', '规划专家', '咨询顾问', '技术专家'],
    projects: [
      {
        title: '专家咨询服务',
        description: '顶级专家团队支持',
        image: getAssetPath("/gallary4.jpg"),
        cols: 6,
        md: 6,
        height: 250
      },
      {
        title: '技术培训',
        description: '专业技术培训服务',
        image: getAssetPath("/gallary5.jpg"),
        cols: 6,
        md: 6,
        height: 250
      }
    ]
  },
  '需求大厅': {
    title: '需求大厅',
    description: '项目需求发布和对接平台，帮助您快速找到合适的合作伙伴和服务提供商。',
    categories: ['设计需求', '施工需求', '材料需求', '技术需求', '咨询需求', '合作需求'],
    projects: [
      {
        title: '项目需求发布',
        description: '便捷的需求发布平台',
        image: getAssetPath("/gallary1.jpg"),
        cols: 6,
        md: 6,
        height: 250
      },
      {
        title: '智能匹配系统',
        description: '精准匹配服务商',
        image: getAssetPath("/gallary2.jpg"),
        cols: 6,
        md: 6,
        height: 250
      }
    ]
  }
};

const loadContent = () => {
  const type = route.query.type;
  console.log('Loading content for type:', type);
  
  if (type && contentData[type]) {
    const data = contentData[type];
    pageTitle.value = data.title;
    contentTitle.value = data.title;
    contentDescription.value = data.description;
    categories.value = data.categories;
    projects.value = data.projects;
  } else {
    // Default content
    pageTitle.value = '详情页面';
    contentTitle.value = '详情信息';
    contentDescription.value = '这里是详细信息页面。';
    categories.value = [];
    projects.value = [];
  }
};

const goBack = () => {
  router.push('/');
};

const navigateToCategory = (categoryName) => {
  console.log('Navigating to category:', categoryName);
  router.push({
    path: '/category',
    query: { type: categoryName }
  });
};

const navigateToTag = (tagName) => {
  console.log('Navigating to tag:', tagName);
  const currentCategory = route.query.type;
  router.push({
    path: '/tag',
    query: { 
      category: currentCategory,
      tag: tagName 
    }
  });
};


// 跳转到各自的数据库页面
const handleProjectClick = (project) => {
  // 材料设备供应商下的卡片跳转到 tag 页面
  if (pageTitle.value === '材料设备供应商') {
    if (project.title === '高品质建材展示') {
      router.push({
        path: '/tag',
        query: {
          category: '材料设备供应商',
          tag: '建筑材料'
        }
      });
      return;
    } else if (project.title === '智能设备系统') {
      router.push({
        path: '/tag',
        query: {
          category: '材料设备供应商',
          tag: '智能设备'
        }
      });
      return;
    }
    // 可继续扩展更多卡片跳转
  }
  // 设计公司及独立设计师下的卡片跳转到 tag 页面
  if (pageTitle.value === '设计公司及独立设计师') {
    router.push({
      path: '/tag',
      query: {
        category: '设计公司及独立设计师',
        tag: project.title
      }
    });
    return;
  }
  // 施工单位供应商下的卡片跳转到 tag 页面
  if (pageTitle.value === '施工单位供应商') {
    router.push({
      path: '/tag',
      query: {
        category: '施工单位供应商',
        tag: project.title
      }
    });
    return;
  }
  // 专家人才库下的卡片跳转到 tag 页面
  if (pageTitle.value === '专家人才库') {
    router.push({
      path: '/tag',
      query: {
        category: '专家人才库',
        tag: project.title
      }
    });
    return;
  }
  // 需求大厅下的卡片跳转到 tag 页面
  if (pageTitle.value === '需求大厅') {
    router.push({
      path: '/tag',
      query: {
        category: '需求大厅',
        tag: project.title
      }
    });
    return;
  }
  // 默认行为
  console.log('No jump logic for this card:', project.title);
};

onMounted(() => {
  loadContent();
});

watch(() => route.query.type, () => {
  loadContent();
});
</script>

<style scoped>
.search-field {
  border-radius: 8px;
}

.project-card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border-radius: 12px;
  overflow: hidden;
}

.project-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.project-image {
  position: relative;
}

.project-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.7));
  padding: 20px;
}

.project-info {
  color: white;
}

.v-chip {
  border-radius: 20px;
  font-weight: 500;
}

.v-btn {
  text-transform: none;
  font-weight: 500;
}

.v-app-bar {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.v-card {
  border-radius: 12px;
}
</style>

