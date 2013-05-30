module ApplicationHelper


    def to_min_sec(float)
      minutes = (float/60).floor.to_s
      seconds = (float%60).round(0).to_s
      seconds = '0' + seconds if seconds.to_i < 10
      return "#{minutes}:#{seconds}"
    end

    def meters_to_km(meters)
      kilometers = meters/1000
      return kilometers
    end

    def meters_to_miles(meters)
      miles = meters * 0.000621371192
      return miles
    end

    def weekly_total_distance(activities, type)
      weekly_total_distance = 0
      activities.each do |activity|
        #if activity['type'] == type || activity['type'] == 'Cycling' || activity['type'] == 'Running'
          weekly_total_distance += activity['total_distance']
        #end
      end
        return weekly_total_distance
    end

end

