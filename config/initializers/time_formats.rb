Time::DATE_FORMATS[:default_date_time] = lambda { |time| time.strftime("%d/%m/%Y %I:%M %p") }
Time::DATE_FORMATS[:default_date] = lambda { |time| time.strftime("%d/%m/%Y") }
Time::DATE_FORMATS[:default_time] = lambda { |time| time.strftime("%H:%M") }