# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者は管理者用のログインページで入力
Admin.create!(
  email: '111@111',
  password: '111111',
  )

Category.create!(
  name: 'マンガ',
  )
Category.create!(
  name: '小説',
  )
Category.create!(
  name: 'ライトノベル',
  )

EndUser.create!(
  last_name: 'ゲスト',
  first_name: 'ユーザー',
  last_name_kana: 'ゲスト',
  first_name_kana: 'ユーザー',
  nickname: 'ゲストユーザー',
  introduction: 'ゲスト用です',
  postal_code: '1111111',
  address: '東京都一丁目一番地',
  telephone_number: '11111111111',
  email: 'guest@example.com',
  password: '111111',
  )