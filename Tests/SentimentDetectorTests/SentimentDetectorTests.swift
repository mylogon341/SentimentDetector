import Testing
@testable import SentimentDetector

@Test func testQuickPositiveMessages() async throws {
    let result = try SentimentDetector.quickAnalyse("I love this product! It's amazing and very helpful.")
  
  #expect(result == .positive)
}

@Test func testQuickNegativeMessages() async throws {
  let result = try SentimentDetector.quickAnalyse("This is really bad.")
  
  #expect(result == .negative)
}

@Test func testQuickNeutralMessages() async throws {
  let result = try SentimentDetector.quickAnalyse("This is a neutral review. Nothing special here.")
  
  #expect(result == .neutral)
}

@Test func testQuickEmptyString() async throws {
  do {
    _ = try SentimentDetector.quickAnalyse("")
    Issue.record("Expected an error for an empty string.")
  } catch {
    #expect(true)
  }
}

@Test func testQuickProfanityMessage() async throws {
  let result = try SentimentDetector.quickAnalyse("this is bullshit")
  #expect(result == .profanity)
}

@Test func testQuickInsultMessage() async throws {
  let result = try SentimentDetector.quickAnalyse("you're a total idiot")
  #expect(result == .insult)
}

@Test func testQuickThreatMessage() async throws {
  let result = try SentimentDetector.quickAnalyse("i'm going to beat you up")
  #expect(result == .threat)
}

@Test func testQuickSexualMessage() async throws {
  let result = try SentimentDetector.quickAnalyse("suck my dick")
  #expect(result == .sexual)
}

@Test func testPositiveMessages() async throws {
  let analysis = try SentimentDetector.analyse("I'm really happy with the service i received")
  
  #expect(try analysis.max.label == .positive)
}

@Test func testNegativeMessages() async throws {
  let analysis = try SentimentDetector.analyse("I had a really bad time tbf")
  
  #expect(try analysis.max.label == .negative)
}

@Test func testNeutralMessages() async throws {
  let analysis = try SentimentDetector.analyse("The window is open")
  
  #expect(try analysis.max.label == .neutral)
}

@Test func testEmptyString() async throws {
  do {
    _ = try SentimentDetector.analyse("")
    Issue.record("Expected an error for an empty string.")
  } catch {
    #expect(true)
  }
}

@Test func testProfanityMessage() async throws {
  let analysis = try SentimentDetector.analyse("fml")
  #expect(try analysis.max.label == .profanity)
}

@Test func testInsultMessage() async throws {
  let analysis = try SentimentDetector.analyse("youre a stupid idiot")
  #expect(try analysis.max.label == .insult)
}

@Test func testThreatMessage() async throws {
  let analysis = try SentimentDetector.analyse("i'm going to beat you up")
  #expect(try analysis.max.label == .threat)
}

@Test func testSexualMessage() async throws {
  let analysis = try SentimentDetector.analyse("suck my dick")
  #expect(try analysis.max.label == .sexual)
}
