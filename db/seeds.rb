require 'csv'

CSV.foreach('db/driver.csv') do |row|
    Driver.create(:name => row[0],:tel => row[1],:car_number => row[2])
end