// The Swift Programming Language
// https://docs.swift.org/swift-book
import CoreML
import NaturalLanguage

public enum PredictionLabel: String, CaseIterable {
  case positive
  case neutral
  case negative
  case insult
  case sexual
  case threat
  case profanity
}

public enum SentimentDetectorError: Error {
  case labelNotFound
  case unableToProcess
  case stringTooShort
  case calculationError
}

public struct SentimentDetector {
  
  public struct Analysis {
    let result: [PredictionLabel: Double]
    
    var max: (label: PredictionLabel, value: Double) {
      get throws {
        if let highest = result.max(by: { $0.value < $1.value }) {
          return (label: highest.key, value: highest.value)
        } else {
          throw SentimentDetectorError.calculationError
        }
      }
    }
  }
  
  @available(macOS 11.0, *)
  public static func analyse(_ text: String) throws -> Analysis {
    
    if text.isEmpty {
      throw SentimentDetectorError.stringTooShort
    }
    
    let mlModel = try SentimentClassifierv1(configuration: .init())
    let nlModel = try NLModel(mlModel: mlModel.model)
    
    let hypothesis = nlModel.predictedLabelHypotheses(for: text,
                                                      maximumCount: 5)
    
    let mappedValues: [PredictionLabel: Double] = Dictionary(uniqueKeysWithValues:
                        hypothesis.compactMap { key, value in
      guard let label = PredictionLabel(rawValue: key) else { return nil }
      return (label, value)
    })
    
    return .init(result: mappedValues)
  }
  
  /// Pass in a string. Returns a best guess with no confidence ratings.
  public static func quickAnalyse(_ text: String) throws -> PredictionLabel {
    
    if text.isEmpty {
      throw SentimentDetectorError.stringTooShort
    }
    
    let mlModel = try SentimentClassifierv1(configuration: .init())
    let nlModel = try NLModel(mlModel: mlModel.model)
    if let prediction = nlModel.predictedLabel(for: text) {
      
      guard let label = PredictionLabel(rawValue: prediction) else {
        throw SentimentDetectorError.labelNotFound
      }
      return label
    } else {
      throw SentimentDetectorError.unableToProcess
    }
  }
}
