<template lang="html">
  <el-card class="box-card" v-loading="loading">
    <div slot="header">
      <span>
        {{ issue.summary }}
        <div class="toolbar">
          <el-popover
            trigger="hover"
            :content="syncHint">
            <el-button slot="reference" type="text" @click="sync">
              Sync now
            </el-button>
          </el-popover>
        </div>
      </span>
    </div>
    {{ issue.description }}
  </el-card>
</template>

<script>
export default {
  props: ['fieldData'],
  data() {
    return {
      data: this.fieldData,
      loading: false
    }
  },
  computed: {
    issue() {
      return this.data.contents.issue || { summary: 'Blank' }
    },
    syncHint() {
      return `Last sync ${this.data.cached_ago}`
    }
  },
  mounted() {
    if(this.data.has_to_sync) {
      this.sync()
    }
  },
  methods: {
    sync() {
      this.loading = true
      this.$http.get(this.fieldData.url).then(response => {
        this.data = response.body.field
        this.loading = false
      }, errorResponse => {
        console.log(errorResponse.statusText)
        var me = this;
        setTimeout(function() {
          me.sync()
        }, 10000, this)
      })
    }
  }
}
</script>

<style>
.toolbar {
  float: right;
}
.el-button {
  padding: 0;
}
</style>
