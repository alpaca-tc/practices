##
# tagの入れ子構造をチェックする
class ValidTag
  ##
  # @param [Array]
  #   accept_tag: 許可するtagの種類
  # @example
  #   valid_tag = new ValidTag(["span", "html", "a"])
  constructor : (accept_tag = [])->
    # @accept_tag = accept_tag
    # 問題とはいえ、内部にこの値を入れなきゃいけないのはおかしい。。
    @accept_tag = ["html", "head", "body", "div", "span", "ul", "form"]

    @html_reg = /(<[a-zA-Z0-9\/ '"=-_]+>)/
    @close_tag_reg = /<\/[^>]+>/

  ##
  # @param [String] HTMLのタグ文字列
  # @return [Boolean] htmlの入れ子構造が正しいかチェック
  check :(html) ->
    elements = @split_html_code_to_elements(html)
    stack = []

    for current_tag in elements
      if current_tag["type"] is "open_tag"
        stack.push(current_tag)
      else if current_tag["type"] is "close_tag"
        prev_tag = stack.pop()

        unless prev_tag["type"] is "open_tag" && prev_tag["tag_name"] is current_tag["tag_name"]
          return false

    true

  ##
  # @param [String] HTMLのタグ文字列
  # @return [Array] 分割されたHTMLタグを格納
  #   [
  #     {
  #       "orig": "オリジナルのタグ",
  #       "type": "タグの種類" @see @check_type_element()
  #       "tag_name": "タグの名前"
  #     }
  #   ]
  split_html_code_to_elements: (html) ->
    res = []
    elements = html.split(@html_reg)
    for tag in elements when tag
      element_obj = {
        "orig" : tag,
        "type": @check_type_element(tag)
        "tag_name": @get_tag_name(tag)
      }

      res.push element_obj if @accept_tag_check(element_obj["tag_name"])

    res

  ##
  # @param [String] HTMLのタグ
  # @return [String] open_tag, close_tag, text, empty
  check_type_element:(tag) ->
    # XXX もっと良い書き方ある
    if tag.match @close_tag_reg
      "close_tag"
    else if tag.match @html_reg
      "open_tag"
    else if tag.match /[^ ]+/
      "text"
    else
      "empty"

  accept_tag_check: (tag_name) ->
    @accept_tag.indexOf(tag_name) > -1

  get_tag_name: (tag) ->
    # XXX もっといい書き方ありそう。
    RegExp.$1 if tag.match(/([a-zA-Z]+)/)

validTag = new ValidTag()
