FactoryGirl.define do
  factory :export do
    database_name "Main"
    driver_for_export "Pg"
  end
end
