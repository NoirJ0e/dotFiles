const ssid = $network.wifi.ssid;
//const ssid = "VostroNet";
//const uniSSID = "UniWireless";
const uniSSID = "VostroNet";
const moduleName = "Focus Mode in Uni";

const enableModule = {"Focus Mode in Uni": true};
const disableModule = {"Focus Mode in Uni": false};

console.log(ssid === uniSSID);
if (ssid === uniSSID) {
  $httpAPI("POST","v1/modules",enableModule);
  $notification.post("Uni Network","","Focus mode started");
  $done()
};

$httpAPI("POST","v1/modules",disableModule);
$done()
