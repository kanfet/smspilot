require "spec_helper"

describe SmsPilot do
  let(:client) { SmsPilot.new("XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ") }

  describe "#sms" do

    context "when message defined as separate args" do
      it "sends sms" do
        text = "Test message"
        number = "79087964781"
        result = client.sms(text, number)
        result.should include('send')
        result['send'].length.should eq(1)
        result['send'][0]['text'].should eq(text)
        result['send'][0]['to'].should eq(number)
      end
    end

    context "when message defined as hash" do
      it "sends sms" do
        text = "Test message"
        number = "79087964781"
        result = client.sms({text: text, to: number})
        result.should include('send')
        result['send'].length.should eq(1)
        result['send'][0]['text'].should eq(text)
        result['send'][0]['to'].should eq(number)
      end
    end

    context "when messages defined as array" do
      it "sends sms" do
        messages = [
            {:to => "79087964781", :text => 'Test message'},
            {:to => "79087964782", :text => "Another test message"},
            {:to => "79087964783", :text => "And the final test message"}
        ]
        result = client.sms(messages)
        result.should include('send')
        result['send'].length.should eq(messages.length)
        result['send'].each_with_index do |posted_message, index|
          posted_message['to'].should eq(messages[index][:to])
          posted_message['text'].should eq(messages[index][:text])
        end
      end
    end

    context "when messages not defined" do
      it "raises ArgumentError" do
        expect{ client.sms(nil) }.to raise_error(ArgumentError)
      end
    end

  end

  it "checks sms statuses by their ids" do
    result = client.check(10000, 10001, 10002)
    result.should include('check')
    result['check'].length.should eq(3)
  end

  it "checks sms statuses by packet id" do
    result = client.check_packet(1234)
    result.should include('check')
  end

  it "gets balance" do
    result = client.balance
    result.should include('balance')
  end

  it "gets user info" do
    result = client.user_info
    result.should include('info')
  end

  it "gets inbound messages" do
    result = client.inbound
    result.should include('inbound')
  end

  context "when api key is wrong" do
    it "responds with error" do
      client = SmsPilot.new("some wrong api key")
      result = client.user_info
      result.should include('error')
    end
  end

  context "when api key not defined" do
    it "raises ArgumentError" do
      expect{ SmsPilot.new(nil) }.to raise_error(ArgumentError)
    end
  end
end