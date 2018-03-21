[![Platform](https://img.shields.io/badge/platform-iOS-green.svg)]()
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)](https://swift.org)
![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![Build Status](https://travis-ci.org/iltsarev/Feature-Toggling.svg?branch=master)](https://travis-ci.org/iltsarev/Feature-Toggling)

Overview
--------
It's a lightweight example of iOS feature toggling system. If you have any questions you can ask me in [telegram](https://t.me/iltsarev).

Usage
--------

Initialize feature service somewhere in your code:
``` swift
private let featureService = FeaturesService()
```

Get features from backend:
``` swift
featureService.getFeatures {}
```

Check if feature is enabled:
``` swift
if (featureService.enabled(.myFeature)) {
  // doSomething
}
```


License
--------

MIT.
