<template>
  <div>
    <div class="control">
      <b-field grouped>
        <p
          class="control is-expanded my-2"
          v-bind:class="{ 'todo-done': todo.done }"
          v-on:dblclick="editItem"
        >
          {{ todo.title }}
        </p>

        <div class="control buttons mb-0">
          <b-checkbox
            class="mr-0"
            title="mark done"
            v-bind:value="todo.done"
            v-on:input="toggleDone"
          ></b-checkbox>
          <button class="delete" v-on:click="deleteItem"></button>
        </div>
      </b-field>
    </div>
  </div>
</template>

<script>
export default {
  name: 'TodoItem',

  props: {
    todo: {
      type: Object,
      required: true
    }
  },

  methods: {
    editItem() {
      // prevent editing finished item
      if (this.todo.done) return;

      console.log('edit');
    },

    toggleDone(value) {
      this.$emit('edit', { id: this.todo.id, done: value });
    },

    deleteItem() {
      if (confirm('RU sure???')) {
        this.$emit('delete', { id: this.todo.id });
      }
    }
  }
};
</script>

<style>
.todo-done {
  text-decoration: line-through;
  font-style: italic;
}
</style>
