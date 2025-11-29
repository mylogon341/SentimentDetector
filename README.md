
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

### Installation

Adding this to your project is simply a case of adding `https://github.com/mylogon341/SentimentDetector.git` to Xcode Package manager.

### Usage

```swift
import SentimentDetector

// `.positive`
let result = try SentimentDetector.quickAnalyse("I love this product! It's amazing and very helpful.")

/*
[
 .neutral: 0.94,
 .profanity: 0.02,
  ...
]
*/
let result = try SentimentDetector.analyse("This product is completely fine.")

// (.positive: 0.96)
print(try result.max)

```

### Contribution
This is far from perfect, I'm sure. If you spot any issues, please open an issue under the 'Bad match' template and I'll look to build up the model and release a new version.  
