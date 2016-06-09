#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	@e_holder = "e-mail"
	@mess = "Вы можете оставить нам сообщение:"
	erb :contacts
end

def w_to_f arr
	output = File.open './public/users.txt', 'a'
	output.write "user: #{arr[0]}, tel: #{arr[1]}, date: #{arr[2]}, time: #{arr[3]}, master: #{arr[4]}\n"
	output.close
end

def w_to_c arr
	output = File.open './public/contacts.txt','a'
	output.write "start=========#{arr[0]}==============\n"
	output.write "#{arr[1]}\n"
	output.write "end===========#{arr[0]}==============\n"
	output.close
end	


post '/visit' do
	@user_name = params[:username].strip.capitalize
	@user_phone = params[:user_telephone].strip
	@date_visit = params[:date_].strip
	@time_visit = params[:time_].strip
	@master = params[:master].strip
	if @user_name == ''
		@name_error = 'Не указано имя'
		erb :visit
	elsif @master == 'Выберите мастера'
		@master_error = 'Не указан мастер'
		erb :visit	
	elsif @date_visit == ''
		@date_error = 'Не указана дата'
		erb :visit								
	elsif @time_visit == ''
		@time_error = 'Не указано время'
		erb :visit									
	else
		arr = []
		arr << @user_name
		arr << @user_phone
		arr << @date_visit
		arr << @time_visit
		arr << @master
		w_to_f arr
		if @user_phone != ''
			@reminder = "Мы перезвоним Вам по номеру: #{@user_phone}, \nчтобы напомнить о визите"
		end				
		erb :visit_done
	end
end	

post '/contacts' do
	@e_mail = params[:email].strip
	@e_message = params[:text].strip
	if @e_mail == ''
		@e_holder = "Не указан e-mail"		
	elsif @e_message == ''		
		@mess = "Напишите хоть что-нибудь.."	
	else
		@mess = "Сообщение успешно отправлено!"	
		arr = []
		arr << @e_mail
		arr << @e_message
		w_to_c arr
	end	
	erb :contacts
end	