# coding: utf-8
require 'randwordjp/version'
require 'date'
require 'yaml'

# Randwordjp
# ランダムで日本語文字列などを生成するライブラリとなります。
# can get random words(sentence).
module Randwordjp
@java_platform = false
  if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'
    require 'jdbc/sqlite3'
    Jdbc::SQLite3.load_driver
    @jdbc_sqlite = 'jdbc:sqlite:'
    @java_platform = true
    @dbfile = 'lib/randwordjp.db'
  else
    require 'sqlite3'
    @dbfile = 'lib/randwordjp.db'
  end
  @yamlfile = 'lib/randwordjp.yml'

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
    if @java_platform
      connection = java.sql.DriverManager.getConnection('jdbc:sqlite:lib/randwordjp.db')
      statement = connection.createStatement() 
      sql = "select count(*) from #{table};"
      rs = statement.executeQuery(sql)
      rs.next
      count = rs.getObject(1)
      id = Random.rand(count)
      sql = "select kanji,yomi from #{table} where id = #{id};"
      rs = statement.executeQuery(sql)
      rs.next
      kanji = rs.getObject(1)
      kana = rs.getObject(2)
      connection.close
    else
      db = SQLite3::Database.new(@dbfile)
      sql = "select count(*) from #{table};"
      count = ((db.execute(sql))[0][0]).to_i
      id = Random.rand(count)
      sql = "select * from #{table} where id = #{id};"
      data = db.execute(sql)
      db.close
      kanji = data[0][1]
      kana = data[0][2]
    end
    { kanji: kanji, kana: kana }
  end

  # Hash型の名前データを取得する
  # genderは男性はMで女性はFになります。
  # @return [Hash] :kanji => 漢字名, :kana => 読み仮名, :gender => 性別
  def self.namae
    table = 'namaelist'
    if @java_platform
      connection = java.sql.DriverManager.getConnection('jdbc:sqlite:lib/randwordjp.db')
      statement = connection.createStatement() 
      sql = "select count(*) from #{table};"
      rs = statement.executeQuery(sql)
      rs.next
      count = rs.getObject(1)
      id = Random.rand(count)
      sql = "select kanji,yomi,gender from #{table} where id = #{id};"
      rs = statement.executeQuery(sql)
      rs.next
      kanji = rs.getObject(1)
      kana = rs.getObject(2)
      gender_base = rs.getObject(3)
      connection.close
    else
      db = SQLite3::Database.new(@dbfile)
      sql = "select count(*) from #{table};"
      id = Random.rand(((db.execute(sql))[0][0]).to_i)
      sql = "select * from #{table} where id = #{id};"
      data = db.execute(sql)
      kanji = data[0][1]
      kana = data[0][2]
      gender_base = data[0][3]
      db.close
    end
    gender = 'M'
    if gender_base == 2
      gender = 'F'
    end
    { kanji: kanji, kana: kana, gender: gender }
  end
end
