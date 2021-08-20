require "http"

response = HTTP.get("https://data.cityofchicago.org/resource/xzkq-xp2w.json")

employees = JSON.parse(response.body)

puts "The first employee is:"
index = 0
max_pay = 0

pp employees[2]["annual_salary"]
while index < employees.length
  if employees[index]["annual_salary"].to_i > max_pay
    max_pay = employees[index]["annual_salary"].to_i
    max_person = employees[index]
  end
  index += 1
end

pp max_pay
