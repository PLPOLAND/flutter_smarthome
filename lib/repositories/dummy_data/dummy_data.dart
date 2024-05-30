const dummy_devices = [
  {
    "@type": "Light",
    "id": 0,
    "room": 1,
    "slaveID": 8,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Blind",
    "id": 1,
    "room": 1,
    "slaveID": 8,
    "onSlaveID": 1,
    "name": "Garderoba",
    "typ": "BLIND",
    "switchUp": {"stan": "ON", "pin": 15},
    "switchDown": {"stan": "OFF", "pin": 16},
    "state": "NOTKNOW"
  },
  {
    "@type": "Light",
    "id": 4,
    "room": 2,
    "slaveID": 13,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 5,
    "room": 2,
    "slaveID": 13,
    "onSlaveID": 1,
    "name": "Poziom 2",
    "typ": "LIGHT",
    "swt": {"stan": "ON", "pin": 12},
    "pin": 12,
    "state": "ON"
  },
  {
    "@type": "Blind",
    "id": 6,
    "room": 2,
    "slaveID": 13,
    "onSlaveID": 2,
    "name": "Marcin",
    "typ": "BLIND",
    "switchUp": {"stan": "ON", "pin": 15},
    "switchDown": {"stan": "OFF", "pin": 16},
    "state": "UP"
  },
  {
    "@type": "Blind",
    "id": 8,
    "room": 3,
    "slaveID": 15,
    "onSlaveID": 0,
    "name": "Marek",
    "typ": "BLIND",
    "switchUp": {"stan": "OFF", "pin": 15},
    "switchDown": {"stan": "ON", "pin": 16},
    "state": "DOWN"
  },
  {
    "@type": "Light",
    "id": 9,
    "room": 3,
    "slaveID": 15,
    "onSlaveID": 1,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 10,
    "room": 3,
    "slaveID": 15,
    "onSlaveID": 2,
    "name": "Poziom 2",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 46,
    "room": 3,
    "slaveID": 14,
    "onSlaveID": 0,
    "name": "Gnd TV",
    "typ": "OUTLET",
    "swt": {"stan": "OFF", "pin": 15},
    "pin": 15,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 47,
    "room": 3,
    "slaveID": 14,
    "onSlaveID": 1,
    "name": "Gnd koło łóżka 1",
    "typ": "OUTLET",
    "swt": {"stan": "ON", "pin": 16},
    "pin": 16,
    "state": "ON"
  },
  {
    "@type": "Light",
    "id": 56,
    "room": 3,
    "slaveID": 14,
    "onSlaveID": 2,
    "name": "Gniazdko Biurko L",
    "typ": "OUTLET",
    "swt": {"stan": "ON", "pin": 13},
    "pin": 13,
    "state": "ON"
  },
  {
    "@type": "Light",
    "id": 57,
    "room": 3,
    "slaveID": 14,
    "onSlaveID": 3,
    "name": "Gniazdko Biurko P",
    "typ": "OUTLET",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 33,
    "room": 4,
    "slaveID": 16,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 34,
    "room": 4,
    "slaveID": 16,
    "onSlaveID": 1,
    "name": "Poziom 2",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Blind",
    "id": 35,
    "room": 4,
    "slaveID": 16,
    "onSlaveID": 2,
    "name": "Gościnny",
    "typ": "BLIND",
    "switchUp": {"stan": "ON", "pin": 15},
    "switchDown": {"stan": "OFF", "pin": 16},
    "state": "UP"
  },
  {
    "@type": "Light",
    "id": 36,
    "room": 5,
    "slaveID": 12,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 2,
    "room": 6,
    "slaveID": 11,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "ON", "pin": 13},
    "pin": 13,
    "state": "ON"
  },
  {
    "@type": "Blind",
    "id": 3,
    "room": 6,
    "slaveID": 11,
    "onSlaveID": 1,
    "name": "Łazienka Duża",
    "typ": "BLIND",
    "switchUp": {"stan": "OFF", "pin": 15},
    "switchDown": {"stan": "ON", "pin": 16},
    "state": "NOTKNOW"
  },
  {
    "@type": "Light",
    "id": 37,
    "room": 7,
    "slaveID": 8,
    "onSlaveID": 2,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 10},
    "pin": 10,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 11,
    "room": 8,
    "slaveID": 9,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 41,
    "room": 9,
    "slaveID": 17,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 42,
    "room": 9,
    "slaveID": 17,
    "onSlaveID": 1,
    "name": "Poziom 2",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Blind",
    "id": 43,
    "room": 9,
    "slaveID": 17,
    "onSlaveID": 2,
    "name": "Rodzice",
    "typ": "BLIND",
    "switchUp": {"stan": "ON", "pin": 15},
    "switchDown": {"stan": "OFF", "pin": 16},
    "state": "NOTKNOW"
  },
  {
    "@type": "Blind",
    "id": 40,
    "room": 10,
    "slaveID": 18,
    "onSlaveID": 0,
    "name": "Taras",
    "typ": "BLIND",
    "switchUp": {"stan": "OFF", "pin": 16},
    "switchDown": {"stan": "ON", "pin": 15},
    "state": "NOTKNOW"
  },
  {
    "@type": "Blind",
    "id": 38,
    "room": 10,
    "slaveID": 19,
    "onSlaveID": 0,
    "name": "Jadalnia",
    "typ": "BLIND",
    "switchUp": {"stan": "OFF", "pin": 16},
    "switchDown": {"stan": "ON", "pin": 15},
    "state": "NOTKNOW"
  },
  {
    "@type": "Blind",
    "id": 39,
    "room": 10,
    "slaveID": 18,
    "onSlaveID": 1,
    "name": "Przy Tarasie",
    "typ": "BLIND",
    "switchUp": {"stan": "OFF", "pin": 13},
    "switchDown": {"stan": "ON", "pin": 12},
    "state": "NOTKNOW"
  },
  {
    "@type": "Light",
    "id": 50,
    "room": 10,
    "slaveID": 21,
    "onSlaveID": 0,
    "name": "Przedpokój",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 51,
    "room": 10,
    "slaveID": 21,
    "onSlaveID": 1,
    "name": "Przedpokój/Jadalnia",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 44,
    "room": 11,
    "slaveID": 10,
    "onSlaveID": 0,
    "name": "Poziom 1",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Blind",
    "id": 45,
    "room": 11,
    "slaveID": 10,
    "onSlaveID": 1,
    "name": "Kuchnia",
    "typ": "BLIND",
    "switchUp": {"stan": "ON", "pin": 15},
    "switchDown": {"stan": "OFF", "pin": 16},
    "state": "NOTKNOW"
  },
  {
    "@type": "Light",
    "id": 52,
    "room": 11,
    "slaveID": 10,
    "onSlaveID": 2,
    "name": "Jadalnia",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 48,
    "room": 12,
    "slaveID": 20,
    "onSlaveID": 0,
    "name": "Boczne",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 49,
    "room": 12,
    "slaveID": 20,
    "onSlaveID": 1,
    "name": "Górne ",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 53,
    "room": 13,
    "slaveID": 22,
    "onSlaveID": 0,
    "name": "Wiatrołap",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 13},
    "pin": 13,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 54,
    "room": 13,
    "slaveID": 22,
    "onSlaveID": 1,
    "name": "Podcień",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 12},
    "pin": 12,
    "state": "OFF"
  },
  {
    "@type": "Light",
    "id": 55,
    "room": 13,
    "slaveID": 22,
    "onSlaveID": 2,
    "name": "Kapliczka",
    "typ": "LIGHT",
    "swt": {"stan": "OFF", "pin": 10},
    "pin": 10,
    "state": "OFF"
  }
];
var dummy_sensors = [
  {
    "@type": "Termometr",
    "id": 100,
    "room": 7,
    "onSlaveID": -1,
    "addres": [40, 97, 100, 17, 141, 245, 237, 83],
    "name": "Kotłownia",
    "typ": "THERMOMETR",
    "temperatura": 22.56,
    "max": 225.0,
    "min": 0.0,
    "slaveAdress": 8
  },
  {
    "@type": "Higrometr",
    "id": 2,
    "room": 3,
    "onSlaveID": -1,
    "addres": [0, 0, 0, 0, 0, 0, 0, 0],
    "nazwa": "test",
    "typ": "THERMOMETR_HYGROMETR",
    "temperatura": 25.5,
    "maxTemperatura": 28,
    "minTemperatura": 15,
    "humidity": 50,
    "maxHumidity": 100,
    "minHumidity": 0,
    "slaveAdress": 15
  },
  {
    "@type": "Termometr",
    "id": 101,
    "room": 2,
    "onSlaveID": -1,
    "addres": [40, 97, 100, 17, 141, 241, 21, 222],
    "name": "Marcin",
    "typ": "THERMOMETR",
    "temperatura": 23.56,
    "max": 127.0,
    "min": 0.0,
    "slaveAdress": 13
  },
  {
    "@type": "Termometr",
    "id": 102,
    "room": 3,
    "onSlaveID": -1,
    "addres": [40, 97, 100, 17, 144, 126, 153, 156],
    "name": "Marek",
    "typ": "THERMOMETR",
    "temperatura": 24.06,
    "max": 3541565.0,
    "min": 0.0,
    "slaveAdress": 15
  },
  {
    "@type": "Termometr",
    "id": 103,
    "room": 8,
    "onSlaveID": -1,
    "addres": [40, 137, 24, 112, 13, 0, 0, 152],
    "name": "Korytarz",
    "typ": "THERMOMETR",
    "temperatura": 24.0,
    "max": 127.0,
    "min": 0.0,
    "slaveAdress": 11
  },
  {
    "@type": "Button",
    "id": 126,
    "room": 13,
    "onSlaveID": 3,
    "addres": [0, 0, 0, 0, 0, 0, 0, 0],
    "name": "Światło",
    "typ": "BUTTON",
    "pin": 14,
    "funkcjeKlikniec": [
      {
        "state": "NONE",
        "type": "CLICKED",
        "clicks": 1,
        "device": {
          "@type": "Light",
          "id": 53,
          "room": 13,
          "slaveID": 22,
          "onSlaveID": 0,
          "name": "Wiatrołap",
          "typ": "LIGHT",
          "swt": {"stan": "OFF", "pin": 13},
          "pin": 13,
          "state": "OFF"
        }
      },
      {
        "state": "NONE",
        "type": "CLICKED",
        "clicks": 2,
        "device": {
          "@type": "Light",
          "id": 54,
          "room": 13,
          "slaveID": 22,
          "onSlaveID": 1,
          "name": "Podcień",
          "typ": "LIGHT",
          "swt": {"stan": "OFF", "pin": 12},
          "pin": 12,
          "state": "OFF"
        }
      }
    ],
    "slaveAdress": 22
  },
  {
    "@type": "Button",
    "id": 127,
    "room": 13,
    "onSlaveID": 4,
    "addres": [0, 0, 0, 0, 0, 0, 0, 0],
    "name": "Podcień",
    "typ": "BUTTON",
    "pin": 9,
    "funkcjeKlikniec": [
      {
        "state": "NONE",
        "type": "CLICKED",
        "clicks": 1,
        "device": {
          "@type": "Light",
          "id": 54,
          "room": 13,
          "slaveID": 22,
          "onSlaveID": 1,
          "name": "Podcień",
          "typ": "LIGHT",
          "swt": {"stan": "OFF", "pin": 12},
          "pin": 12,
          "state": "OFF"
        }
      }
    ],
    "slaveAdress": 22
  }
];
var dummy_automations = [
  {
    "id": 0,
    "name": "Światła Marek",
    "actions": [
      {
        "device": {
          "@type": "Light",
          "id": 9,
          "room": 3,
          "slaveID": 15,
          "onSlaveID": 1,
          "name": "Poziom 1",
          "typ": "LIGHT",
          "state": "OFF",
          "pin": 13
        },
        "activeDeviceState": "ON",
        "allowReverse": true
      },
      {
        "device": {
          "@type": "Light",
          "id": 10,
          "room": 3,
          "slaveID": 15,
          "onSlaveID": 2,
          "name": "Poziom 2",
          "typ": "LIGHT",
          "state": "OFF",
          "pin": 12
        },
        "activeDeviceState": "ON",
        "allowReverse": true
      }
    ],
    "reversState": true,
    "type": "BUTTON",
    "button": {
      "@type": "Button",
      "id": 106,
      "room": 3,
      "onSlaveID": 4,
      "addres": null,
      "nazwa": "Światło",
      "typ": "BUTTON",
      "pin": 14,
      "funkcjeKlikniec": [
        {
          "state": "NONE",
          "type": "CLICKED",
          "clicks": 1,
          "device": {
            "@type": "Light",
            "id": 9,
            "room": 3,
            "slaveID": 15,
            "onSlaveID": 1,
            "name": "Poziom 1",
            "typ": "LIGHT",
            "state": "OFF",
            "pin": 13
          }
        },
        {
          "state": "NONE",
          "type": "CLICKED",
          "clicks": 2,
          "device": {
            "@type": "Light",
            "id": 10,
            "room": 3,
            "slaveID": 15,
            "onSlaveID": 2,
            "name": "Poziom 2",
            "typ": "LIGHT",
            "state": "OFF",
            "pin": 12
          }
        }
      ],
      "slaveAdress": 15
    },
    "clicks": 3,
    "clickType": "CLICKED",
    "active": false
  },
];
