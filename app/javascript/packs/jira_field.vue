<template lang="html">
  <el-card class="box-card" v-loading="loading">
    <div slot="header">
      <span>
        <el-input placeholder="Please input" v-model="issue.summary"></el-input>
      </span>
    </div>
    <el-input
      type="textarea"
      :rows="2"
      placeholder="Please input"
      v-model="issue.description">
    </el-input>

    <div class="toolbar" v-if="issueId">
      <el-button size="small" @click="save">
        Save
      </el-button>
      <div class="toolbar-right">
        <el-button type="danger" size="small" @click="remove">
          Remove
        </el-button>
      </div>
    </div>
    <div class="toolbar" v-else>
      <el-button size="small" @click="create">
        Create
      </el-button>
    </div>
  </el-card>
</template>

<script>
export default {
  props: ['fieldData'],
  data() {
    var issue = this.fieldData.contents ?
      this.fieldData.contents.issue
      :
      {
        summary: ''
      };
    return {
      loading: false,
      issue: issue
    }
  },
  mounted() {
    if(this.issueId && !this.fieldData.justCreated) {
      this.sync()
    }
  },
  computed: {
    issueId() {
      if(this.fieldData.contents) {
        return this.fieldData.contents.issue_id
      }
      else {
        return null
      }
    }
  },
  watch: {
    fieldData() {
      if(this.issueId) {
        this.issue = this.fieldData.contents.issue
      }
      else {
        this.issue = {
          summary: ''
        }
      }
    }
  },
  methods: {
    sync() {
      this.loading = true
      this.$http.get(this.fieldData.url).then(response => {
        this.issue = response.body.field.issue
        this.loading = false
      }, errorResponse => {
        var me = this
        setTimeout(function() {
          me.sync()
        }, 10000);
      })
    },
    save() {
      this.loading = true
      this.$http.patch(this.fieldData.url, {
        field: {
          summary: this.issue.summary,
          description: this.issue.description
        }
      }).then(response => {
        this.loading = false
        if(!response.body.success) {
          console.log(response.body.field.errors);
          this.showError(response.body.field.errors.join(';'))
        }
      }, errorResponse => {
        this.loading = false;
        this.showError(errorResponse.statusText)
      })
    },
    create() {
      this.loading = true
      this.$http.post(this.fieldData.url, {
        field: {
          step_id: this.fieldData.step_id,
          summary: this.issue.summary,
          description: this.issue.description
        }
      }).then(response => {
        this.loading = false;
        this.$emit('created', response.body.field);
      }, errorResponse => {
        this.loading = false;
        this.showError(errorResponse.statusText)
      })
    },
    remove() {
      this.loading = true
      this.$http.delete(this.fieldData.url).
      then(response => {
        this.loading = false
        this.$emit('removed', this.fieldData.id);
      })
    },
    showError(message) {
      this.$notify.error({
        title: 'Error',
        message: message
      });
    }
  }
}
</script>

<style scoped>
.toolbar {
  margin-top: 8px;
}
.toolbar-right {
  float: right;
}
</style>
