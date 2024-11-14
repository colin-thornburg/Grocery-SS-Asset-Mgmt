SELECT
    a.equipment_id,
    a.asset_type,
    a.next_maintenance_due,
    fs.avg_ticket_duration as typical_service_time,
    fs.completion_rate as service_success_rate,
    CASE 
        WHEN DATE_DIFF(a.next_maintenance_due, CURRENT_DATE(), DAY) <= 7 THEN 'Urgent'
        WHEN DATE_DIFF(a.next_maintenance_due, CURRENT_DATE(), DAY) <= 30 THEN 'Planning'
        ELSE 'On Track'
    END as maintenance_priority
FROM {{ ref('stg_asset_equipment') }} a
LEFT JOIN {{ ref('Supply_Chain_Field_Services', 'mart_daily_service_performance') }} fs
    ON DATE(fs.service_date) = a.last_maintenance_date