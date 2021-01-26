# eTrackings API for Ruby

[![Gem Downloads](https://img.shields.io/gem/dt/scb_easy_api.svg)](https://rubygems.org/gems/scb_easy_api)
[![Gem-version](https://img.shields.io/gem/v/scb_easy_api.svg)](https://rubygems.org/gems/scb_easy_api)

## Introduction

The ETrackings API for Ruby makes it easy to develop using ETrackings API

## Documentation

See the official API documentation for more information

- THAI: https://docs.etrackings.com/documents/overview

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'etrackings'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install etrackings
```

## Synopsis

Usage:

```ruby
# example.rb

class Example
  def client
    @client ||= Etrackings::Client.new do |config|
      config.api_key = ENV["etrackings_api_key"]
      config.key_secret = ENV["etrackings_key_secret"]
      config.language = ENV["etrackings_language"] || 'TH'
    end
  end

  def track_by_courier(courier = "dhl-express", tracking_no = "THBCA12652305942")
    # courier ให้ใส่ชื่อขนส่งที่ระบบรองรับ
    client.track(courier, tracking_no)
    # ดูเพิ่มเติม https://apps.etrackings.com/docs/trackings
  end

  def track_kerry_express(tracking_no = "THBCA12652305942")
    # สามารถ เรียกชื่อขนส่งได้เลย
    client.kerry_express(tracking_no)
    # ดูเพิ่มเติม https://apps.etrackings.com/docs/trackings
  end
end
```
