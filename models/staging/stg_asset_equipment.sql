SELECT
    equipment_id,
    asset_type,
    installation_date,
    last_maintenance_date,
    CAST(maintenance_interval_days AS NUMERIC) as maintenance_interval_days,
    location_id,
    status,
    DATE_ADD(last_maintenance_date, INTERVAL maintenance_interval_days DAY) as next_maintenance_due
FROM {{ ref('raw_equipment_assets') }}