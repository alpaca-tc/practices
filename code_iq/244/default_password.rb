# coding: utf-8

require 'active_support/all'

##
# パスワード生成クラス
class DefaultPassword
  ##
  # @param [Integer, Range] length
  #   生成する文字列の長さ
  # @param [Object] generator
  #   generater(length), validate(length)メソッドを持つオブジェクト
  def initialize(length, generator = nil)
    @length = length
    @generator = generator
  end

  def generate
    @generator.generate(@length)
  end

  ##
  # @param [String] str
  #   正当性チェックする文字列
  # XXX validateではなくvalidate?の方が適切かと。
  def validate?(str)
    str.strip!
    @generator.validate?(@length, str)
  end
end

module Randobet
  # @exnted_str 生成する文字列の種類を拡張する
  #   String, Range, Arrayが指定可能
  mattr_accessor :extend_str

  # TODO 実際の運用では、0Oなど間違いやすい文字列は消す
  @@alpha_small = 'a'..'z'
  @@alpha_large = 'A'..'Z'
  @@numeric     = '0'..'9'

  # 最低限使用する文字の種類
  @@str_type    = 3

  class << self
    ##
    # @param [Integer, Range] length 生成する文字列の長さ
    # @return [String] ランダムな文字列
    def generate(length)
      length = length.is_a?(Range) ? length.to_a.sample : length

      str_enumerable = str_container.cycle

      # FIXME ワンライナーで書きたい...
      Array.new(length) do
        str_array = *str_enumerable.next
        str_array.sample
      end.shuffle.join
    end

    ##
    # @param [Integer, Range] length チェックする文字列の長さ
    # @return [String] チェック対象文字列
    def validate?(length, str)
      length_check(length, str) && str_check(str)
    end

    private
    def length_check(length, str)
      length = *length
      length.include? str.length
    end

    def str_check(subject)
      count = 0
      str_container.each do |str_range|
        check_reg = Regexp.union(*str_range)
        count += 1 if check_reg =~ subject
      end

      count >= @@str_type
    end

    def str_container
      @@str_container ||= [@@alpha_small, @@alpha_large, @@numeric, @@extend_str].compact
    end
  end
end
