require "pry"
data = IO.read("ExoWorlds_list_sorted_7_final 2/Planet list -Table 1.csv").split("\r\n").collect{|a| a.split(",")}.select{|a| a.length>2}

names = data[0]
units  = data[1]

header = []

names.each_with_index do |n,i|
  header[i] = "<td>#{n} #{units[i]}</td>"
end

planets = data[2..-1]

planets.each_with_index do |p,i|
  puts planets[i].length
  if planets[i][0].length == 0
     planets[i][0]=planets[i-1][0]
  end

  binding.pry if planets[i][0] == "PSR 1257 12"

  if planets[i].length == 7
    planets[i][7] = planets[i-1][7]
    planets[i][8] = planets[i-1][8]
    planets[i][9] = planets[i-1][9]
  end

  if planets[i].length < 10
    10.times do |itter|
      unless planets[i][itter]
        planets[i][itter] = ""
      end
    end
  end


end



table = planets.collect{|p| r = p.collect{|v| "<td>#{v}</td>"}.join(" "); "<tr>#{r}</tr>"}.join("\n")

File.open("planet_table.html", "w") do |file|
    file.puts "<thead>"
    file.puts "<tr>#{header.join(" ")}</tr>"
    file.puts "</thead>"

    file.puts "<tbody>"
    file.puts table
    file.puts "</tbody>"
end
