import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["reloj"];

  initialize() {
    setInterval(() => {
      let time = new Date();
      let hour = time.getHours();
      let minute = time.getMinutes();
      let second = time.getSeconds();

      hour = hour < 10 ? `0${hour}` : hour;
      minute = minute < 10 ? `0${minute}` : minute;
      second = second < 10 ? `0${second}` : second;

      this.relojTarget.innerHTML = `
      <div class="container__number">
        <span class="number-clock" >${hour}</span>
        <p>hours</p>
      </div>
      <span class="number-colon">:</span>
      <div class="container__number">
        <span class="number-clock" >${minute}</span>
        <p>minutes</p>
      </div>
      <span class="number-colon">:</span>
      <div class="container__number">
        <span class="number-clock" >${second}</span>
        <p>seconds</p>
      </div>      
      `;
      // this.hoursTarget.value = `${hour}`;
      // this.minutesTarget.value = `${minute}`;
      // this.secondsTarget.value = `${second}`;
    }, 1000);
  }
}
