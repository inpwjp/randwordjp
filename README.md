[![Build Status](https://travis-ci.org/inpwjp/randwordjp.svg?branch=master)](https://travis-ci.org/inpwjp/randwordjp)

[![Dependency Status](https://gemnasium.com/badges/github.com/inpwjp/randwordjp.svg)](https://gemnasium.com/github.com/inpwjp/randwordjp)

# Randwordjp

randwordjp is a library for outputting the data of the Japanese at random .

randowrjp output the myoji, namae , Japanese postal code, Japanese state .

You use as faker during the creation of the test data.

randwordjpはランダムで日本語のデータを出力するためのライブラリです。

randowrjpは日本語の名前、苗字、日本の郵便番号、都道府県、などの出力を行うことができます。

テストデータの作成時にfakerのように利用してください。

## Installation
Randwordjp is require sqlite3 adapter and sequel.

Add this line to your application's Gemfile:

    gem 'randwordjp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install randwordjp

## Usage

require first.

		require 'randwordjp'

get namae(first name)
名前を取得する

		Randwordjp.namae

get myoji(family name)
苗字を取得する

		Randwordjp.myoji

get zip
郵便番号を取得する

		Randwordjp.zip

get address
住所を取得する

		Randwordjp.address

For more information , please refer to the yardoc.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/randwordjp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
