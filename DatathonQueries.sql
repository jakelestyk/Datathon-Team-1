-- Group total earnings

SELECT
    SUM(CASE WHEN alaskan_native_corporation_owned_firm = 't' THEN potential_total_value_of_award ELSE NULL END) AS Alaskan_native_corporation_owned_firm,
    SUM(CASE WHEN american_indian_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS American_indian_owned,
    SUM(CASE WHEN indian_tribe_federally_recognized = 't' THEN potential_total_value_of_award ELSE NULL END) AS Indian_tribe_federally_recognized,
    SUM(CASE WHEN native_hawaiian_organization_owned_firm = 't' THEN potential_total_value_of_award ELSE NULL END) AS Native_hawaiian_organization_owned_firm,
    SUM(CASE WHEN tribally_owned_firm = 't' THEN potential_total_value_of_award ELSE NULL END) AS Tribally_owned_firm,
    SUM(CASE WHEN veteran_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Veteran_owned_business,
    SUM(CASE WHEN service_disabled_veteran_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Service_disabled_veteran_owned_business,
    SUM(CASE WHEN woman_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Woman_owned_business,
    SUM(CASE WHEN women_owned_small_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Women_owned_small_business,
    SUM(CASE WHEN economically_disadvantaged_women_owned_small_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Economically_disadvantaged_women_owned_small_business,
    SUM(CASE WHEN joint_venture_women_owned_small_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Joint_venture_women_owned_small_business,
    SUM(CASE WHEN joint_venture_economic_disadvantaged_women_owned_small_bus = 't' THEN potential_total_value_of_award ELSE NULL END) AS Joint_venture_economic_disadvantaged_women_owned_small_bus,
    SUM(CASE WHEN minority_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Minority_owned_business,
    SUM(CASE WHEN subcontinent_asian_asian_indian_american_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Subcontinent_asian_asian_indian_american_owned_business,
    SUM(CASE WHEN asian_pacific_american_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Asian_pacific_american_owned_business,
    SUM(CASE WHEN black_american_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Black_american_owned_business,
    SUM(CASE WHEN hispanic_american_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Hispanic_american_owned_business,
    SUM(CASE WHEN native_american_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Native_american_owned_business,
    SUM(CASE WHEN other_minority_owned_business = 't' THEN potential_total_value_of_award ELSE NULL END) AS Other_minority_owned_business
FROM datathon_team_1;

-- Funding Office Data

SELECT
	funding_office_name,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_contracts,
    SUM(potential_total_value_of_award)/COUNT(contract_transaction_unique_key) AS average_contract_price
FROM datathon_team_1
GROUP BY funding_office_name
ORDER BY money_given DESC;

-- Award Reason

SELECT
	object_classes_funding_this_award AS award_reason,
    SUM(potential_total_value_of_award) AS money_given
FROM datathon_team_1
GROUP BY object_classes_funding_this_award
ORDER BY money_given DESC;

-- Award Reason #2

SELECT
	program_activities_funding_this_award AS activities,
    SUM(potential_total_value_of_award) AS money_given
FROM datathon_team_1
WHERE program_activities_funding_this_award != " "
GROUP BY program_activities_funding_this_award

ORDER BY money_given DESC
LIMIT 20;

-- States
SELECT
	recipient_state_name AS state,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_contracts,
    SUM(potential_total_value_of_award)/COUNT(contract_transaction_unique_key) AS money_per_award
FROM datathon_team_1
GROUP BY recipient_state_name
ORDER BY money_given DESC;

-- Republican vs Democrat States
SELECT
	SUM(CASE WHEN recipient_state_name IN ('alabama', 'alaska', 'arkansas', 'florida', 'idaho', 'indiana', 'Iowa', 'kansas',
    'Kentucky', 'Louisiana', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'North Dakota', 'Ohio', 'Oklahoma',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'West Virginia', 'Wyoming') THEN potential_total_value_of_award
    ELSE NULL END) AS republican,
    COUNT(CASE WHEN recipient_state_name IN ('alabama', 'alaska', 'arkansas', 'florida', 'idaho', 'indiana', 'Iowa', 'kansas',
    'Kentucky', 'Louisiana', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'North Dakota', 'Ohio', 'Oklahoma',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'West Virginia', 'Wyoming') THEN contract_transaction_unique_key
    ELSE NULL END) AS republican_contracts,
    SUM(CASE WHEN recipient_state_name IN ('California', 'Colorado', 'Connecticut', 'Delaware', 'Hawaii', 'Illinois', 'Maine', 'Maryland',
    'Massachusetts', 'Michigan', 'Minnesota', 'Nevada', 'New Hampshire', 'New York', 'Oregon', 'Rhode Island', 'Vermont',
    'Virginia', 'Washington') THEN potential_total_value_of_award ELSE NULL END) AS democrat,
    COUNT(CASE WHEN recipient_state_name IN ('California', 'Colorado', 'Connecticut', 'Delaware', 'Hawaii', 'Illinois', 'Maine', 'Maryland',
    'Massachusetts', 'Michigan', 'Minnesota', 'Nevada', 'New Hampshire', 'New York', 'Oregon', 'Rhode Island', 'Vermont',
    'Virginia', 'Washington') THEN contract_transaction_unique_key ELSE NULL END) AS democrat_contracts,
    SUM(CASE WHEN recipient_state_name IN ('California', 'Colorado', 'Connecticut', 'Delaware', 'Hawaii', 'Illinois', 'Maine', 'Maryland',
    'Massachusetts', 'Michigan', 'Minnesota', 'Nevada', 'New Hampshire', 'New York', 'Oregon', 'Rhode Island', 'Vermont',
    'Virginia', 'Washington') THEN potential_total_value_of_award ELSE NULL END) - 
    SUM(CASE WHEN recipient_state_name IN ('alabama', 'alaska', 'arkansas', 'florida', 'idaho', 'indiana', 'Iowa', 'kansas',
    'Kentucky', 'Louisiana', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'North Dakota', 'Ohio', 'Oklahoma',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'West Virginia', 'Wyoming') THEN potential_total_value_of_award
    ELSE NULL END) AS democract_differential
FROM datathon_team_1;


-- Award Type
SELECT
	award_type,
    SUM(potential_total_value_of_award) AS money_given
FROM datathon_team_1
GROUP BY award_type
ORDER BY money_given DESC;

-- Contract Pricing
SELECT
	type_of_contract_pricing AS contract_pricing,
    SUM(potential_total_value_of_award) AS money_given
FROM datathon_team_1
GROUP BY type_of_contract_pricing
ORDER BY money_given DESC;

-- Domestic?
SELECT
	domestic_or_foreign_entity AS Domestic_or_foreign,
    SUM(potential_total_value_of_award) AS money_given
FROM datathon_team_1
GROUP BY domestic_or_foreign_entity 
ORDER BY money_given DESC;

-- Epa Designated?
SELECT
	epa_designated_product AS epa_designation,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_awards
FROM datathon_team_1
GROUP BY epa_designated_product 
ORDER BY money_given DESC;

-- Subcontracting Plan
SELECT
	subcontracting_plan,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_awards
FROM datathon_team_1
GROUP BY subcontracting_plan
ORDER BY money_given DESC;

-- Competition
SELECT
	extent_competed,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_awards
FROM datathon_team_1
GROUP BY extent_competed
ORDER BY money_given DESC;

-- solicitation
SELECT
	solicitation_procedures,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_awards
FROM datathon_team_1
GROUP BY solicitation_procedures
ORDER BY money_given DESC;

-- multi year contract
SELECT
	COUNT(CASE WHEN multi_year_contract = 'YES' THEN contract_transaction_unique_key ELSE NULL END)/COUNT(contract_transaction_unique_key) * 100 AS multi_year_contract_percentage
FROM datathon_team_1;

-- business size
SELECT
	contracting_officers_determination_of_business_size,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_awards,
    SUM(potential_total_value_of_award)/COUNT(contract_transaction_unique_key) AS money_per_award
FROM datathon_team_1
GROUP BY contracting_officers_determination_of_business_size
ORDER BY money_given DESC;

-- Org type
SELECT
	organizational_type,
    SUM(potential_total_value_of_award) AS money_given,
    COUNT(contract_transaction_unique_key) AS number_of_awards
FROM datathon_team_1
GROUP BY organizational_type
ORDER BY money_given DESC;

-- profit type
SELECT
	COUNT(CASE WHEN for_profit_organization = 't' THEN contract_transaction_unique_key ELSE NULL END) AS total_for_profit,
	SUM(CASE WHEN for_profit_organization = 't' THEN potential_total_value_of_award ELSE NULL END) AS for_profit_dollars,
    COUNT(CASE WHEN nonprofit_organization = 't' THEN contract_transaction_unique_key ELSE NULL END) AS total_nonprofit,
    SUM(CASE WHEN nonprofit_organization = 't' THEN potential_total_value_of_award ELSE NULL END) AS nonprofit_dollars
FROM datathon_team_1;
