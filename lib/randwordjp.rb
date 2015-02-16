require 'randwordjp/version'
require 'date'
require 'yaml'
require 'sqlite3'

module Randwordjp
  @yamlfile= 'lib/randwordjp.yml'
  @dbfile = 'lib/randwordjp.db'

  # 半角数字の文字列を取得する
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の数字文字列
  def self.getNumeric( length = 10 )
    words = Array.new()
    length.times do
      words << ('0'..'9').to_a.sample()
    end
    return words.join
  end

  # 全角日本語の文字列を取得する。
  # 漢字は第一水準となる。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.getZenkakuAll(length = 10 )
    words = Array.new()
    base = YAML.load_file(@yamlfile)["worddata"]["daiichi"]
    length.times do
      words << base.split(//).sample()
    end
    return words.join
  end

  # 全角カタカナの文字列を取得する。
  # @param [Integer] length 文字列長
  # @param [Boolean] opt[:old] 旧仮名文字の利用の可否
  # @return [String] lengthで指定した文字列長の文字列
  def self.getZenkakuKataKana(length = 10, opt = {:old => false})
    words = Array.new()
    if opt[:old]
      base = ('ア'..'ン').to_a
    else 
      base = ('ア'..'ン').to_a.join.gsub(/ヰヱ/,"").split(//)
    end
    length.times do
      words << base.sample()
    end
    return words.join
  end

  # 全角ひらがなの文字列を取得する。
  # @param [Integer] length 文字列長
  # @param [Boolean] opt[:old] 旧仮名文字の利用の可否
  # @return [String] lengthで指定した文字列長の文字列
  def self.getZenkakuHiraKana(length = 10 , opt = {:old => false})
    words = Array.new()
    if opt[:old]
      base = ('あ'..'ん').to_a
    else
      base = ('あ'..'ん').to_a.join.gsub(/ゐゑ/,"").split(//)
    end
    length.times do
      words << base.sample()
    end
    return words.join
  end

  # ローマ字の文字列を取得する。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.getAlphabet(length = 10 )
    words = Array.new()
    base = ('a'..'z').to_a
    length.times do
      words << base.sample()
    end
    return words.join
  end

  # 数字＋ローマ字の文字列を取得する。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.getAlphanumeric(length = 10 )
    words = Array.new()
    base = ('0'..'9').to_a + ('a'..'z').to_a
    words << getAlphabet(1)
    length.times do
      words << base.sample()
    end
    return words.join
  end

  # 数字＋ローマ字+記号(-_)の文字列を取得する。
  # @param [Integer] length 文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.getAlphanumericPlus(length = 10 )
    words = Array.new()
    base = ('0'..'9').to_a + ('a'..'z').to_a + ["-", "_"]
    words << getAlphabet(1)
    (length - 1).times do
      words << base.sample()
    end
    return words.join
  end

  # メールアドレス風の文字列を取得する。
  # @param [String] randword トップレベルドメインの文字列を指定する。
  # @param [Integer] local_length ローカルパートの文字列長
  # @param [Integer] domain_lengh ドメインパートの文字列長
  # @return [String] lengthで指定した文字列長の文字列
  def self.getMailAddress(randword = "rand",local_length = 10, domain_length = 10)
    local_part = getAlphanumericPlus(rand(local_length)+1)
    domain_part = getAlphanumeric(rand(domain_length)+1) + "." + randword
    return local_part + "@" + domain_part
  end


  # Date型の日付を取得する。
  # @param [Date] date 指定日
  # @param [Integer] before 指定日より後の最大何日までを対象とする
  # @param [Integer] afute 指定日より前の最大何日までを対象とする
  # @return [Date] 日付を取得する
  def self.getDate(date = Date.today, before = 100, after = 100 )
    return (date + (rand(after))- (rand(before))).to_s
  end

  # String型の都道府県名を取得する
  # @return [String] 都道府県名
  def self.getTodofuken()
    todofuken_list = YAML.load_file(@yamlfile)["worddata"]["todofuken_list"]
    return todofuken_list.sample()
  end

  # Hash型の苗字データを取得する
  # @return [Hash] {:kanji => 漢字名, :kana => 読み仮名}
  def self.getMyoji()
    db = SQLite3::Database.new(@dbfile)
    sql = "select count(*) from myojilist;"
    id = Random.rand(((db.execute(sql))[0][0]).to_i)
    sql = "select * from myojilist where id = #{id};"
    data = db.execute(sql)
    return {kanji: data[0][1], kana: data[0][2]}
    db.close
  end

  # Hash型の名前データを取得する
  # genderは男性はMで女性はFになります。
  # @return [Hash] {:kanji => 漢字名, :kana => 読み仮名, :gender => 性別}
  def self.getNamae()
    db = SQLite3::Database.new(@dbfile)
    sql = "select count(*) from namaelist;"
    id = Random.rand(((db.execute(sql))[0][0]).to_i)
    sql = "select * from namaelist where id = #{id};"
    data = db.execute(sql)
    gender = "M"
    if data[0][3] == 2 
      gender = "F"
    end
    return {kanji: data[0][1], kana: data[0][2], gender: gender }
    db.close
  end

end
