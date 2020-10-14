<template>
  <form class="new-todo-form" v-on:submit.prevent="formSubmit">
    <div class="control field has-addons">
      <div class="control is-expanded">
        <input
          type="text"
          class="input is-fullwidth"
          placeholder="Edit TODO..."
          v-model="title"
          required
        />
      </div>
      <div class="control">
        <button class="button is-primary">Add</button>
      </div>
      <b-loading
        v-bind:active="disabled"
        v-bind:is-full-page="false"
      ></b-loading>
    </div>
  </form>
</template>

<script>
export default {
  name: 'NewTodo',

  props: {
    disabled: {
      type: Boolean,
      default: false
    }
  },

  data() {
    return {
      title: ''
    };
  },

  methods: {
    formSubmit() {
      this.$emit('create', { title: this.title });
      this.title = '';
    }
  }
};
</script>

<style>
.new-todo-form .loading-overlay .loading-icon:after {
  width: 2em;
  height: 2em;
  top: calc(50% - 1em);
}
</style>
