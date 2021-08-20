require "http"
system "clear"

puts "Welcome to Weathr"
while true
  puts "What city would you like to look up?"
  answer = gets.chomp.capitalize
  response = HTTP.get("http://api.openweathermap.org/data/2.5/weather?q=#{answer}&appid=#{ENV["OPEN_WEATHER_API_KEY"]}")
  weather_data = JSON.parse(response.body)

  if answer.downcase == "quit"
    puts "Goodbye"
    break
  end
  if weather_data["message"] == "city not found" || weather_data["cod"] == 401
    puts "Please try again"
  else
    puts "What unit of temperature would you like? F, C, or K?"
    temp_units = gets.chomp.downcase
    if temp_units.downcase == "quit"
      puts "Goodbye"
      break
    elsif temp_units == "f"
      temp_units = "imperial"
    elsif temp_units == "c"
      temp_units = "metric"
    elsif temp_units == "k"
      temp_units = "standard"
    else
      puts "Invalid. Default is Kelvin!"
    end

    response = HTTP.get("http://api.openweathermap.org/data/2.5/weather?q=#{answer}&appid=#{ENV["OPEN_WEATHER_API_KEY"]}&units=#{temp_units}")
    weather_data = JSON.parse(response.body)
    # pp weather_data
    # if answer.downcase == "quit"
    #   puts "Goodbye"
    #   break

    temp = weather_data["main"]["temp"]
    descrip = weather_data["weather"][0]["description"]
    puts "The weather in #{answer} today is #{temp} degrees with #{descrip}."

    response = HTTP.get("http://api.openweathermap.org/data/2.5/forecast?q=#{answer}&appid=#{ENV["OPEN_WEATHER_API_KEY"]}&units=#{temp_units}")
    weather_data = JSON.parse(response.body)
    # api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}
    # pp weather_data

    # day_1 = weather_data["list"][0]["main"]["temp"]

    puts "The 5 day forcast is:"
    index = 0
    5.times do
      puts "Day #{index + 1}'s temperature will be #{weather_data["list"][index]["main"]["temp"]}"
      index += 1
    end
  end
end
