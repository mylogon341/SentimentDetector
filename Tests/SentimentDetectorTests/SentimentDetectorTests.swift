import Testing
@testable import SentimentDetector

@Test func testSentimentScore() async throws {
  let positive = try SentimentDetector.analyse("it was really fun")
  #expect(try positive.max.label == .positive)
  #expect(try positive.max.value > 0.85)
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
  let result = try SentimentDetector.quickAnalyse("so hot 🤤")
  #expect(result == .sexual)
}

@Test func testPositiveMessages() async throws {
  let positive1 = try SentimentDetector.quickAnalyse("I'm really happy with the service i received")
  #expect(positive1 == .positive)
  
  let positive2 = try SentimentDetector.quickAnalyse("i thought it was going to be boring but it turned out quite good")
  #expect(positive2 == .positive)
  
  let positive3 = try SentimentDetector.quickAnalyse("it was quite a lot of fun")
  #expect(positive3 == .positive)
  
}

@Test func testPositiveMessageScore() async throws {
  let analysis = try SentimentDetector.analyse("I'm really happy with the service i received")
  
  #expect(analysis.valueFor(.positive) > 0.8)
}

@Test func testNegativeMessages() async throws {
  let negative1 = try SentimentDetector.analyse("I had a bad time")
  #expect(try negative1.max.label == .negative)
  
  // TODO: Make this pass
//  let negative2 = try SentimentDetector.analyse("i need this like a hole in my head")
//  #expect(try negative2.max.label == .negative)
  
  let negative3 = try SentimentDetector.analyse("this is rubbish")
  #expect(try negative3.max.label == .negative)
}

@Test func testNeutralMessages() async throws {
  let neutral1 = try SentimentDetector.analyse("The window is open")
  #expect(try neutral1.max.label == .neutral)
  
  let neutral2 = try SentimentDetector.analyse("im going to the shops")
  #expect(try neutral2.max.label == .neutral)
  
  let neutral3 = try SentimentDetector.analyse("the weather is ok today")
  #expect(try neutral3.max.label == .neutral)
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
  let profanity1 = try SentimentDetector.analyse("fml")
  #expect(try profanity1.max.label == .profanity)
  //TODO: Get this to pass
  //  let profanity2 = try SentimentDetector.analyse("get fucked")
  //  #expect(try profanity2.max.label == .profanity)
  //
  //  let profanity3 = try SentimentDetector.analyse("fuck off")
  //  #expect(try profanity3.max.label == .profanity)
}

@Test func testInsultMessage() async throws {
  let analysis = try SentimentDetector.analyse("you're more trouble that you're worth")
  #expect(try analysis.max.label == .insult)
}

@Test func testThreatMessage() async throws {
  let analysis = try SentimentDetector.analyse("i'm going to beat you up")
  #expect(try analysis.max.label == .threat)
}

@Test func testVagueMessages() async throws {
  // is it a hot day? the emoji says your intention is otherwise
  let vague1 = try SentimentDetector.quickAnalyse("so hot 🤤")
  #expect(try vague1 == .sexual)
}

/// These could be taken multiple ways, depending on personal interpretation/ context.
@Test func testDualMeanings() throws {
  
  // depends on your own personal definition
  let dual1 = try SentimentDetector.quickAnalyse("it went well")
  #expect(checkEitherMeaning(value: dual1, .positive, .neutral))
  
  let dual2 = try SentimentDetector.quickAnalyse("that was shit")
  #expect(checkEitherMeaning(value: dual2, .profanity, .negative))
  
  // depends what youre talking about/ who you're talking to
  let dual3 = try SentimentDetector.quickAnalyse("this is terrible")
  #expect(checkEitherMeaning(value: dual3, .insult, .negative))
  
  let dual4 = try SentimentDetector.quickAnalyse("get fucked")
  #expect(checkEitherMeaning(value: dual4, .sexual, .profanity))
}

func checkEitherMeaning(value: PredictionLabel, _ one: PredictionLabel, _ two: PredictionLabel) -> Bool {
  value == one ||
  value == two
}

@Test func testTextSanitisation() {
  #expect(
    "You're not      a lot of good. This is  a ’ not a'".sanitised ==
    "youre not a lot of good this is a not a"
  )
}
