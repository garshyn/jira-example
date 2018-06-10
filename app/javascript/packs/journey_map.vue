<template>
  <div>
    <h1>{{ journeyMap.title }}</h1>
    <el-tabs v-loading="loading" v-model="activeName" @tab-click="handleClick">
      <el-tab-pane v-for="step, index in journeyMap.steps" :key="index" :label="step.title" :name="step.title">
        <h2>{{ step.title }}</h2>
        <el-row :gutter="20">
          <el-col class="column" v-for="field, index in step.fields" :key="index" :span="8">
            <component :is="field.cmp" :fieldData="field"></component>
          </el-col>
        </el-row>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import JiraField from './jira_field'

export default {
  props: ['url'],
  data() {
    return {
      activeName: false,
      loading: true,
      journeyMap: {
        title: 'Loading...'
      }
    };
  },
  mounted() {
    this.$http.get(this.url).then(response => {
      this.journeyMap = response.body.journey_map
      this.activeName = this.journeyMap.steps[0].title
      this.loading = false
    })
  },
  methods: {
    handleClick(tab, event) {
    }
  },
  components: { JiraField }
}
</script>

<style scoped>
.column {
  margin-bottom: 1em;
  &:nth-child(3n+1) {
    clear: both;
  }
}
</style>
