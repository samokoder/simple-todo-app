<template>
  <form v-on:submit.prevent="formSubmit">
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
    </div>
  </form>
</template>

<script>
export default {
  name: 'NewTodo',

  props: {
    disabled: Boolean
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
