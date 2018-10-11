def ask(question)
	print question + " "
	return gets.chomp
end

def check_for_number(string)
  result = false
  if string.to_i.to_s.eql? string
    result =  true
  end
  return result
end

def show_main_menu
	puts "\n ===================="
	puts " | Bem-vindo!       |"
	puts " | Posso te ajudar? |"
	puts " ===================="
	puts "\n 1) COMPRAR ITENS"
	puts " 2) VENDER ITENS"
	puts " 3) SAIR"
end

def show_menu(item_hash)
	i = 1
	puts "\n"
	until i > item_hash.length
		printf " %i) %-15s $%s\n", i, item_hash[i]["name"], item_hash[i]["price"]
		i += 1
	end
end

def describe(item, item_hash)
	puts "\n " + item_hash[item]["description"]
end

def how_many
	number = 0
	loop do
		number = ask(" Quantos?")
		if (number.to_f < 0 || !check_for_number(number))
			puts "\n Number must be an integer, 0 or greater."
		end
	break if (number.to_f >= 0 && check_for_number(number))
	end
	return number.to_i
end

def sell(item, hash)
	describe(item, hash)
	quantity = how_many
	return quantity * hash[item]["price"]
end

def handle_error
	puts "\n Selection must be from menu."
	return false
end

# This can be changed to test player's ability to purchase
user_money = 20000

# This will be an array of items and their quantities
# user_items = {}

# These can be made specific for each city
# Actually, each item will only need to be made once, seeing as they reoccur
item_hash = {
	1 => { "name" => "CARVÃO", "description" => "Ajuda golpes tipo fogo. (SEGURA)", "price" => 9800 },
	2 => { "name" => "POKé BOLA", "description" => "Item para capturar os POKéMONS.", "price" => 200 },
	3 => { "name" => "POÇÃO", "description" => "Restaura 20 HP dos POKéMONS.", "price" => 300 },
	4 => { "name" => "SUPER POÇÃO", "description" => "Restaura 50 de HP dos POKéMONS.", "price" => 700 },
	5 => { "name" => "CORDADEFUGA", "description" => "Use para fugir de cavernas e etc.", "price" => 550 },
	6 => { "name" => "REPELENTE", "description" => "Repele POKéMONS por 100 passos.", "price" => 350 },
	7 => { "name" => "ANTÍDOTO", "description" => "Desenvenena o POKéMON.", "price" => 100 },
	8 => { "name" => "DESPARALISIA", "description" => "Desparaliza os POKéMONS.", "price" => 200 },
	9 => { "name" => "CARTA FLOR", "description" => "Uma CARTA flor. (SEGURA)", "price" => 50 }
}

loop do
	show_main_menu
	loop do 
		valid_input = true
		choice = ask("\n ::")
		if check_for_number(choice)
			choice = choice.to_i
		end

		if choice == 1
			loop do 
				show_menu(item_hash)
				keep_going = false
				quantity = 0
				total = 0
				loop do 
					valid_input = true
					choice = ask("\n ::")
					if (check_for_number(choice) && choice.to_f > 0 && choice.to_f <= item_hash.length)
						total = sell(choice.to_i, item_hash)
					else
						valid_input = handle_error
					end
				break if valid_input
				end

				puts "\n Seu total é de $#{total}."

				if user_money < total
					puts " You don't have enough money!"
				else
					user_money -= total
					# user_items.push(item_hash[choice.to_i])
					# puts " Your inventory: #{user_items[0]["name"]}"
				end
				puts " You currently have $#{user_money}."
				loop do
					valid_input = true
					keep_going = ask(" Something else? (Y/N)").downcase
					if (keep_going != "y" && keep_going != "n")
						puts "\n Please enter \"Y\" or \"N\"."
						valid_input = false
					end
				break if valid_input
				end

			break if keep_going.downcase == "n"
			end

		elsif choice == 2
			puts "\n Under construction."
		elsif choice == 3
			puts "\n Thank you, please come again!"
			exit
		else
			valid_input = handle_error
		end

	break if (valid_input)
	end

end