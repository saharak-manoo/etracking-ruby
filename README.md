# eTrackings API for Ruby

[![Gem Downloads](https://img.shields.io/gem/dt/scb_easy_api.svg)](https://rubygems.org/gems/scb_easy_api)
[![Gem-version](https://img.shields.io/gem/v/scb_easy_api.svg)](https://rubygems.org/gems/scb_easy_api)

## Introduction

The eTrackings API for Ruby makes it easy to develop using eTrackings API

## Documentation

See the official API documentation for more information

- THAI: https://etrackings.com/documents/overview

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'etracking'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install etracking
```

## Synopsis

Usage:

```ruby
# example.rb

class Example
  def client
    @client ||= Etracking::Client.new do |config|
      config.api_key = ENV["etracking_api_key"]
      config.key_secret = ENV["etracking_key_secret"]
      config.language = ENV["etracking_language"] || 'TH'
    end
  end

  def track_by_courier(courier = "dhl_express", tracking_number = "THBCA12652305942")
    # courier ให้ใส่ชื่อขนส่งที่ระบบรองรับ
    client.track(courier, tracking_number)
    #https://etrackings.com/documents/trackings
  end

  def track_kerry_express(tracking_number = "THBCA12652305942")
    # สามารถ เรียกชื่อขนส่งได้เลย
    client.kerry_express(tracking_number)
    #https://etrackings.com/documents/trackings
  end
end
```
