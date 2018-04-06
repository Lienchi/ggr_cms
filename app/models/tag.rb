class Tag < ApplicationRecord
  belongs_to :tab
  belongs_to :category 
  #validates_presence_of :name
  #先只有設name，在想tab跟col是不是可以用我們自己的設定連結起來，不用讓使用者輸入
end
