
# Sentiment Detector

### About

This is a fairly basic sentiment text clasification library. Passing in English text returns either a single category or a full dictionary of confidence ratings for the seven built in categories:
- Threat
- Insult
- Sexual
- Positive
- Neutral
- Negative
- Profanity

This project was all about learning the basics of CoreML training, but it’s actually pretty good to share with others now. It’s a fairly lightweight library that can act as a front-end detector, running all the work offline on your device. 

> __If you're finding your results aren't suitable for your purpose, try an earlier version of the library to see if it fits better.__

### Installation

Adding this to your project is simply a case of adding `https://github.com/mylogon341/SentimentDetector.git` to Xcode Package manager.

### Suppported platforms

I've supported as many plaforms and targets as possible.  
However, on < macOS 11, you can only run `quickAnalyse`.

```json
platforms: [
  .iOS(.v13),
  .macOS(.v10_15),
  .tvOS(.v12),
  .visionOS(.v1)
],
```

### Usage

```swift

// Results may vary per model version. These are for demonstration purposes.

import SentimentDetector

// `.positive`
let result = try SentimentDetector.quickAnalyse("I love this product! It's amazing and very helpful.")

// (.positive: 0.96)
print(try result.max) 

/*
[
 .neutral: 0.94,
 .profanity: 0.02,
  ...
]
*/
let result = try SentimentDetector.analyse("This product is completely fine.")
```

### Contribution
This is far from perfect, I'm sure. If you spot any issues, please open an issue under the 'Bad match' template and I'll look to build up the model and release a new version.  

Alternatively, if you want to remain anonymous / you don't want your content to be public, feel free to submit the same data via [Google Forms here](https://forms.gle/hjfCU45WG63yL3Y97).