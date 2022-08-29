var ssid_matched = ($network.wifi.ssid === 'UniWireless'); // This script will only work in school

const declined_hostname = [
  // General Part
  "telegram.org",
  "twitter.com",
  "v2ex.com",
  "zhihu.com",
  "smzdm.com",
  // Games Website
  "ngabbs.com",
  "gcores.com",
  // Anime Website
  "bangumi.moe",
  "bangumi.tv",
];


const declined_processes = [
  "/Applications/Telegram.app/Contents/MacOS/Telegram",
];

var requestHostname = $request.hostname;
var regex = /[a-zA-Z0-9-]+.[a-zA-Z]+$/gm;
var hostname_after_regex = requestHostname.match(regex)[0];


var hostMatched = declined_hostname.includes(hostname_after_regex);


var processMatched = declined_processes.includes($request.processPath);


// $notification.post("No Fish Touching", "You Are In School!", "Plz, be focus")

// console.log("This is $request.hostname: " + $request.hostname)
// console.log("This is $request.hostname after regex match: " + hostname_after_regex)
// console.log("This is result if it matched: " + declined_hostname.includes(hostname_after_regex))

// Previous is or and it has to match the ssid to make this be reject
$done({matched: (hostMatched || processMatched) && ssid_matched});
