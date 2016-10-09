-- Want the best hospitals in the country, defined
-- as those with the best average measures (procedures) score.
-- But we require the average score to have at least 15 measurments
-- to be considered, as some hospitals report too little data for
-- the average score to be meaningful
select hospitals.hospital_name, hospital_score.average_of_scores, hospital_score.sd_of_scores, hospital_score.number_of_scores
from hospital_score join hospitals on hospital_score.hid == hospitals.provider_id
order by hospital_score.average_of_scores DESC limit 10;
