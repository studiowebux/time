<template>
  <div class="time container mx-auto mt-5">
    <div class="card shadow">
      <div class="card-body">
        <div class="text-center mb-5 fs-1">
          <i class="bi bi-clock"></i>
        </div>
        <form @submit.prevent="reload">
          <div class="form-floating mb-3">
            <input
              type="text"
              class="form-control"
              id="expectedTime"
              v-model="expectedTime"
              @change="reload"
            />
            <label for="expectedTime">Expected Time</label>
          </div>

          <div class="form-floating mb-3">
            <input
              type="text"
              class="form-control"
              id="workedTime"
              v-model="workedTime"
              @change="reload"
            />
            <label for="workedTime">Worked Time</label>
          </div>

          <button class="btn btn-outline-primary btn-sm mx-auto" type="submit">Refresh</button>
        </form>

        <div class="result mx-auto p-3 mt-3">
          <p class="fw-lighter text-center">
            You've worked <span class="fw-bolder">{{ workedTime }}</span> /
            <span class="fw-bolder">{{ expectedTime }}</span>
          </p>
          <hr class="w-75 mx-auto" />
          <p class="text-start">
            Difference : <span class="fw-bolder">{{ symbol }} {{ time }}</span> Minute(s)
          </p>
          <p class="text-start">
            Difference : <span class="fw-bolder">{{ symbol }} {{ diff }}</span>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { secondsToMinutes, hoursToSeconds, minutesToSeconds, secondsToHours } from 'date-fns';

export default {
  name: 'TimeComponent',

  data() {
    return {
      expectedTime: '37:30',
      workedTime: '37:30',

      diff: '',
      time: '',
      symbol: '',
    };
  },

  mounted() {
    this.reload();
  },

  methods: {
    doubleDigit(number) {
      if (Number.isNaN(number)) {
        return '00';
      }
      return (number < 10 ? '0' : '') + number.toString();
    },

    reload() {
      const t = this.expectedTime.split(':');
      const expectedSeconds = hoursToSeconds(t[0]) + minutesToSeconds(t[1]);

      const a = this.workedTime.split(':');
      const actualSeconds = hoursToSeconds(a[0]) + minutesToSeconds(a[1]);

      this.time = this.doubleDigit(secondsToMinutes(actualSeconds - expectedSeconds));
      this.diff = `${this.doubleDigit(
        secondsToHours(actualSeconds - expectedSeconds),
      )}:${this.doubleDigit(secondsToMinutes(actualSeconds - expectedSeconds) % 60)}`;

      console.debug(`${actualSeconds} < ${expectedSeconds}`);
      if (actualSeconds < expectedSeconds) {
        this.symbol = 'Missing';
        this.time = this.doubleDigit(secondsToMinutes(expectedSeconds - actualSeconds));
        this.diff = `${this.doubleDigit(
          secondsToHours(expectedSeconds - actualSeconds),
        )}:${this.doubleDigit(secondsToMinutes(expectedSeconds - actualSeconds) % 60)}`;
      } else {
        this.symbol = '';
      }
    },
  },
};
</script>
