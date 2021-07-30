class Contact < ApplicationRecord

# お問い合わせ内容をプルダウン式で選択
  enum subject_name:{
    "利用方法に関して": 0, "利用規約に関して": 1, "その他のお問い合わせ": 2
  }
end
