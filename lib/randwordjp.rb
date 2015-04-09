# coding: utf-8
require 'randwordjp/version'
require 'date'
require 'yaml'
require 'sequel'

# Randwordjp
# ランダムで日本語文字列などを生成するライブラリとなります。
# can get random words(sentence).
module Randwordjp

  @dbfile = File.dirname(__FILE__) + '/randwordjp.db'
  @yamlfile = File.dirname(__FILE__) + '/randwordjp.yml'

  if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'
    require 'jdbc/sqlite3'
    @db_connect = 'jdbc:sqlite:' + @dbfile
  else
    require 'sqlite3'
    @db_connect = 'sqlite://' + @dbfile
  end

  # 半角数字の文字列を取得する
  # @param [Integer] length 文字列長 # @return [String] lengthで指定した文字列長の数字文字列
  def self.numeric(length = 10)
    words = []
    length.times do
      words << ('0'..'9').to_a.sample
    end
    words.join
  end

  # 全角日本語の文字列を取得する。
  # 漢字は第一水準となる。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.zenkaku_all(length = 10)
    words = []
    base = YAML.load_file(@yamlfile)['worddata']['daiichi']
    length.times do
      words << base.split(//).sample
    end
    words.join
  end

  # 全角カタカナの文字列を取得する。
  # @param [Integer] length 文字列長
  # @param [Boolean] opt[:old] 旧仮名文字の利用の可否
  # @return [String] lengthで指定した文字列長の文字列
  def self.zenkaku_katakana(length = 10, opt = { old: false })
    words = []
    if opt[:old]
      base = ('ア'..'ン').to_a
    else
      base = ('ア'..'ン').to_a.join.gsub(/ヰヱ/, '').split(//)
    end
    length.times do
      words << base.sample
    end
    words.join
  end

  # 全角ひらがなの文字列を取得する。
  # @param [Integer] length 文字列長
  # @param [Boolean] opt[:old] 旧仮名文字の利用の可否
  # @return [String] lengthで指定した文字列長の文字列
  def self.zenkaku_hirakana(length = 10, opt = { old: false })
    words = []
    if opt[:old]
      base = ('あ'..'ん').to_a
    else
      base = ('あ'..'ん').to_a.join.gsub(/ゐゑ/, '').split(//)
    end
    length.times do
      words << base.sample
    end
    words.join
  end

  # ローマ字の文字列を取得する。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.alphabet(length = 10)
    words = []
    base = ('a'..'z').to_a
    length.times do
      words << base.sample
    end
    words.join
  end

  # 数字＋ローマ字の文字列を取得する。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.alphanumeric(length = 10)
    words = []
    base = ('0'..'9').to_a + ('a'..'z').to_a
    words << alphabet(1)
    length.times do
      words << base.sample
    end
    words.join
  end

  # 数字＋ローマ字+記号(-_)の文字列を取得する。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.alphanumeric_plus(length = 10)
    words = []
    base = ('0'..'9').to_a + ('a'..'z').to_a + ['-', '_']
    words << alphabet(1)
    (length - 1).times do
      words << base.sample
    end
    words.join
  end

  # メールアドレス風の文字列を取得する。
  # @param [String] randword トップレベルドメインの文字列を指定する。
  # @param [Integer] local_length ローカルパートの文字列長
  # @param [Integer] domain_lengh ドメインパートの文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.mail_address(randword = 'rand', local_length = 10, domain_length = 10)
    local_part = alphanumeric_plus(rand(local_length) + 1)
    domain_part = alphanumeric(rand(domain_length) + 1) + '.' + randword
    local_part + '@' + domain_part
  end

  # Date型の日付を取得する。
  # @param [Date] date 指定日
  # @param [Integer] before 指定日より後の最大何日までを対象とする
  # @param [Integer] afute 指定日より前の最大何日までを対象とする
  # @return [Date] 日付を取得する
  def self.date(date = Date.today, before = 100, after = 100)
    (date + (rand(after)) - (rand(before))).to_s
  end

  # String型の都道府県名を取得する
  # @return [String] 都道府県名
  def self.todofuken
    todofuken_list = YAML.load_file(@yamlfile)['worddata']['todofuken_list']
    todofuken_list.sample
  end

  # Hash型の苗字データを取得する
  # @return [Hash] :kanji => 漢字名, :kana => 読み仮名
  def self.myoji
    table = 'myojilist'
    Sequel.connect(@db_connect) do |db|
      data = db.from(table)
      id = Random.rand(data.count + 1)
      while id == 0
        id = Random.rand(data.count + 1)
      end
      @myoji_datum = data.select(:kanji, :yomi).where(id: id).first
    end
    { kanji: @myoji_datum[:kanji], kana: @myoji_datum[:yomi] }
  end

  # Hash型の名前データを取得する
  # genderは男性はMで女性はFになります。
  # @param [Symbol] opt[:only] :male 男性のみの出力 :female 女性のみの出力
  # @return [Hash] :kanji => 漢字名, :kana => 読み仮名, :gender => 性別
  def self.namae(opt = {only: false } )
    table = 'namaelist'
    Sequel.connect(@db_connect) do |db|
      data = db.from(table)
      if opt[:only] == :male
        data = data.where(gender: 1)
      elsif opt[:only] == :female
        data = data.where(gender: 2)
      end
      no = Random.rand(data.count)
      data = data.select(:kanji, :yomi, :gender)
      @namae_datum = data.limit(1).offset(no).first
    end
    gender = 'M'
    if @namae_datum[:gender] == 2
      gender = 'F'
    end
    { kanji: @namae_datum[:kanji], kana: @namae_datum[:yomi], gender: gender }
  end

  # 日本の郵便番号を取得します
  # @param [Symbol] opt[:hyphen] true ハイフンありで出力 false ハイフン無しで出力
  # @return [String] 郵便番号
  def self.zip(opt = {hyphen: false } )
    table = 'ziplist'
    Sequel.connect(@db_connect) do |db|
      data = db.from(table)
      no = Random.rand(data.count)
      data = data.select(:zip)
      @zip_data = (data.limit(1).offset(no).first)[:zip]
    end
    if opt[:hyphen]
      return @zip_data[0,3] + "-" + @zip_data[3,4]
    end
    return @zip_data
  end
end
