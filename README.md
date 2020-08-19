本の書評投稿サイトです。

○開発環境
開発言語及びフレームワーク: Ruby2.7.1 / Rails5.2.4.3 / HTML / CSS / Javascript
インフラ： Docker
テスト：RSpec
データベース：MySQL(AWS RDS)

○運用環境
AWS (VPC / EC2 / RDS / Route53 / ACM )

○機能
ユーザー登録書評の投稿/本の登録
ログイン認証 ： Railsのsession機能
ユーザー/本/書評のお気に入り登録 ： 中間テーブルへの保存
ページネーション ： Gemを使用（kaminari）
HTTPS対応 ： AWS ACM

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
