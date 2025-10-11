// See https://github.com/johnste/finicky#configuration.
export default {
  defaultBrowser: "Firefox",
  handlers: [
    // Open Google Meet in Chrome.
    {
      match: "meet.google.com/*",
      browser: "Google Chrome"
    }
  ]
}
