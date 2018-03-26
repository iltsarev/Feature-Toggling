[![Platform](https://img.shields.io/badge/platform-iOS-green.svg)]()
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)](https://swift.org)
![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![Build Status](https://travis-ci.org/iltsarev/Feature-Toggling.svg?branch=master)](https://travis-ci.org/iltsarev/Feature-Toggling)

Overview
--------
It's a lightweight example of iOS feature toggling system inspired by [Martin Fowler](https://martinfowler.com/articles/feature-toggles.html). If you have any questions you can ask me in [telegram](https://t.me/iltsarev).

You can also watch the video of my speech on [YouTube](https://youtu.be/H9Ff6R_4Mw8?t=4h45m00s) (in Russian).

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

Authors
--------

* **Ilya Tsarev** - *Initial work* - [iltsarev](https://github.com/iltsarev)

See also the list of [contributors](https://github.com/iltsarev/feature-toggling/contributors) who participated in this project.

License
--------

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
