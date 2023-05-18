# idldb


## データベース(DB)の作成・接続
```
db = idldb()
db.file = '~/testdb.sav'          ; DBはidlのsave fileとして保存される。
db->create                        ; DBを新規作成。すでにファイルが存在する場合は不要。
db->connect                       ; DBへ接続
```


## DBへのデータ入力・削除
各データはレコード（IDとattribute(属性）のセット)として保存される。データを入力する際には、そのデータがどのIDのどの属性のデータなのかを指定する。
```
db->store, 'ID0', 'attr1', 30   ; データの入力
db->store, 'ID0', 'attr1', 2   

db->remove_attr, 'ID0', 'attr1'  ; attributeの削除
```

## DBへの書き込みモード
データ入力時に、同じID, attributeのデータが存在している場合、デフォルトでは上書きされるが、
`writing_mode`プロパティを1に設定すると、上書きを禁止できる。
```
db.writing_mode = 1
```

## DBへの接続モード
他のセッションにおいて既にDBに接続されている場合、競合を防ぐために、接続することができないようになっている。
強制的に接続する場合、`connecting_mode`プロパティを1に変更する。
```
db.connecting_mode = 1
```
