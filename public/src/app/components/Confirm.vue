<template>
  <div class="modal-card" style="width: auto">
    <header class="modal-card-head">
      <p class="modal-card-title">Are you sure?</p>
    </header>
    <footer class="modal-card-foot">
      <button class="button" type="button" v-on:click="$emit('close')">
        Cancel
      </button>
      <button class="button is-primary" v-on:click="confirm">OK</button>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'ConfirmModal',

  methods: {
    confirm() {
      this.$emit('confirm');
      this.$emit('close');
    }
  }
};
</script>
