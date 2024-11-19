document.addEventListener("DOMContentLoaded", function() {
  let timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
  document.cookie = "timezone=" + timezone;
  console.log("Timezone cookie set to: " + timezone);
})