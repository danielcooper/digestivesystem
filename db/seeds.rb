# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

r1 = Service.create :name => "radio1", :display_name => "Radio 1"
ext1 = Service.create :name => "1xtra", :display_name => "1Xtra"


r1.streams << Stream.create(:name => "live", :display_name => "Live Stream")
r1.streams << Stream.create(:name => "hero", :display_name => "Hero Promotion Stream")
r1.streams << Stream.create(:name => "promo", :display_name => "Promotion Stream")
r1.save


ext1.streams << Stream.create(:name => "live", :display_name => "Live Stream")
ext1.streams << Stream.create(:name => "hero", :display_name => "Hero Promotion Stream")
ext1.streams << Stream.create(:name => "promo", :display_name => "Promotion Stream")
ext1.save

