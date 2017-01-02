json.place entrant.overall_place
json.time format_hours entrant.secs
json.last_name entrant.last_name
json.first_name entrant.first_name
json.bib entrant.bib
json.city entrant.city
json.state entrant.state
json.gender entrant.racer_gender
json.gender_place entrant.gender_place
json.group entrant.group_name
json.group_place entrant.group_place
json.swim format_hours entrant.swim_secs
json.pace_100 format_minutes entrant.swim_pace_100
json.t1 format_minutes entrant.t1_secs
json.bike format_hours entrant.bike_secs
json.mph format_mph entrant.bike_mph
json.t2 format_minutes entrant.t2_secs
json.run format_hours entrant.run_secs
json.mmile format_minutes entrant.run_mmile
json.result_url api_race_result_path(entrant.race.id, entrant)
json.racer_url api_racer_path(entrant.racer.id) unless entrant.racer.id.nil?