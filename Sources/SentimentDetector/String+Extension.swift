//
//  File.swift
//  SentimentDetector
//
//  Created by luke on 05/12/2025.
//

import Foundation

extension String {
  
  /// Strips out apostrophes and lowercases string to hopefully improve inference results
  var sanitised: String {

    var text = self.lowercased()
    
    // remove apostrophes (straight + curly)
    text = text.replacingOccurrences(
      of: "[\\'’]",
      with: "",
      options: .regularExpression
    )
    
    // remove full stops
    text = text.replacingOccurrences(
      of: "\\.",
      with: "",
      options: .regularExpression
    )
    
    // Collapse multiple spaces into one, trim edges
    text = text.replacingOccurrences(
      of: "\\s+",
      with: " ",
      options: .regularExpression
    ).trimmingCharacters(in: .whitespacesAndNewlines)
    
    return text
  }
}

