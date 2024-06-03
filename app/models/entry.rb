class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room
  #Userが自分が参加しているRoomsにアクセスする必要がある場合、Entryを通してRoomsにアクセス
end
