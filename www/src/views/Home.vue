<template>
  <div class="home">
    <Time />

    <footer class="footer mt-3 mb-5 text-center">
      <p>
        <i class="bi bi-box"></i>&nbsp;Created by
        <a href="https://studiowebux.com" target="_blank">Studio Webux</a>
      </p>
      <p>
        <i class="bi bi-chat"></i>&nbsp;Blog
        <a href="https://webuxlab.com" target="_blank">Webux Lab</a>
      </p>
      <a href="https://www.buymeacoffee.com/studiowebux" target="_blank"
        ><img
          src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png"
          alt="Buy Me A Coffee"
          style="height: 60px !important; width: 217px !important"
      /></a>
    </footer>
  </div>
</template>

<script>
import Time from '@/components/Time.vue';

export default {
  name: 'Home',

  components: {
    Time,
  },
};
</script>
