# Throughout this document 'a_' is used instead of 'attendee_' in variable naming
require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def legislators_by_zipcode(zipcode)	
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def clean_zipcode(zipcode)	
	zipcode.to_s.rjust(5, "0")[0..4]
end

def digits_from_phone_number(phone_number)
	phone_number.to_s.scan(/\d/).join('')
end

def clean_phone_number(phone_number)
	clean_number = digits_from_phone_number(phone_number) 
	
	if clean_number.length == 10
		clean_number
	elsif clean_number.length == 11 && clean_number[0] == '1'
		clean_number[1..10]
	else
		"0" * 10
	end
end

def save_thank_you_letter(id, thank_you_letter)
	Dir.mkdir("output") unless Dir.exists?("output")
	
	filename = "output/thanks#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts thank_you_letter
	end
end

def save_contact_details(id, name,phone_number)

	# The two mkdir statements could be changed with FileUtils.mkdir_p
	Dir.mkdir("output") unless Dir.exists?("output")
	Dir.mkdir("output/contact") unless Dir.exists?("output/contact")

	filename = "output/contact/details#{id}"
	
	# An error message might be shown when phone number is 10 * '0'
	File.open(filename, 'w') do |file|
		file.puts "Name: #{name}"
		file.puts "Phone number: #{phone_number}"
	end
end

def open_csv_file
	attendees_file = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
	attendees_file.rewind
	attendees_file
end

def open_erb_template
	template_letter = File.read "form_letter.erb"
	erb_template = ERB.new template_letter
end

def generate_thank_you_letters
	puts "Generating thank you letters for our attendees"
	
	erb_template = open_erb_template

	open_csv_file.each do |row|
	       	puts "..."	
		# legislators required for erb template reference
		a_zipcode = clean_zipcode(row[:zipcode])	
		legislators_of_attendee = legislators_by_zipcode(a_zipcode)	
		
		# attendee_name required for erb template reference
		a_name = row[:first_name]
		thank_you_letter = erb_template.result(binding)	

		a_id = row[0]
		save_thank_you_letter(a_id, thank_you_letter)
	end
	puts "Thank you letters done!"
end

def generate_contact_details
	puts "Generating contact details for our attendees"
	open_csv_file.each do |row|
		a_id = row[0]
		a_name = row[:first_name] 
		a_raw_phone_number = row[:homephone]
		a_clean_phone_number = clean_phone_number(a_raw_phone_number)

		save_contact_details(a_id, a_name, a_clean_phone_number)
	end
	puts "Contact details succesfully generated!"
end

# DO NOT USE THIS METHOD WHEN THE DATE REPRESENTATION STRING IS NOT OF THE FOLLOWING PATTERN:
# date representation given as 'month/day/year hour:minutes'
# reorder date representation to 'year/month/day hour:minutes:seconds+timezone'
def format_date(raw_date_string)
	
	# date string ending in minutes; append seconds and assume UTC time zone
	raw_date_string << ":00+00"

	# split date string into  month/day/year and hour:minutes:seconds+timezone
	date_parts = raw_date_string.split(" ")		

	# split month/day/year 
	month_day_year = date_parts[0].split('/')
	month = month_day_year[0]
	day = month_day_year[1]
	# given years are all '08', presuming 2008 	
	year = "20" + month_day_year[2]
	
	# reorder and replace '/' with '-'
	year_month_date = [year, month, day].join('-')

	hour_minutes_seconds = date_parts[1]		
	
	formatted_date = year_month_date + "T" + hour_minutes_seconds	
end

def get_hour(validated_date)
	validated_date.hour
end

def get_date(date_string)
	DateTime.strptime(format_date(date_string)) 
end
def find_best_hour_for_advertising

	hours_table = Hash.new(0)	
	open_csv_file.each do |row|	
		raw_registration_date = row[:regdate]
		validated_date = get_date(raw_registration_date)
		a_registration_hour = get_hour(validated_date)
		hours_table[a_registration_hour] += 1
	end
	
	hours_table.max_by {|k, v| v}.first.to_s + ":00"
end

def find_week_day_with_most_registrations
	day_table = Hash.new(0)
	open_csv_file.each do |row|
		raw_registration_date = row[:regdate]
		validated_date = DateTime.strptime(format_date(raw_registration_date))
		a_registration_day = validated_date.wday
		day_table[a_registration_day] += 1
	end

	day_as_integer = day_table.max_by {|k, v| v}.first
	Date::DAYNAMES[day_as_integer]
end
puts "Event Manager intialized!"
generate_thank_you_letters
generate_contact_details
puts "Check out the 'output' folder! ;)" 
puts "The day most people tend to register is: #{find_week_day_with_most_registrations}" 
puts "Best hour for advertising is: " + find_best_hour_for_advertising
