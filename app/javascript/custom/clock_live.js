const hour = document.getElementById('hour');
const minutes = document.getElementById('minutes');
const seconds = document.getElementById('seconds');

function pad(n) {
  return String(n).length === 1 ? `0${n}`: n;
}

window.time = function () {

  const d = new Date();

  hour.textContent = pad(d.getHours()); 
  minutes.textContent = pad(d.getMinutes());
  seconds.textContent = pad(d.getSeconds());

  setTimeout(time, 1000)
}

time()