require 'minitest_helper'

describe Question do
  describe "CheckboxList" do
    it "returns checked choices" do
      message = "How are you feeling"
      choices = [
        { label: "good", value: {sub: 1} },
        { label: "neutral", value: 0 },
        "horrible"
      ]

      input = [
        Question::TTY::CODE::UP,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::DOWN,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::DOWN,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::RETURN
      ]
      result = fake_input(input) { Question.checkbox_list(message, choices, default: [0]) }

      assert_equal result, [
        "horrible",
        {sub: 1}
      ]
    end
  end

  describe "List" do
    it "returns checked choices" do

      message = "How are you feeling"
      choices = [
        { label: "good", value: {sub: 1} },
        { label: "neutral", value: 0 },
        "horrible"
      ]

      choices.each_with_index do |choice, index|
        input = [Question::TTY::CODE::RETURN]
        index.times { input.unshift Question::TTY::CODE::DOWN }
        result = fake_input(input) { Question.list(message, choices) }
        assert_equal result, choice.is_a?(Hash) ? choice[:value] : choice
      end
    end
  end
end
