# SMSPilot

Wrapper for [smspilot.ru](http://www.smspilot.ru/ "smspilot.ru") [API 2.х](http://www.smspilot.ru/download/SMSPilotRu-HTTP-v2.1.2.rtf "SMSPilotRu-HTTP-v2.1.2.rtf")

## Installation

It is while only via git. Add to your Gemfile

```
gem "sms_pilot", :git => "https://github.com/kanfet/smspilot.git"
```

And execute
```
bundle install
```

## Usage

#### Client creation

```ruby
client = SmsPilot.new(api_key)
```

#### SMS sending

* First way
```ruby
client.sms(text, to, from, id)
```
*text* and *to* only required (both must be a string)

* Second way
```ruby
client.sms({text: "text message", to: "79999999999", from: "Sender", id: 123})
```

* Last way (mass sending)
```ruby
client.sms([
   {:to => "79999999999", :text => 'First message'},
   {:to => "79999999998", :text => "Second message"},
   {:to => "79999999997", :text => "Third message"}
])
```

#### SMS status checking
* by id(s)
```ruby
client.check(id1, id2, id3)
```
* by packet
```ruby
client.check_packet(packet_id)
```

#### Balance
```ruby
client.balance
```

#### User info
```ruby
client.user_info
```

#### Inbound messages
```ruby
client.inbound
```
