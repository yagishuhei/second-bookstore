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

EndUser.create!(
  last_name: 'ゲスト',
  )
EndUser.create!(
  first_name: 'ユーザー',
  )
EndUser.create!(
  last_name_kana: 'ゲスト',
  )
EndUser.create!(
  first_name_kana: 'ユーザー',
  )
EndUser.create!(
  nickname: 'ゲストユーザー',
  )
EndUser.create!(
  introduction: 'ゲスト用です',
  )
EndUser.create!(
  postal_code: '1111111',
  )
EndUser.create!(
  address: '東京都一丁目一番地',
  )
EndUser.create!(
  telephone_number: '11111111111',
  )
EndUser.create!(
  email: 'guest@example.com',
  )
EndUser.create!(
  password: '111111',
  )