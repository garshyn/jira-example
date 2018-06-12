<template>
  <div>
    <h1>{{ journeyMap.title }}</h1>
    <el-tabs v-loading="loading" v-model="activeName" @tab-click="handleClick">
      <el-tab-pane v-for="step, index in journeyMap.steps" :key="index" :label="step.title" :name="step.title">
        <h2>{{ step.title }}</h2>
        <el-row :gutter="20">
          <el-col class="column" v-for="field, index in step.fields" :key="index" :span="8">
            <component :is="field.cmp" :fieldData="field" @removed="onIssueRemoved"></component>
          </el-col>
          <el-col class="column" :span="8">
            <jira-field :fieldData="newIssue" @created="onIssueCreated"></jira-field>
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
      activeStep: null,
      activeIndex: 0,
      loading: true,
      journeyMap: {
        title: 'Loading...'
      },
      newIssue: {}
    };
  },
  mounted() {
    this.$http.get(this.url).then(response => {
      this.journeyMap = response.body.journey_map
      this.activeName = this.journeyMap.steps[0].title
      this.activeStep = this.journeyMap.steps[0];
      this.newIssue = this.initNewIssue(this.journeyMap.steps[0].id),
      this.loading = false
    })
  },
  methods: {
    handleClick(tab, event) {
      this.activeStep = this.journeyMap.steps[tab.index];
      this.activeIndex = tab.index;
      this.newIssue = this.initNewIssue(this.activeStep.id);
    },
    onIssueCreated(field) {
      field.justCreated = true
      this.activeStep.fields.push(field);
      this.newIssue = this.initNewIssue(this.activeStep.id);
    },
    onIssueRemoved(fieldId) {
      for(var i in this.activeStep.fields) {
        if(this.activeStep.fields[i].id == fieldId) {
          this.activeStep.fields.splice(i, 1);
          break;
        }
      }
    },
    initNewIssue(step_id) {
      return function() {
        var newIssue = {
          step_id: step_id,
          url: '/jira_fields'
        };
        return newIssue;
      }()
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
